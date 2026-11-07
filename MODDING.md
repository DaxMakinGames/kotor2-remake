# Modding guide

> [!WARNING]
> **This is an early demo, and it covers only the first level.** Only Peragus and the Harbinger are rebuilt. Things
> are expected to be broken: missing features, bugs, rough edges. I can't fix, port or implement everything. The goal
> is an **engine recreation** of KOTOR 2: the original game's levels, scripts and rules running as they did, without
> modernizing its systems more than needed. Mod support follows the same idea: it gives you hooks into the original
> rules rather than a new game. Expect the modding API to change before 1.0.

The full guide, with a page for every hook and step-by-step tutorials, is the **modding wiki** in `modding_wiki/`
(`modding_wiki/docs/engine/publishing.md` says how to preview it). This file is the short version.

**Contents**
1. [What a mod can do](#what-a-mod-can-do)
2. [Installing a mod](#installing-a-mod)
3. [Making a mod, step by step](#making-a-mod-step-by-step)
4. [Packing and sharing](#packing-and-sharing)
5. [Texture overhauls](#texture-overhauls)
6. [Current limitations](#current-limitations)
7. [Rules for mod authors](#rules-for-mod-authors)
8. [Hook reference](#hook-reference)
9. [How the game is put together](#how-the-game-is-put-together)
10. [Example: Hardcore](#example-hardcore)
11. [Status of mod support](#status-of-mod-support)

## What a mod can do

| Kind of mod | How | Example |
|---|---|---|
| Harder or easier play | Hooks on damage, accuracy, healing, XP, Force costs | Hardcore (`mods_examples/hardcore`) |
| A game mode | New-game choices, events and the mod's own saved state | Hardcore's Ironman |
| New items and outfits | `add_item()`, beside the game's own items, with their own icons and textures | Prequel Robes (`mods_examples/prequel_robes`) |
| Different story logic | Replace or wrap one of the original game's script functions | `script_function()` |
| Texture overhauls | A `textures` folder that replaces the game's textures by name | The HD packs Setup makes |

Mods **add** and **hook**: they never edit the game's files. That's what lets several mods run together and be switched
off cleanly.

## Installing a mod

1. Put the mod's `.zip` (or its folder) in the **`mods` folder beside the game**. Don't unzip a `.zip` mod.

   | Platform | Where |
   |---|---|
   | Mac | `mods` beside `KOTOR2.app`, not inside it |
   | Windows, Linux (later) | `mods` beside the game's executable |
   | Any (also searched) | `user://mods`: on a Mac, `~/Library/Application Support/Godot/app_userdata/kotor2/mods` |
   | The project in the Godot editor | `mods/` in the project |

2. Open **Mods** on the title screen. Every mod found is listed with its version, description and any problems.
   **Open mods folder** there makes the folder if it isn't there yet.
3. Turn mods on or off with the switch beside each one, and set their load order (**Load earlier**, **Load later**, or
   **Find best order**, which sorts them by what each mod asks). Then press **Restart to apply**. A mod's settings
   take effect at once.
4. **Collections** save the mods you have on, and their order, under a name ("Hardcore playthrough", "HD overhaul").
   Pick one from the list at the top to switch to it.

A mod's settings are also under **Options → Mod settings**. New-game choices (such as Ironman) appear after
**New Game**. Every save records which mods made it, and loading a save made with different mods tells you so.

## Making a mod, step by step

1. **Make a folder** named after your mod's id, in the project's `mods/` folder while you work on it:

   ```
   mods/my_mod/
     mod.json      what the mod is (required)
     main.gd       what it does: extends KotorMod (leave it out for an art-only mod)
     textures/     pictures, icons, data: anything else it needs (optional)
   ```

2. **Write `mod.json`** (below). The `id` must match the folder's name and never change after release.
3. **Write `main.gd`**: register hooks, settings and items in `_mod_ready()`.
4. **Run the game from the editor.** Your mod is listed on the Mods screen. Check the Output panel: every mod
   error starts with `Mod <id>:`.
5. **Test it** (`tools/mod_test.gd` shows how the examples are tested through the real game code).
6. **Pack it** (next section) and try the `.zip` in an exported game before you share it.

### mod.json: what the mod is

```json
{
  "id": "hardcore",
  "name": "Hardcore",
  "version": "1.0.0",
  "author": "you",
  "description": "Shown on the Mods screen.",
  "api": 1,
  "entry": "main.gd",
  "load_after": ["some_other_mod"],
  "conflicts": ["a_mod_that_breaks_with_this"],
  "replaces": ["res://data/tuning.tres"]
}
```

| Field | Meaning |
|---|---|
| `id` | The mod's name in code, saves and settings. Never change it after release |
| `api` | The hook version the mod was written for (`KotorMods.API_VERSION`, now 1). A mod for a newer game isn't loaded |
| `entry` | The script to run. `""` for a mod with no script |
| `load_after` | Mods this one must load after, so its hooks run after theirs |
| `conflicts` | Mods it can't run with. The second one found isn't loaded, and the Mods screen says why |
| `replaces` | Files its `.pck` or `.zip` replaces, so two mods replacing the same file are reported |
| `load_before` | Mods this one must load before. **Find best order** on the Mods screen sorts by both |
| `textures` | A folder of pictures that replace the game's textures **by name** (see Texture overhauls). Optional |
| `icon` | A square picture shown beside the mod's name (PNG, JPG or WebP; 256 × 256 is plenty). Optional |
| `pictures` | Screenshots for the mod's page, which players scroll through: `["pictures/1.png", "pictures/2.png"]`. Optional |

### main.gd: what the mod does

```gdscript
extends KotorMod

func _mod_ready() -> void:
	add_option(&"enemy_damage", "Enemy damage", TYPE_FLOAT, 1.5, 1.0, 3.0, 0.25)
	add_new_game_choice(&"ironman", "Ironman", ["Off", "On"], 0, "One life.")
	hook(&"damage_dealt", _harder_hits)
	on(&"player_down", func(): if choice(&"ironman") == "On": Kotor.all_is_lost())

func _harder_hits(damage: int, ctx: Dictionary) -> int:
	var victim = ctx["victim"]
	if victim is Node and victim.is_in_group(&"player"):
		return roundi(damage * float(setting(&"enemy_damage")))
	return damage
```

What a mod has (`scripts/mods/kotor_mod.gd`):

| Call | What it does |
|---|---|
| `_mod_ready()` | Override it. Runs once every mod is loaded, in load order |
| `hook(name, fn)` | Change a number or decision: `fn(value, ctx: Dictionary) -> value`. Returning `null` keeps the value |
| `on(name, fn)` | Hear that something happened: `fn(...)` with the event's arguments |
| `script_function(name, fn)` | Replace or add an NWScript function: `fn(args: Array, vm, original: Callable) -> Variant`. Call `original.call(args, vm)` to keep the game's own result |
| `add_option(key, label, kind, default, low, high, step)` | A setting on the Mods screen and in Options, kept between games. `kind` is `TYPE_BOOL`, `TYPE_INT` or `TYPE_FLOAT` |
| `setting(key)` | That setting's value now |
| `add_new_game_choice(key, label, choices, default_index, text)` | A choice made once for a new game, kept with its saves |
| `choice(key)` | That game's choice |
| `save_data()` | A Dictionary that's saved and loaded with the game. Keep the mod's state here |
| `add_item(resref, data)` | A new item beside the game's own, never replacing one. Outfits name a body and their own textures (see the wiki's Adding items and Outfits) |
| `give_item(resref, count)` | Puts an item in the party's inventory |
| `mod_path(file)` | The path of a file of the mod's, for `load()` |
| `write_log(text)` | A line in the game's log, marked with the mod's id |
| `id`, `info`, `folder` | The mod's id, its whole `mod.json`, and where its files are |

A mod also has the public parts of `Kotor`: names without a leading underscore, such as `Kotor.notice`,
`Kotor.party`, `Kotor.stats`, `Kotor.add_item` and `Kotor.all_is_lost()`. Underscored names are internal and change
without warning.

A folder mod's `main.gd` is read as source, so it can't `preload` files beside it or use `class_name`. Load its other
files with `load(mod_path("..."))` or put them in a `mod.pck`. A `.zip` mod's files are ordinary `res://mods/<id>/` paths.

## Packing and sharing

Players get one `.zip`, which they drop into their `mods` folder. Inside it, everything is under `mods/<id>/`, which is
where the game mounts it (`res://mods/<id>/...`), and only while the mod is on.

| Your mod has | Pack it with | Why |
|---|---|---|
| Only scripts and JSON | `tools/pack_mod.sh <mod folder>` | A plain zip is enough: the game reads `main.gd` and JSON as they are |
| Pictures, icons or textures | `python3 tools/pack_art_mod.py <mod folder>` | Pictures must go through Godot's import, or an exported game can't load them |

Both write `<id>.zip` to `dist/` beside the mod folder (or to a folder you give as the second argument).

**`pack_art_mod.py`** needs Godot 4.7 (the editor; pass `--godot <path>` if it isn't in `/Applications`). It:

1. Makes a small Godot project around your mod (`installer/mod_project`): every texture with mipmaps and VRAM
   compression, like the game's own.
2. Imports it and exports it as a `.zip`.
3. Keeps only your mod's files and their imports, so it can't replace the game's own project files.

It's what Setup does for the HD texture mods. Loading your pictures with `Kotor.mods.texture(mod_path("textures/x.png"))`, or
naming them in `add_item`, works from a packed zip and from a folder.

**By hand:** put your mod folder in a folder called `mods`, and zip that `mods` folder. This only works for mods
without pictures.

**Before you share it:**
- [ ] `version` in `mod.json` raised since the last release
- [ ] It loads from the `.zip` in an exported game, not only from the editor
- [ ] Switched off, the game is back to normal
- [ ] Tell players which other mods it needs or conflicts with (`load_after`, `conflicts`)
- [ ] Credit the authors of anything you used, and have their permission to share it
- [ ] No files from the original game in your zip

## Texture overhauls

A texture overhaul is a mod with a `textures` folder and no script:

```json
{ "id": "my_hd_pack", "name": "My HD pack", "version": "1.0.0", "api": 1, "entry": "", "textures": "textures" }
```

Every picture in `textures/` replaces the game's texture with the same name (lower case, no extension), wherever it's
used: rooms, lightmaps, props, characters, weapons. `plc_desk1.png` replaces `plc_desk1`. If two mods replace the same
texture, the one later in the load order wins (use `load_after`). Turn the mod off and the standard textures come back.

- Pack it with `tools/pack_art_mod.py`, so the pictures are mipmapped and VRAM-compressed. A folder mod works too,
  but its pictures are read uncompressed every time the game starts: slow, and heavy on memory for HD textures.
- Pictures are used as they are: keep the original's orientation. (The pipeline flips two prop textures, `plc_desk1`
  and `plc_comppnl_b`; a replacement for those must be flipped the same way.)
- A texture's TXI settings (transparency, animation) come from the game's original.

**Vanilla Planets HD and Vanilla Characters HD** are made into two such mods on the player's computer, from their own
downloads (`step62_hd_mods.py`, then `install.py` packs them into `planets_hd.zip` and `characters_hd.zip`). Only
textures the game uses go in, and none that the Peragus fix mods supply. The base game keeps the standard textures.
On the development machine the packs are still built into the project (`hd_in_base` in `pipeline_paths.py`).

## Current limitations

What a mod **can't** do yet. Most of these are planned; some may never be, since the aim is to recreate the
original engine, not to rebuild it.

| Limitation | What to do instead |
|---|---|
| **Only the demo exists**: Peragus (101–107) and the Harbinger (151–153). No other planets, no new areas | Mods that hook rules and items work everywhere the game goes later |
| **No new levels or areas.** A mod can't add a level or change a level's layout | Change what happens in a level through hooks and script functions |
| **Models can't be replaced**, by name or by path. Only textures can | New items wear the game's own bodies with their own textures (Prequel Robes) |
| **Voices, music and sounds can't be replaced** | Play your own sounds from your mod's script |
| **Conversations can't be added or edited** directly | Wrap a script function, or change globals the conversation checks |
| **Hooks exist for 30 decisions** (the tables below). Stores and prices, party influence, alignment and minigames have none yet | Ask for a hook: each one is a small change in the game |
| **A folder mod's `main.gd` is read as source**: no `class_name`, no `preload` of files beside it | `load(mod_path("..."))`, or pack it into a `.zip` |
| **Turning mods on or off needs a restart** | Settings and new-game choices change at once |
| **Mac only for now**; a Windows build comes later | |
| **The API is version 1 and may change** before 1.0 | Keep `api` in `mod.json` accurate; a mod for a newer API isn't loaded |

## Rules for mod authors

- Don't edit `import/` or `data/` in place: replace files from a `.zip` or `.pck`, or change values through hooks.
- Keep state in `save_data()`, never in globals the original scripts use. Those belong to the story.
- Never bulk-load audio. Load a sound when it's needed: importing many audio files at once has crashed the project.
- Expect other mods in the same chain: change the value you're given.
- Give the mod a version in `mod.json` and raise it when its save data changes, since saves record it.

## Hook reference

The list is `KotorMods.HOOKS`, so asking for a hook that doesn't exist, or using `on()` with a modifier, is refused
with an error that says why.

- **Modifiers** run as a chain: every mod that hooked one gets the value in load order and returns it, changed or not.
  Change the value you're given rather than computing one from scratch, so other mods' changes survive.
- **Events** tell every listening mod that something happened.

### Game flow

| Hook | Kind | Arguments / value | Called from |
|---|---|---|---|
| `game_started` | event | `new_game: bool` | Character creation finishing (`true`), a save finishing loading (`false`) |
| `level_loaded` | event | `module` | `room_loader.gd` once the level is up |
| `level_leaving` | event | `module, to` | `Kotor.request_transition` |
| `heartbeat` | event | `seconds` (6) | `kotor_world_events.gd`, every round, not during conversations |
| `paused` | event | `open: bool` | Pause menu opening and closing |
| `can_load` | modifier | `bool` | Pause menu's Load, and the game-over screen (`false` there offers a new game instead) |

### Combat and survival

| Hook | Kind | Arguments / value | Called from |
|---|---|---|---|
| `attack_bonus` | modifier | `int`, ctx `{attacker, target}` | `KotorCombat._attack_bonus` |
| `defense` | modifier | `int`, ctx `{victim}` | `KotorCombat._defense` |
| `damage_dealt` | modifier | `int`, ctx `{attacker, victim, type}` | `KotorCombat._take_damage`, after resistances. Every kind of damage passes here: blows, grenades, powers, scripts |
| `damaged` | event | `attacker, victim, amount` | After damage is taken |
| `died` | event | `who, killer` | `KotorCombat._die` |
| `player_down` | event | (none) | `Kotor._player_down` |
| `regen_rate` | modifier | `float` health per second, ctx `{who}` | `Kotor._recover`, out of combat |
| `shield_rate` | modifier | `float` per second | `Kotor._recover` |
| `heal_amount` | modifier | `int`, ctx `{item, who}` | Using a medpac or repair kit |
| `enemy_think` | modifier | `float` seconds between decisions | `KotorEnemyAI` |

### Character and progress

| Hook | Kind | Arguments / value | Called from |
|---|---|---|---|
| `xp_award` | modifier | `int` | `Kotor.give_xp`, for kills and the story's XP. `0` gives none |
| `skill` | modifier | `int`, ctx `{key, skill}` | `Kotor.stats.skill` (skill index as in `rules.json`) |
| `force_cost` | modifier | `int`, ctx `{key, power}` | `Kotor.force.cost_of` |
| `level_up` | event | `key, level` | `Kotor.stats.apply_level_up` |
| `item_added` / `item_removed` | event | `resref, count` | `Kotor.add_item` / `remove_item` |
| `can_equip` | modifier | `bool`, ctx `{key, slot, resref}` | `Kotor.stats.equip` |
| `crafting_cost` | modifier | `int`, ctx `{station, item}` | `Kotor.crafting.cost_to_make` |

### Story and world

| Hook | Kind | Arguments / value | Called from |
|---|---|---|---|
| `conversation_started` / `conversation_ended` | event | `conv, owner` / `conv` | `Kotor.start_dialogue` / when it ends |
| `global_changed` | event | `name, value` | `Kotor.set_global`, `set_global_bool` |
| `door_opened` | event | `door` | `door.gd` |
| `container_opened` | event | `container` | `Kotor.begin_container` |
| `script_run` | event | `script_name, owner` | `Kotor._run`, for every original script |

**Adding a hook** (for the game's own code, not a mod): to add one, put it in `KotorMods.HOOKS`, call `Kotor.mods.modify(...)` or `Kotor.mods.emit(...)` at the one place
in the game where that decision is made, list it here, and test it in `tools/mod_test.gd`. With no mods,
`modify` hands the value straight back, so a hook costs nothing.

## How the game is put together

Everything runs through the `Kotor` autoload (`scripts/kotor/kotor.gd`). Its parts are child nodes, listed in
`Kotor.OWN_PARTS`.

| Part | File | What it owns |
|---|---|---|
| `Kotor.mods` | `scripts/mods/kotor_mods.gd` | Mod loading, hooks, settings, choices, save data |
| `Kotor.stats` | `kotor_stats.gd` | Character sheets, skills, feats, gear bonuses, XP, levels |
| `Kotor.force` | `kotor_force.gd` | Force powers and their costs |
| `Kotor.crafting` | `kotor_crafting.gd` | Workbench, lab station and upgrades |
| `Kotor.checkpoint` | `kotor_checkpoint.gd` | Saving and loading |
| `Kotor.world` | `kotor_world_state.gd` | What changed in each level (dead enemies, open doors) |
| `Kotor.events` | `kotor_world_events.gd` | Heartbeats, spawn, notice, damage and death scripts |
| `Kotor.encounters` | `kotor_encounters.gd` | Ambush triggers |
| `Kotor.quick` | `kotor_quick_items.gd` | Medpacs, grenades, stims |
| `KotorCombat` (static) | `kotor_combat.gd` | Attack rolls, damage, death |
| `KotorEnemyAI` / `kotor_party_ai.gd` | | How enemies and companions fight |
| Script engine | `kotor_script_engine.gd`, `kotor_game_engine.gd` | Runs the original game's compiled scripts. Each NWScript function is a `_fn_<Name>` method |

What's already data, and can change without code:

| File | What it holds |
|---|---|
| `data/tuning.tres` (`KotorTuning`) | Feel numbers: enemy sight, grenade timing, crafting prices |
| `data/locks.tres` (`KotorLockRules`) | What locks say and how long picking takes |
| `import/kotor/rules.json` | The game's own rules from its tables: classes, skills, feats, powers, items, XP, crafting recipes, upgrades |
| `import/kotor/<level>/*.json` | Each level's objects, triggers, waypoints, scripts, lights and walkmesh |
| `import/kotor/dialogue/*.dialogue` | Conversations, with their conditions and scripts |
| `import/kotor/<level>/ncs/*.ncs` | The original compiled scripts, run as they are |

`import/` is built by the pipeline in `~/Documents/kotor-pipeline` and gets overwritten. A mod must never edit it. It
replaces files from its own `.pck` or `.zip`, or changes behavior through hooks.

## Example: Hardcore

`mods_examples/hardcore`, packed into `mods_examples/dist/hardcore.zip`.

| Setting | Default | Hook |
|---|---|---|
| Enemy damage | ×1.5 against the party | `damage_dealt` |
| Enemy accuracy bonus | +2 for enemies | `attack_bonus` |
| Health comes back on its own | off | `regen_rate` |
| Medpac strength | ×0.5 | `heal_amount` |
| Shield recharge speed | ×0.5 | `shield_rate` |
| Force power cost | ×1.25 | `force_cost` |

**Ironman** (a new-game choice):

- Load is hidden in the pause menu (`can_load`).
- Falling ends the run with no reviving (`player_down` → `Kotor.all_is_lost()`).
- The autosave is deleted, and the game-over screen offers only a new game.

`tools/mod_test.gd` loads it from the `.zip` and from its folder, and checks every hook through the real game code.

### Other modes these hooks allow

**Survival**
- **Stats:** hunger and fatigue live in `save_data()`.
  - `heartbeat` and `level_leaving` lower them.
- **Consequences:**
  - `skill` and `attack_bonus` drop as they fall.
  - `regen_rate` is 0.
- **Recovery:** ration items come from the mod's `.pck`.
- **Supplies:** `container_opened` adds rations to loot.

**Bounty board**
- `died` counts kills by creature tag.
- `conversation_started` and `global_changed` follow the story.

## Status of mod support

- [x] `KotorMod` base class and the `Kotor.mods` part: `hook`, `modify`, `on`, `emit`
- [x] Loader: game folder, `user://mods` and the editor's `mods/`; folder or `.zip`; `load_after`; conflicts; `api` version
- [x] Hook calls in the places listed above, tested in `tools/mod_test.gd`
- [x] Each mod's section in the save, and a warning when the mod list differs on load
- [x] Mod settings in Options and on the Mods screen; choices on the new-game screen
- [x] A Mods screen on the title menu: on and off, load order, conflicts, restart to apply
- [x] Hardcore in `mods_examples/`, packed by `tools/pack_mod.sh`, used by the test
- [x] Export: an exported build loads a `.zip` from the `mods` folder beside the game. To check again: make
  `res://tools/mod_export_check.tscn` the main scene, take `tools/*` out of the preset's exclude filter, export, put
  `hardcore.zip` in `build/mods/`, run the app and look for `EXPORT CHECK: PASS`, then put both settings back
- [ ] Hooks still to add as systems arrive: stores and prices, party influence, alignment shifts, minigames
