#!/usr/bin/env python3
"""Turns textures made for the original KOTOR 2 (.tga, and the game's own kind of .dds) into .png files the remake uses
as they are, for a mod's textures/ folder.

    python3 tools/kotor_texture_to_png.py <file or folder> [more...] [--out <folder>]

Each picture keeps its name in lower case (plc_desk1.tga -> plc_desk1.png), written beside it or into --out. Needs
Pillow (python3 -m pip install pillow).

What it takes care of:
- A .tga can be stored bottom row first or top row first. Both come out the right way up.
- KOTOR's .dds files aren't ordinary DDS: they have the game's own 20-byte header. Both kinds are read.
- Two props show their texture flipped in the remake (plc_desk1 and plc_comppnl_b); those are flipped to match.
- .tpc files (the game's packed textures) aren't read: export them to .tga with a KOTOR texture tool first.
A .txi beside a texture is left alone: the remake uses the game's own TXI settings (transparency, animation).
"""
import argparse
import io
import struct
import sys
from pathlib import Path

FLIPPED = {"plc_desk1", "plc_comppnl_b"}      # the same list as the game's texture conversion
KINDS = (".tga", ".dds")


def read_picture(path):
    from PIL import Image
    raw = path.read_bytes()
    if path.suffix.lower() == ".dds" and raw[:4] != b"DDS ":
        # BioWare's DDS: width, height, 3 (DXT1) or 4 (DXT5), the top picture's size, a float, then the blocks.
        # Given a standard DDS header in front, Pillow decodes it.
        w, h, kind, size = struct.unpack("<IIII", raw[:16])
        header = (b"DDS " + struct.pack("<7I", 124, 0x1 | 0x2 | 0x4 | 0x1000 | 0x80000, h, w, size, 0, 1) + b"\0" * 44
                  + struct.pack("<2I", 32, 0x4) + (b"DXT5" if kind == 4 else b"DXT1") + b"\0" * 20
                  + struct.pack("<I", 0x1000) + b"\0" * 16)
        raw = header + raw[20:20 + size]
    picture = Image.open(io.BytesIO(raw))     # Pillow reads a TGA's origin flag, so either kind is upright here
    picture.load()
    return picture


def convert(path, out_dir):
    from PIL import Image
    name = path.stem.lower()
    picture = read_picture(path)
    if name in FLIPPED:
        picture = picture.transpose(Image.FLIP_TOP_BOTTOM)
    if picture.mode not in ("RGB", "RGBA"):
        picture = picture.convert("RGBA" if "A" in picture.getbands() or picture.mode == "P" else "RGB")
    target = (out_dir or path.parent) / (name + ".png")
    target.parent.mkdir(parents=True, exist_ok=True)
    picture.save(target)
    return target


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("inputs", nargs="+", type=Path, help="pictures, or folders of them")
    ap.add_argument("--out", type=Path, help="where the .png files go (default: beside each picture)")
    args = ap.parse_args()
    try:
        import PIL  # noqa: F401
    except ImportError:
        sys.exit("Pillow is needed: python3 -m pip install pillow")
    files = []
    for p in args.inputs:
        if p.is_dir():
            files += sorted(f for f in p.iterdir() if f.suffix.lower() in KINDS)
        elif p.suffix.lower() == ".tpc":
            print("skipped %s: export .tpc files to .tga with a KOTOR texture tool first" % p.name)
        elif p.exists():
            files.append(p)
        else:
            print("not found: %s" % p)
    done = 0
    for f in files:
        try:
            print("%s -> %s%s" % (f.name, convert(f, args.out).name, "  (flipped, as the game shows it)" if f.stem.lower() in FLIPPED else ""))
            done += 1
        except Exception as e:      # one bad file shouldn't stop the rest
            print("couldn't read %s: %s" % (f.name, e))
    print("%d of %d converted" % (done, len(files)))
    sys.exit(0 if done == len(files) else 1)


if __name__ == "__main__":
    main()
