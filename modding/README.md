# Modding

- **[The modding wiki](wiki/index.md)**: start with [Your first mod](wiki/getting-started/first-mod.md),
  [Recipes](wiki/guides/recipes.md) and [Bring a KOTOR mod over](wiki/guides/porting.md). Every hook has a page in
  [wiki/reference/hooks](wiki/reference/hooks/index.md).
- **[examples/starter](examples/starter)**: the Starter Mod, a template to copy and edit (a setting, a hook, events,
  saved state). Setup also puts it in the `mods` folder beside the game. It starts switched off.
- **[tools](tools)**:
  - `pack_mod.sh <mod folder>`: packs a mod of scripts and JSON into `<id>.zip`.
  - `pack_art_mod.py <mod folder>`: packs a mod with pictures, models or sounds through Godot 4.7's import.
  - `kotor_texture_to_png.py <files or folder> --out <mod>/textures`: textures made for the original game, as `.png`
    files the right way up (needs Pillow).

The short guide is [MODDING.md](../MODDING.md).
