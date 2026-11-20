# Modding guide

> [!WARNING]
> **This is early access.** Peragus, the Harbinger, the Ebon Hawk and Telos are rebuilt. Things
> are expected to be broken: missing features, bugs, rough edges. I can't fix, port or implement everything. The goal
> is an **engine recreation** of KOTOR 2: the original game's levels, scripts and rules running as they did, without
> modernizing its systems more than needed. Mod support follows the same idea: it gives you hooks into the original
> rules rather than a new game. The modding API is locked: what's there stays (see "The API's promise" below).

The full guide, with a page for every hook, recipes and step-by-step tutorials, is the **modding wiki**: `modding/wiki/`
in the download repository (`modding_wiki/docs/` in the game's project). This file is the short version. Good places to
start there: **Your first mod** (`getting-started/first-mod.md`), **Recipes** (`guides/recipes.md`) and **Bring a KOTOR
mod over** (`guides/porting.md`).

**Contents**
1. [What a mod can do](#what-a-mod-can-do)
2. [Installing a mod](#installing-a-mod)
3. [Making a mod, step by step](#making-a-mod-step-by-step)
4. [Packing and sharing](#packing-and-sharing)
5. [Texture overhauls](#texture-overhauls)
6. [Replacing models, sounds and conversations](#replacing-models-sounds-and-conversations)
7. [Current limitations](#current-limitations)
8. [Rules for mod authors](#rules-for-mod-authors)
9. [Hook reference](#hook-reference)
10. [How the game is put together](#how-the-game-is-put-together)
11. [More examples: Starter Mod and five gameplay mods](#more-examples-starter-mod-and-five-gameplay-mods)
12. [Example: Hardcore](#example-hardcore)
13. [Status of mod support](#status-of-mod-support)

## What a mod can do

| Kind of mod | How | Example |
|---|---|---|
| Harder or easier play | Hooks on damage, accuracy, healing, XP, Force costs | Hardcore (below) |
| A game mode | New-game choices, events and the mod's own saved state | Hardcore's Ironman |
| New items and outfits | `add_item()`, beside the game's own items, with their own icons and textures | Prequel Robes (in progress) |
| Different story logic | Replace or wrap one of the original game's script functions | `script_function()` |
| Texture overhauls | A `textures` folder that replaces the game's textures by name | The HD packs Setup makes |
| New models | A `models` folder of `.glb` files that replace rooms, props, bodies, heads and weapons by name | A reshaped prop or weapon |
| New voices, sounds and music | A `sounds` folder: a voice line, effect or music track by its name | A recast voice, a new soundtrack |
| New or rewritten conversations | A `conversations` folder of `.dialogue` files, by the conversation's name | A rewritten talk, or a new one a script starts |

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
   **Find best order**, which sorts them by what each mod asks). Changes take effect at once, with no restart: what's
   already in a level (its models and textures) changes when a level next loads. A mod that says it needs a restart
   (`needs_restart`) gets a **Restart** button instead.
4. **Collections** save the mods you have on, and their order, under a name ("Hardcore playthrough", "HD overhaul").
   Pick one from the list at the top to switch to it.

A mod's settings are also under **Options → Mod settings**. New-game choices (such as Ironman) appear after
**New Game**. Every save records which mods made it, and loading a save made with different mods tells you so.

## Making a mod, step by step

**The quickest start** is to copy the Starter Mod (`modding/examples/starter`; Setup also puts it in the `mods` folder
beside the game): rename the folder and its `id` in
`mod.json`, turn it on in **Mods**, and edit its `main.gd`. Turning a mod off and on again reloads it, with no restart.
Or build one from nothing:

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
| `models`, `sounds`, `conversations` | Folders of files that replace the game's models, sounds and conversations **by name** (see Replacing models, sounds and conversations). Optional |
| `default_on` | `false` to start switched off when a player first finds the mod, so it changes nothing until they turn it on. Optional (on by default) |
| `needs_restart` | `true` if turning the mod on or off only works after a restart (it changes something it can't undo when taken out). Optional |
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
| `add_item(load(mod_path("items/x.tres")))` | The same, from an item made in Godot's Inspector: **New Resource → KotorItemDef**, saved in the mod's folder |
| `add_items_in(folder)` | Every `KotorItemDef` (`.tres`) in a folder of the mod |
| `give_item(resref, count)` | Puts an item in the party's inventory |
| `start_conversation(conv, owner)` | Starts a conversation: one of the mod's own (its `conversations` folder) or the game's |
| `give_conversation(tag, conv)` | Gives whoever has that tag in the level a conversation: talking to them starts it. Call it from `on(&"level_loaded", ...)` |
| `add_conversation_action(name, fn)` | Something the mod's conversations can do: a line with `$> Kotor.act("name", ...)` runs `fn(params: Array, owner)` |
| `add_conversation_check(name, fn)` | A condition its conversations can test: `[if Kotor.cond("name", ...) /]` asks `fn(params: Array) -> bool` |
| `add_quest(tag, name, entries, planet)` | A quest of the mod's own in the journal: `entries` is `{state: text}` |
| `set_quest(tag, state)` | Moves a quest on, as the game's scripts do (the journal shows its new entry) |
| `add_store(tag, name, items, markup, markdown)` | A store of the mod's own: items as resrefs, or `{"resref", "infinite"}` for stock that never runs out |
| `open_store(tag)` | Opens it (or one of the level's stores, by its tag) |
| `mod_path(file)` | The path of a file of the mod's, for `load()` |
| `write_log(text)` | A line in the game's log, marked with the mod's id |
| `id`, `info`, `folder` | The mod's id, its whole `mod.json`, and where its files are |

A mod also has the public parts of `Kotor`: names without a leading underscore, such as `Kotor.notice`,
`Kotor.party`, `Kotor.stats`, `Kotor.add_item` and `Kotor.all_is_lost()`. Underscored names are internal and change
without warning.

**A creature's state** (health, down, dead, in a fight, faction) is its `KotorVitals`. Read it with `KotorCombat`'s
helpers (`hit_points`, `max_hit_points`, `is_dead`, `is_down`, `is_engaged`, `fight_target`, `faction_of`). Change
it with `KotorCombat.set_hit_points(who, hp)` and the like. To hear changes, connect to its signals:
`KotorVitals.of(who).health_changed`, `down_changed`, `died`, `fight_changed` and `faction_changed`.
`KotorVitals.fighting` lists everyone in a fight right now. The player's own health is `Kotor.player_hp`.

**Kinds of creature** are scenes in `scenes/npc/`: `KotorDroid` (`droid.tscn`, and `mining_droid.tscn` built on it)
and `KotorHumanoid` (`humanoid.tscn`). Each has its own settings in the Inspector: `sight_range`, `ability_chance`,
`idle_chatter`, `never_throws` and `throws_grenades`, plus `plant_feet` for humanoids. To change a kind, use `npc_spawned`. To give
creatures a scene of the mod's own, use `npc_scene`.

A folder mod's `main.gd` is read as source, so it can't `preload` files beside it or use `class_name`. Load its other
files with `load(mod_path("..."))` or put them in a `mod.pck`. A `.zip` mod's files are ordinary `res://mods/<id>/` paths.

## Packing and sharing

Players get one `.zip`, which they drop into their `mods` folder. Inside it, everything is under `mods/<id>/`, which is
where the game mounts it (`res://mods/<id>/...`), and only while the mod is on.

| Your mod has | Pack it with | Why |
|---|---|---|
| Only scripts and JSON | `modding/tools/pack_mod.sh <mod folder>` | A plain zip is enough: the game reads `main.gd` and JSON as they are |
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

- Pack it with `modding/tools/pack_art_mod.py`, so the pictures are mipmapped and VRAM-compressed. A folder mod works too,
  but its pictures are read uncompressed every time the game starts: slow, and heavy on memory for HD textures.
- Pictures are used as they look in an image viewer. Two props show theirs flipped, `plc_desk1` and `plc_comppnl_b`,
  so a replacement for those must be flipped the same way.
- **Textures made for the original game** (`.tga`, and its own kind of `.dds`): `python3 modding/tools/kotor_texture_to_png.py
  <files or folder> --out <mod>/textures` makes `.png` files the right way up, those two flipped. More in the wiki's
  **Bring a KOTOR mod over**.
- A texture's TXI settings (transparency, animation) come from the game's original.

**Vanilla Planets HD and Vanilla Characters HD** are made into two such mods on the player's computer, from their own
downloads (`step43_hd_mods.py`, then `install.py` packs them into `planets_hd.zip` and `characters_hd.zip`). Only
textures the game uses go in, and none that the Peragus fix mods supply. The base game keeps the standard textures.
On the development machine the packs are still built into the project (`hd_in_base` in `pipeline_paths.py`).

## Replacing models, sounds and conversations

These work like textures: a folder named in `mod.json`, and each file replaces the game's one with the same name (lower
case, no extension). Later mods in the load order win, and turning the mod off brings the game's own back.

```json
{ "id": "my_swaps", "name": "My swaps", "version": "1.0.0", "api": 1, "entry": "",
  "models": "models", "sounds": "sounds", "conversations": "conversations" }
```

- **Models** (`.glb` or `.gltf`; a packed mod can also use `.tscn`/`.scn`): rooms, props, bodies, heads and weapons, by
  the game's model name (`plc_footlker.glb`, `dor_per01.glb`, `p_atton_body`'s body model, `w_blstrpstl_001.glb`).
  Meshes named as in the original get the game's own textures and lightmaps; any other mesh is drawn with its own
  material. A level's layout and walkable floor stay the game's: a room model changes how the room looks, not where you
  can walk. Characters keep the original skeleton's bone names, or animations won't fit.
- **Sounds** (`.ogg`, `.wav` or `.mp3`): voice lines by their resref (`101101atton001`), sound effects by theirs, music
  tracks by theirs. Each is read when it plays.
- **Conversations** (`.dialogue`): by the conversation's name (`101atton`), in Dialogue Manager's format. A
  conversation with a **new** name is the mod's own: give it to a character with `give_conversation`, or start it with
  `start_conversation`. Its lines can run the mod's own actions and checks (`add_conversation_action`,
  `add_conversation_check`) through `Kotor.act("name", ...)` and `Kotor.cond("name", ...)`, as the game's own
  conversations run its scripts. A line can also call `Kotor.on_line(...)` for a voice and camera, as the game's do;
  without one, the line is shown with the conversation's own camera. The Cantina Errand example is a whole one.
- A folder mod's models and conversations are read as the game runs; a packed mod's (`modding/tools/pack_art_mod.py`) are
  imported, which loads faster.

## Current limitations

What a mod **can't** do yet. Most of these are planned; some may never be, since the aim is to recreate the
original engine, not to rebuild it.

| Limitation | What to do instead |
|---|---|
| **Only part of the game exists**: Peragus, the Harbinger, the Ebon Hawk and Telos. No new areas | Mods that hook rules and items work everywhere the game goes later |
| **No new levels or areas.** A mod can't add a level or change a level's layout | Change what happens in a level through hooks and script functions |
| **A replaced model can't move walls or floors**: the walkable layout comes from the game's walkmesh | Change how a room looks, not its shape underfoot |
| **Hooks exist for 50 decisions and events** (the tables below), stores, influence, alignment, forms and minigames among them | Ask for a hook: each one is a small change in the game |
| **A folder mod's `main.gd` is read as source**: no `class_name`, no `preload` of files beside it | `load(mod_path("..."))`, or pack it into a `.zip` |
| **Mac only for now**; a Windows build comes later | |
| **Pazaak isn't in yet**, so `minigame_started` says `"turret"` or `"swoop"` | Listen for any kind: the others will use the same events |
| **A classic KOTOR 2 mod brings only its pictures and models** (see below) | Its scripts, conversations and tables would need porting: hooks, items and the mod's own conversations do most of it |

## Classic KOTOR 2 mods

Years of KOTOR 2 mods were made for the original's Override folder. Put a classic mod's folder (as you downloaded it,
unpacked) in **`KOTOR2 Classic Mods`** in your Downloads folder, and Setup's next build lays what the remake can use
over the game it builds from:

- **Used:** textures (`.tga`, `.tpc`, `.dds`, with their `.txi`) and models (`.mdl`, `.mdx`), by name, as the original
  would. A texture or model mod usually just works.
- **Not used:** scripts, conversations, templates and tables (`.ncs`, `.dlg`, `.utc`, `.2da` and the like), and
  TSLPatcher installers (`tslpatchdata`). The remake runs the game's own story with TSLRCM's fixes; a mod's version of
  one of those was never tested with it. To bring one over, rebuild it as a mod of this game: the wiki's
  "Bring a KOTOR mod over" shows how.

What was used and what wasn't, for each one, is in the build's `classic_mods.json`.

## The API's promise

The modding API is **locked for 1.0**, at version 1. New hooks, new context keys, new `KotorMod` methods and new
parameters with defaults can still be added, but nothing a mod relies on is removed, renamed or changed:

- every hook keeps its name and kind;
- an event keeps its arguments, so your listener still fits;
- a modifier keeps its value's type and every key it gives in `ctx`;
- every `KotorMod` method keeps its name and parameters;
- `mod.json`'s fields and the four kinds of replacement (textures, models, sounds, conversations) stay.

The game holds itself to this: `modding_wiki/data/api_lock.json` records the API as it was locked, and the build checks
the game against it before every release (`modding_wiki/api_lock.py`). A change that would break a mod stops the
release. If one ever has to happen, `KotorMods.API_VERSION` goes up and a mod made for version 1 keeps loading.

## Rules for mod authors

- Don't edit `import/` or `data/` in place: replace files from a `.zip` or `.pck`, or change values through hooks.
- Keep state in `save_data()`, never in globals the original scripts use. Those belong to the story.
- Never bulk-load audio. Load a sound when it's needed: importing many audio files at once has crashed the project.
- Expect other mods in the same chain: change the value you're given.
- Give the mod a version in `mod.json` and raise it when its save data changes, since saves record it.

## Hook reference

The list is `KotorMods.HOOKS`, so asking for a hook that doesn't exist, or using `on()` with a modifier, is refused
with an error that says why. Each hook has a page in the wiki (`reference/hooks/`) with its types, what's in `ctx`,
and an example. The tables below are written from the same descriptions, so they match the game.

- **Modifiers** run as a chain: every mod that hooked one gets the value in load order and returns it, changed or not.
  Change the value you're given rather than computing one from scratch, so other mods' changes survive.
- **Events** tell every listening mod that something happened.

<!-- hooks: start (written by modding_wiki/build_hooks.py) -->

### Game flow

| Hook | Kind | Value or arguments | What it's for |
|---|---|---|---|
| `game_started` | event | `new_game: bool` | A game has begun: a new one, once character creation finishes, or a saved one, once it has finished loading. |
| `level_loaded` | event | `module: String` | A level has finished loading and the player is in it. |
| `level_leaving` | event | `module: String, to: String` | The player is about to leave a level for another one. |
| `heartbeat` | event | `seconds: float` | Every six-second round of play, the original game's own heartbeat. Not during conversations. |
| `paused` | event | `open: bool` | The pause menu has opened or closed. |
| `run_finished` | event | (none) | The end of what's playable: the demo's end screen, as the story leaves for the Ebon Hawk. |
| `can_load` | modifier | `bool` | Whether the player may load a save mid-game: the pause menu's Load button, and the game-over screen's Load Checkpoint. |

### Combat and survival

| Hook | Kind | Value or arguments | What it's for |
|---|---|---|---|
| `attack_bonus` | modifier | `int`, ctx `{attacker, target}` | The attack bonus for one attack roll, the d20 roll plus this against the target's defense. |
| `defense` | modifier | `int`, ctx `{victim}` | Someone's defense, what an attack roll must reach to hit them. |
| `damage_dealt` | modifier | `int`, ctx `{attacker, victim, type}` | Damage about to be taken, after resistances. Every kind passes here: blows, shots, grenades, Force powers and scripts. |
| `can_attack` | modifier | `bool`, ctx `{attacker, target, weapon}` | Whether an attack happens at all, asked before the roll. Return false to hold it back. |
| `attack_made` | event | `attacker: Node3D, target: Node3D, hits: bool` | An attack roll has been made against a creature, and whether it hit. |
| `deflect_chance` | modifier | `float`, ctx `{victim, attacker}` | The chance that a ranged hit is turned aside by its target. |
| `deflected` | event | `victim: Node3D, attacker: Node3D, damage: int` | A bolt was turned aside, with the damage it would have done. |
| `damaged` | event | `attacker: Node3D, victim: Node3D, amount: int` | Someone has taken damage. |
| `died` | event | `who: Node3D, killer: Node3D` | A creature has died (not a party member going down). |
| `player_down` | event | (none) | The player has fallen. Unless a mod steps in, a companion can come and revive them. |
| `regen_rate` | modifier | `float`, ctx `{who}` | How fast health comes back out of combat, in points per second. |
| `shield_rate` | modifier | `float` | How fast the player's shield recharges, in points per second. |
| `heal_amount` | modifier | `int`, ctx `{item, who}` | How much a medpac or repair kit heals. |
| `enemy_think` | modifier | `float` | Seconds between the enemies' decisions: who to fight, where to move, when to throw. |
| `npc_scene` | modifier | `String`, ctx `{resref, appearance_id, body, instance}` | The scene a creature in a level is made from: a mining droid, a droid, a person, or a mod's own kind. |
| `npc_spawned` | event | `npc: Node3D` | A creature has been placed in a level and its model built: anyone but the player and companions. |

### Character and progress

| Hook | Kind | Value or arguments | What it's for |
|---|---|---|---|
| `xp_award` | modifier | `int`, ctx `{source, victim}` | Experience about to be given, for a kill or by the story. |
| `skill` | modifier | `int`, ctx `{key, skill}` | A character's total in a skill, used everywhere the game checks one: locks, computers, crafting, conversation. |
| `force_cost` | modifier | `int`, ctx `{key, power}` | What a Force power costs to use. |
| `level_up` | event | `key: String, level: int` | Someone has taken a level. |
| `item_added` | event | `resref: String, count: int` | Items have gone into the party's inventory. |
| `item_removed` | event | `resref: String, count: int` | Items have left the party's inventory: used, sold, broken down or taken by a script. |
| `can_equip` | modifier | `bool`, ctx `{key, slot, resref}` | Whether someone may put an item on. |
| `crafting_cost` | modifier | `int`, ctx `{station, item}` | The components or chemicals an item takes to make at a workbench or lab station. |

### Story and world

| Hook | Kind | Value or arguments | What it's for |
|---|---|---|---|
| `conversation_started` | event | `conv: String, owner: Node` | A conversation has begun. |
| `conversation_ended` | event | `conv: String` | A conversation has ended, after its last scripts ran. |
| `global_changed` | event | `name: String, value: int` | One of the story's global numbers or booleans has changed. This is how the original scripts record progress. |
| `door_opened` | event | `door: Node3D` | A door has opened, by anyone or any script. |
| `container_opened` | event | `container: Node3D` | The player has opened a container: a footlocker, a corpse, a crate. |
| `script_run` | event | `script_name: String, owner: Node` | One of the original game's scripts is about to run. |
| `journal_updated` | event | `quest: String, state: int` | A quest's entry in the journal changed (a script's AddJournalQuestEntry moved it to another state). |

### Companions and alignment

| Hook | Kind | Value or arguments | What it's for |
|---|---|---|---|
| `influence_change` | modifier | `int`, ctx `{npc, influence, template}` | How much a companion's influence moves when a conversation or script changes it (ModifyInfluence). |
| `influence_changed` | event | `npc: int, influence: int, amount: int` | A companion's influence moved, after it was kept within 0 to 100. The game also says "Influence gained" or "lost" on screen. |
| `alignment_change` | modifier | `int`, ctx `{who, alignment}` | How far an alignment shifts: the player's, or a companion's (their own, or following the player's when influence pulls them). |
| `alignment_changed` | event | `who: String, alignment: int, amount: int` | An alignment shifted. |
| `dark_stage` | modifier | `int`, ctx `{alignment}` | How deep the dark side's marks show on the player's face: 0 for none, 1 to 4 for the four textures heads.2da gives each head (evil, very evil and so on). |

### Stores and minigames

| Hook | Kind | Value or arguments | What it's for |
|---|---|---|---|
| `store_price` | modifier | `int`, ctx `{store, resref, buying}` | What an item costs to buy at a store, or what the store pays for it. |
| `store_bought` | event | `store: String, resref: String, price: int` | The player bought an item. |
| `store_sold` | event | `store: String, resref: String, price: int` | The player sold an item. |
| `minigame_started` | event | `kind: String` | A minigame has begun: "turret" (the Ebon Hawk's gun on Peragus) or "swoop" (the race on Telos). Pazaak will say so too once it's in. |
| `minigame_finished` | event | `kind: String, result: int` | A minigame has ended. |

### Lightsabers and forms

| Hook | Kind | Value or arguments | What it's for |
|---|---|---|---|
| `form_bonus` | modifier | `float`, ctx `{who, what}` | One of a form's numbers, as it applies right now: a lightsaber form (Shii-Cho to Juyo) or a Force form (Force Channel to Force Mastery). |
| `form_changed` | event | `key: String, kind: String, power: int` | Someone took up a form, or let one go. |

<!-- hooks: end -->

**Adding a hook** (for the game's own code, not a mod): put it in `KotorMods.HOOKS`, call `Kotor.mods.modify(...)` or
`Kotor.mods.emit(...)` at the one place in the game where that decision is made, describe it in
`modding_wiki/data/hooks.json`, run `python3 modding_wiki/build_hooks.py` (it writes the wiki's page and the tables
above, and stops if a hook has no description), and test it in `tools/mod_test.gd`. With no mods,
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
| `data/uv_rules.json` | Texture placement fixes for particular models, meshes or textures: turn a picture over, scale or move it |
| `import/kotor/rules.json` | The game's own rules from its tables: classes, skills, feats, powers, items, XP, crafting recipes, upgrades |
| `import/kotor/<level>/*.json` | Each level's objects, triggers, waypoints, scripts, lights and walkmesh |
| `import/kotor/dialogue/*.dialogue` | Conversations, with their conditions and scripts |
| `import/kotor/<level>/ncs/*.ncs` | The original compiled scripts, run as they are |

`import/` is built by the pipeline (Setup runs it on the player's computer) and gets overwritten. A mod must never edit it. It
replaces files from its own `.pck` or `.zip`, or changes behavior through hooks.

## More examples: content

Four examples of content, each in `mods_examples` and tested by `tools/content_mods_test.gd`:

| Mod | What it does | What it shows |
|---|---|---|
| Cantina Errand (`cantina_errand`) | A Twi'lek in the Citadel Station cantina asks for two medpacs, and pays for them | `add_quest`, a conversation of its own, `give_conversation`, `add_conversation_action` and `add_conversation_check`, `save_data` |
| Aqualish Trader (`aqualish_trader`) | The cantina's Aqualish sells field supplies | `add_store` and `open_store`, opened from its conversation |
| Clean Floors (`clean_floors`) | One of Peragus's floor textures replaced by a picture of its own | A texture overhaul: `mod.json` and pictures named as the game's, no script |
| Swoop Coach (`swoop_coach`) | Keeps your best swoop time, says the time to beat, pays a bonus for a new best | `minigame_started` and `minigame_finished`, a setting, `save_data` |

## More examples: Starter Mod and five gameplay mods

**Starter Mod** (`modding/examples/starter`) is a template to copy: a setting, a hook, events and saved state, each
commented. It starts switched off. It's the one example players get: Setup puts it in the `mods` folder beside the game,
and never over a copy the player has changed.

The game's project also has five gameplay mods, written to test the hooks (`tools/gameplay_mods_test.gd`). They aren't
in the download; they're here as ideas, with the hooks each one is built on:

| Mod | What it does | What it shows |
|---|---|---|
| Speedrun (`speedrun`) | A timer that skips loading and pauses, splits per level, a personal best | A HUD of its own, `level_loaded`, `run_finished`, a file kept between games |
| Injuries (`injuries`) | Heavy blows leave injuries with penalties until a medical station treats them | `damaged`, penalties through `attack_bonus`, `defense`, `damage_dealt` and `skill`, per-character save data |
| Power Cells (`power_cells`) | Blasters use charge from power cells, found in containers and on gunmen | A new item, `can_attack` and `attack_made`, `container_opened` |
| Pacifist Run (`pacifist`) | No XP for kills, more for the story, XP for enemies spared | `xp_award`'s source, `level_leaving`, a new-game choice |
| Lightsaber Duelist (`saber_duelist`) | A saber deflects bolts and sends some back; saber duels and blows get bonuses | `deflect_chance`, `deflected`, `KotorCombat.hurt` |


## Example: Hardcore

The test mod for mod support, in the game's project (`modding/examples/hardcore`; not in the download).

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
- [x] A Mods screen on the title menu: on and off, load order, conflicts; changes apply with no restart
- [x] Replacing models, sounds and conversations by name (`models`, `sounds`, `conversations`), tested in `tools/mod_test.gd`
- [x] Hardcore in `modding/examples/`, packed by `modding/tools/pack_mod.sh`, used by the test
- [x] Export: an exported build loads a `.zip` from the `mods` folder beside the game. To check again: make
  `res://tools/mod_export_check.tscn` the main scene, take `tools/*` out of the preset's exclude filter, export, put
  `hardcore.zip` in `build/mods/`, run the app and look for `EXPORT CHECK: PASS`, then put both settings back
- [x] Hooks for stores and prices, influence, alignment and the dark side's marks, forms, the journal and minigames
- [x] The API locked for 1.0: `modding_wiki/api_lock.py` checks every release against `modding_wiki/data/api_lock.json`
