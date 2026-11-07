#!/usr/bin/env python3
"""Packs a mod that has pictures or other art into <id>.zip, imported the way the game's own files are.

    python3 tools/pack_art_mod.py <mod folder> [out dir] [--godot /path/to/Godot]

A plain zip (tools/pack_mod.sh) is enough for a mod of scripts and JSON. Pictures need Godot's import: in an exported
game, textures load from Godot's import cache, with mipmaps and VRAM compression. This makes a small Godot project
around the mod (installer/mod_project: every texture VRAM-compressed, with mipmaps), imports it with Godot 4.7, exports
it as a .zip, and keeps only the mod's files and their imports. It's what Setup does for the HD texture mods.
"""
import argparse, json, shutil, sys, tempfile
from pathlib import Path

import subprocess, zipfile
HERE = Path(__file__).resolve().parent
# the texture-mod project template: installer/mod_project in the game's project, or mod_project/ beside this script
TEMPLATE = next((p for p in (HERE.parent / "installer" / "mod_project", HERE / "mod_project") if (p / "project.godot").exists()), None)


def strip_project_files(zip_path):
    """keep only the mod's files and their imports: Godot's export also adds its project files, which would lay
    over the game's own (the same as install.py's)"""
    tmp = zip_path.with_suffix(".tmp")
    with zipfile.ZipFile(zip_path) as src, zipfile.ZipFile(tmp, "w", zipfile.ZIP_STORED) as dst:
        for item in src.infolist():
            if item.filename.startswith("mods/") or item.filename.startswith(".godot/imported/"):
                dst.writestr(item, src.read(item.filename))
    tmp.replace(zip_path)

ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
ap.add_argument("mod", help="the mod's folder (with its mod.json)")
ap.add_argument("out", nargs="?", help="where to put <id>.zip (default: dist/ beside the mod folder)")
ap.add_argument("--godot", default="/Applications/Godot.app/Contents/MacOS/Godot", help="Godot 4.7 (the editor)")
a = ap.parse_args()
if TEMPLATE is None:
    sys.exit("the mod_project template wasn't found beside this script")

src = Path(a.mod).resolve()
info = json.loads((src / "mod.json").read_text())
mod_id = info["id"]
out = Path(a.out).resolve() if a.out else src.parent / "dist"
out.mkdir(parents=True, exist_ok=True)
with tempfile.TemporaryDirectory() as tmp:
    project = Path(tmp)
    for f in ("project.godot", "export_presets.cfg"):
        shutil.copy2(TEMPLATE / f, project / f)
    shutil.copytree(src, project / "mods" / mod_id, ignore=shutil.ignore_patterns(".DS_Store", "dist", "*.import", ".godot"))
    r = subprocess.run([a.godot, "--headless", "--path", str(project), "--import"], capture_output=True, text=True)
    if r.returncode != 0:
        sys.exit("Godot's import failed:\n" + r.stdout[-2000:] + r.stderr[-2000:])
    zip_path = out / (mod_id + ".zip")
    r = subprocess.run([a.godot, "--headless", "--path", str(project), "--export-pack", "Mod pack", str(zip_path)], capture_output=True, text=True)
    if r.returncode != 0 or not zip_path.exists():
        sys.exit("Godot couldn't pack it:\n" + r.stdout[-2000:] + r.stderr[-2000:])
    strip_project_files(zip_path)
    # the icon and pictures as they are too: the Mods screen reads them straight from the zip, even while it's off
    with zipfile.ZipFile(zip_path, "a") as z:
        have = set(z.namelist())
        for rel in [info.get("icon", "")] + list(info.get("pictures", [])):
            if rel and (src / rel).is_file() and "mods/%s/%s" % (mod_id, rel) not in have:
                z.write(src / rel, "mods/%s/%s" % (mod_id, rel))
print("%s (%.1f MB): drop it in the mods folder beside the game" % (zip_path, zip_path.stat().st_size / 1e6))
