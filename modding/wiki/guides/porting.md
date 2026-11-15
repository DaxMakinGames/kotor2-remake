# Bring a KOTOR mod over

Mods for the original KOTOR 2 are files dropped in its `Override` folder: textures, models, sounds, conversations,
tables and scripts. The remake doesn't read `Override`, but much of what those mods change can be made into a remake
mod. This page says what carries over, and how.

**Only port what you made, or what its author lets you share.** A port is still their work: credit them in your
`mod.json` description and on its page.

| In the KOTOR mod | In a remake mod | How |
|---|---|---|
| Textures (`.tga`, `.dds`) | `textures/*.png` | `modding/tools/kotor_texture_to_png.py`, below |
| Textures (`.tpc`) | `textures/*.png` | Export to `.tga` with a KOTOR texture tool, then as above |
| Texture settings (`.txi`) | Not used | The remake keeps the game's own (transparency, animation) |
| Models (`.mdl` + `.mdx`) | `models/*.glb` | Import into Blender with KotorBlender, export glTF, below |
| Voices, sounds, music (`.wav`, `.mp3`) | `sounds/*.ogg` or `.wav` | Convert, keep the name, below |
| Conversations (`.dlg`) | `conversations/*.dialogue` | Not converted yet: written by hand, below |
| Table changes (`.2da`), TSLPatcher installers | A script with hooks | Not read: change the rule through a hook instead |
| Scripts (`.ncs`, `.nss`) | A script with hooks or `script_function` | Not read: see below |

## Textures

1. Convert the mod's pictures. Name a folder, or the files, and where the `.png` files go:

    ```
    python3 modding/tools/kotor_texture_to_png.py "Some Mod/Override" --out my_mod/textures
    ```

    It needs Pillow (`python3 -m pip install pillow`). It reads both kinds of `.tga` the right way up, reads KOTOR's
    own `.dds` files (which ordinary image tools can't open: the game gave them a header of its own), and flips the two
    props the remake shows flipped, `plc_desk1` and `plc_comppnl_b`. Each file keeps its name in lower case.

2. Name the folder in `mod.json`:

    ```json
    { "id": "my_mod", "name": "My Mod", "version": "1.0.0", "api": 1, "entry": "", "textures": "textures" }
    ```

3. Pack it with `modding/tools/pack_art_mod.py my_mod`, so the pictures are compressed like the game's.

**If a picture comes out upside down**, it was saved the other way round from the original. Flip it in any image editor:
the remake uses a `.png` as it looks in an image viewer.

**Animated textures** (screens, flowing water) are a grid of frames in one picture, played by the game's `.txi`. A
replacement must keep the original's grid (the same number of frames across and down), since the remake plays it with
the original's settings.

**Lightmaps** (`*_lm*` textures, a room's baked light) are replaced the same way, by name.

## Models

The remake reads glTF (`.glb`), not KOTOR's `.mdl`/`.mdx`.

1. Install **KotorBlender** (a Blender add-on for KOTOR models) and import the mod's `.mdl`.
2. Export it from Blender as **glTF Binary (`.glb`)**, named like the game's model: `plc_footlker.glb`,
   `w_blstrpstl_001.glb`.
3. Put it in the mod's `models/` folder and name that folder in `mod.json` (`"models": "models"`).

- **Keep the mesh names.** A mesh named as in the original gets the game's textures and lightmaps; any other mesh is
  drawn with the material it was exported with.
- **Characters keep the original skeleton.** Bone names must match the game's, or its animations won't fit.
- **Rooms change how they look, not where you can walk.** The walkable floor is the game's own walkmesh.

## Sounds

Put each file in `sounds/` under the game's name for it (lower case): a voice line by its resref (`101101atton001`), an
effect or a music track by its own. `.ogg`, `.wav` and `.mp3` are read.

Some of the original's `.wav` files are really MP3s with an extra header in front, which a `.wav` reader can't open.
If one won't play, convert it to `.ogg` (for example with Audacity, or `ffmpeg -i in.wav out.ogg`).

## Conversations

A `.dlg` can't be read as it is. The remake's conversations are `.dialogue` text files, one per conversation, which
Setup makes from the player's own game and packs into the game's data. **A copy you can edit isn't available from an
installed game yet**, so for now a replacement has to be written in that format by hand; working in the remake's own
Godot project, the game's versions are in `import/kotor/dialogue/`. Each line calls `Kotor.on_line(...)` for its voice
and camera. Put the file in `conversations/` under the conversation's name (`101atton.dialogue`).

## Table changes and patchers

Mods that change the game's tables (`feat.2da`, `spells.2da`, `baseitems.2da`) through TSLPatcher aren't read. Most of
what they do is a rule, and rules can be changed with hooks:

| The KOTOR mod changes | The remake mod uses |
|---|---|
| A Force power's cost | `force_cost` |
| Damage, accuracy, defense | `damage_dealt`, `attack_bonus`, `defense` |
| Experience | `xp_award` |
| A skill bonus | `skill` |
| What can be equipped | `can_equip` |
| A new item | `add_item()` ([Adding items](items.md)) |

A few community mods are built into the game itself, applied by Setup from the player's own download. That list is
fixed: other patchers can't be added that way.

## Scripts

The remake runs the original's compiled scripts, but not a mod's replacements for them. To change what a script does,
wrap the NWScript function it calls with `script_function` ([Replacing script functions](script-functions.md)), or
react to the game with hooks and events ([Recipes](recipes.md)).
