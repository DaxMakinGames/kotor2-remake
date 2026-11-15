# Texture overhauls

A texture overhaul replaces the game's textures without a script. Give the mod a `textures` folder:

```json
{
  "id": "my_hd_pack",
  "name": "My HD pack",
  "version": "1.0.0",
  "api": 1,
  "entry": "",
  "textures": "textures"
}
```

```
mods/my_hd_pack/
  mod.json
  textures/
    plc_desk1.png
    per_floor01.png
```

Each picture replaces the game's texture with the **same name** (lower case, without the extension) everywhere it's
used: rooms, lightmaps, props, characters and weapons. Turn the mod off on the Mods screen and the standard
textures come back.

## Which one wins

If two mods replace the same texture, the one later in the load order wins. Use `load_after` to put yours after
another pack, the way Vanilla Characters HD loads after Planets HD.

## Packing it

Pack an overhaul with `modding/tools/pack_art_mod.py` (see [Packing and sharing](../getting-started/packing.md)):

```bash
python3 tools/pack_art_mod.py path/to/my_hd_pack
```

Godot then imports the pictures with mipmaps and VRAM compression, as it does the game's own. At four times the size,
an uncompressed HD texture takes sixteen times the memory.

A plain folder mod works too, but its pictures are read uncompressed every time the game starts.

## Getting the picture right

- Keep the original texture's orientation. Two prop textures, `plc_desk1` and `plc_comppnl_b`, are stored flipped
  by the pipeline: flip your replacement the same way.
- A texture's TXI settings (transparency, animation) still come from the game's original, so keep the alpha channel
  where the original has one.

## The HD packs

**Planets HD** and **Vanilla Characters HD** are made into two overhaul mods on your computer when Setup builds the
game: `planets_hd.zip` and `characters_hd.zip`, in the `mods` folder beside the game. They're built from your own
downloads of those mods, so they aren't shared with the game.
