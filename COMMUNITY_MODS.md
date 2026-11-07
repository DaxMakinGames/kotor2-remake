# Community mods

The remake is built from your own copy of KOTOR 2 plus a few community mods you download yourself. Nothing from these
mods is in this repository or in the installer: Setup reads your downloads on your own computer.

**Contents:** [Required](#required) · [Helpful, but not required](#helpful-but-not-required) ·
[About permission](#about-permission) · [How each mod is used](#how-each-mod-is-used) (technical)

## Required

| Mod | By | Get it |
|---|---|---|
| TSLRCM 1.8.6 (The Sith Lords Restored Content Mod) | Zbyl2, DarthStoney, Hassat Hunter & VarsityPuppet | [GameBanana (Switch build)](https://gamebanana.com/mods/617353) |

**Why TSLRCM is required.** TSLRCM fixes hundreds of the original game's bugs and restores cut content. The remake
runs the game's own levels and scripts, so it's built from the fixed versions: without TSLRCM, the demo would have the
original's broken scripts and missing scenes.

**Why the Switch build.** It's the only build of TSLRCM I could find as a plain `.zip` download, with its files
ready to read. The usual PC version installs with a patcher program into your game folder, which the installer
can't use without changing your game. The Switch build holds the same levels: for the demo's ten levels, its
level files, lip-sync files and voices are byte-for-byte the same as the PC build's.

**Why the installer accepts both.** Choosing the Switch build meant teaching the pipeline its layout, so either works:
- **The Switch build** (`romfs` inside): what the link above gives you. The installer lays it out like the PC
  build and makes two changes so the game plays the same:
  - It leaves out two of its scripts, `a_con_atton_end` and `a_playpermov`. On Switch these replace the Harbinger's
    arrival scene with a movie; without them the game's own in-game scene plays, as on PC.
  - Game text lines that name controller buttons (like `<abutton>`) are taken from the PC game instead.
- **The PC/mobile build** (`dlc/mods_english` inside), if you already have it.

Unzip it anywhere in your Downloads folder: Setup finds it by what's inside, whatever the folder is called.

## Helpful, but not required

These make the demo look better. Setup uses whichever ones it finds and skips the rest. The HD packs become mods in
the game's `mods` folder that you can switch off at any time, so the game itself always keeps the standard textures.

| Mod | By | What it adds | Get it |
|---|---|---|---|
| Vanilla Planets HD | Saul0097 | Sharper world textures: walls, floors, screens and panels (up to 4×) | [Deadly Stream](https://deadlystream.com/files/file/2976-vanilla-planets-hd/) |
| Vanilla Characters HD (Optimized) | Saul0097 | Sharper character textures: bodies, heads, robes, droids (up to 4×) | [Deadly Stream](https://deadlystream.com/files/file/2987-vanilla-characters-hd-optimized/) |
| Relighting TSL | J | Better lighting in the first room (101PERt) | [Deadly Stream](https://deadlystream.com/files/file/2752-relighting-tsl/) |
| Peragus Administration Level Room Model Fixes | | Fixes model and walkmesh errors in three Peragus rooms | Deadly Stream |
| Fixed Hologram Models and Admiralty Redux | | Fixed hologram models | Deadly Stream |

**Why they're optional.** The demo plays the same without them: they change how it looks, not how it plays. The HD
packs are big (several GB of downloads, about 0.7 GB once packed) and need a GPU with more video memory, so they
shouldn't be forced on anyone. Making them mods also shows how a texture overhaul works in the remake's mod system.

## About permission

The optional mods are used **without their authors' direct permission**, as examples of what porting a mod to the
remake looks like. None of their files are shared: your own download is read on your own computer. If you're an
author and would like your mod left out, open an issue and it will be removed.

## How each mod is used

The technical detail. `step00b_holograms.py` and `step00_overlay.py` in the pipeline lay the mods over the game
data in `out/_game`; nothing in Downloads or the game's install is changed.

| Mod | What's in it | What we did |
|---|---|---|
| TSLRCM 1.8.6 (`romfs`, a Switch build) | 149 scripts, 92 modules | The 92 modules hold the same data as the TSLRCM already in use, and 146 of the 149 scripts are identical. See below for the other 3. |
| Peragus Admin Room Model Fixes | Models for `101peri`, `104pera`, `104perf` | Used, except that meshes the game doesn't draw get no material (see below). No scripts. |
| Fixed Holograms and Admiralty Redux | 32 models, 8 textures, table and character edits | Models, textures and table rows used. Characters get the mod's appearance. The mod's mesh reordering isn't needed: see below. No scripts. |
| Relighting 101PERt 2.1 | Model, walkmesh and 11 light bakes | Used as they are. No scripts. |
| Planets HD 3.7 | 1,720 upscaled textures (TPC) for every planet, the Ebon Hawk, and screens and panels | Every texture the project has is replaced with the pack's version: 155 for Peragus and the Harbinger. Lightmaps, characters and the 25 textures the pack doesn't cover (skies, stars, a few small ones) stay as they were. Checked against the originals: same orientation, format and TXI settings in all 155. Laid under the fixes above, so they win where a name is shared. `step59_hd_textures.py` puts them in; Godot imports them VRAM-compressed. | **Installed as a mod:** Setup makes it into `planets_hd.zip` (`step62_hd_mods.py`) in the game's `mods` folder, so it can be switched off; the game data keeps the standard textures.
| Vanilla Characters HD 3.1 | 863 upscaled character textures (TPC): bodies, heads, robes, droids | Every character texture the project has is replaced: 262 of 268, plus 8 that props use (corpses, Kreia on the slab). The hologram mod's textures win where they share a name (Dodonna's head), and its other five aren't in the pack. Same checks as the planets pack: orientation matches in all 263. The female player body loses alpha it never used, and gains an Xbox-only setting. Same steps as above. | **Installed as a mod:** Setup makes it into `characters_hd.zip` (`step62_hd_mods.py`) in the game's `mods` folder, so it can be switched off; the game data keeps the standard textures.

## The three scripts that differ in 1.8.6

| Script | Change in 1.8.6 | Decision |
|---|---|---|
| `c_lightsaber_eq` | Checks the weapon's base item instead of searching its name for "Lightsaber" | Taken: it's more reliable |
| `a_con_atton_end` | Replaces the in-game Harbinger arrival scene with the movie `PerMov08` | Kept the old one: it's the real scene |
| `a_playpermov` | Drops `permov03`, for the same change | Kept the old one |

1.8.6's `dialog.tlk` isn't used either: its 127 changed strings are mostly controller tags like `<abutton>`.

## What the room fixes really change

Compared with the base game, node by node: new mesh `beam` and 8 fewer faces on `cr_tr02` in `104pera`, new texture coordinates on 9 other meshes of `104pera`, 2 of `101peri` and all 6 of `104perf`, and walkmeshes `walk43` and `walkmesh1`. All other meshes and every texture are untouched. Those walkmeshes name a `dirt` texture that doesn't exist, so `build_module.py` now leaves any mesh the game doesn't draw without a material. Otherwise it's drawn over the floor and no longer used for walking.

## Changes beyond what the mods do

- **Holograms:** the game marks them with a `Hologram` field on the character. They now use a shader with a depth prepass (`KotorVfx.make_hologram`), so eyes and teeth don't show through heads. The mod could only reduce that by reordering meshes.
- **Script functions:** `GivePlotXP`, `GetLastHostileActor`, `GetLastDamager`, `GetFirstObjectInArea` and `GetNextObjectInArea` now work. `SetSoloMode`, `SetFakeCombatState` and `ChangeObjectAppearance` are deliberate no-ops.
- **Not implemented:** talent functions such as `GetCreatureTalentRandom`, which only `k_ai_master` calls. The native AI replaces that script, so enemies don't use talents yet.
