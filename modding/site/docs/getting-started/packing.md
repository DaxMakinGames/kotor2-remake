# Packing and sharing

Players get one `.zip` and drop it into the `mods` folder beside the game. That's all they do: no unzipping.

Inside the zip, everything sits under `mods/<id>/`. That's where the game mounts it, so your files are at
`res://mods/<id>/...` while the mod is on. A mod that's off isn't mounted at all, so it can never replace anything.

## Which tool to use

| Your mod has | Pack it with |
|---|---|
| Only scripts (`main.gd`) and JSON | `tools/pack_mod.sh` |
| Pictures: textures, icons, a texture overhaul | `tools/pack_art_mod.py` (needs Godot 4.7) |

Both are in the game's project folder and write `<id>.zip` to `dist/` beside your mod folder. Give a second argument
to put it somewhere else.

### A mod of scripts and data

```bash
tools/pack_mod.sh path/to/my_mod
```

This is a plain zip: the game reads `main.gd` and JSON straight from it.

### A mod with pictures

```bash
python3 tools/pack_art_mod.py path/to/my_mod
python3 tools/pack_art_mod.py path/to/my_mod --godot "/Applications/Godot.app/Contents/MacOS/Godot"
```

In an exported game, Godot loads pictures from its **import cache**, not the `.png` files, so a plain zip of pictures
doesn't work. `pack_art_mod.py`:

1. Makes a small Godot project around your mod, with the game's import settings: mipmaps, and VRAM compression
   (an HD texture uncompressed takes sixteen times the memory).
2. Imports it with Godot and exports it as a `.zip`.
3. Keeps only your mod's files and their imports. Godot's export also adds its own project files, which would lay
   over the game's.

Setup packs the HD texture mods the same way. Your script loads its pictures the same way from a zip or a folder:

```gdscript
var tex := Kotor.mods.texture(mod_path("textures/my_robe.png"))
```

### By hand

Put your mod folder inside a folder called `mods`, and zip that `mods` folder. This works only for mods without
pictures.

## What happens when a player installs it

1. The game reads `mods/<id>/mod.json` straight from the zip, without mounting anything.
2. If the mod is **on**, the zip is mounted and `main.gd` runs.
3. If the mod is **off**, nothing in it is mounted.

## Replacing the game's files

A zip can carry files at the game's own paths, which replace them while the mod is on: scripts, scenes, `.tres`
resources such as `res://data/tuning.tres`, and JSON. List every file you replace in `replaces` in `mod.json`, so the
Mods screen can warn when two mods replace the same one.

Textures are replaced **by name**, not by path: see [Texture overhauls](../guides/textures.md). Models, sounds and
conversations can't be replaced yet ([Current limitations](limitations.md)).

Prefer adding to replacing: a replaced file can only come from one mod, while added items and hooks combine freely.

## Before you share it

- [ ] `version` in `mod.json` raised since your last release
- [ ] It loads from the `.zip` in an exported game, not only from the editor
- [ ] With it switched off, the game is back to normal
- [ ] Your description says which mods it needs or can't run with (`load_after`, `conflicts`)
- [ ] You credit everyone whose work you used, and have their permission to share it
- [ ] No files from the original game are in the zip

## Sizes

Keep pictures as `.webp` (lossy, quality about 90) or `.png`. A 2048 × 3072 robe texture is about 1 MB as WebP and
24 MB as TGA. The game reads WebP, PNG, JPG and TGA.
