# KotorMod

Every mod script `extends KotorMod` (`scripts/mods/kotor_mod.gd`).

## Override

| Function | When |
|---|---|
| `_mod_ready()` | Once every mod has loaded, in load order. Set up your hooks, settings and items here |

## Hooks

| Function | What it does |
|---|---|
| `hook(name: StringName, fn: Callable)` | A [modifier](../guides/hooks.md): `fn(value, ctx: Dictionary) -> value` |
| `on(name: StringName, fn: Callable)` | An [event](../guides/hooks.md): `fn(...)` with the event's arguments |
| `script_function(name: String, fn: Callable)` | [Replace an NWScript function](../guides/script-functions.md): `fn(args: Array, vm, original: Callable) -> Variant` |

## Settings and choices

| Function | What it does |
|---|---|
| `add_option(key, label, kind, default, low = 0.0, high = 1.0, step = 0.1)` | A setting; `kind` is `TYPE_BOOL`, `TYPE_INT` or `TYPE_FLOAT` |
| `setting(key) -> Variant` | Its current value |
| `add_new_game_choice(key, label, choices: Array, default_index = 0, text = "")` | A choice made when a new game starts |
| `choice(key) -> Variant` | This game's choice |

## Saving

| Function | What it does |
|---|---|
| `save_data() -> Dictionary` | Your part of the save: change it freely |

## Items

| Function | What it does |
|---|---|
| `add_item(resref: String, data: Dictionary) -> bool` | A new item. False if the name's taken. See [Item fields](item-fields.md) |
| `give_item(resref: String, count = 1)` | Puts an item in the party's inventory |

## Files and logging

| Function / field | What it is |
|---|---|
| `mod_path(file: String) -> String` | The full path of a file in your mod, for `load()` and the item fields |
| `write_log(text: String)` | A line in the game's log, marked with your mod's id |
| `id: String` | From `mod.json` |
| `info: Dictionary` | All of `mod.json` |
| `folder: String` | Where your files are: a folder path, or `res://mods/<id>` for a `.zip` |
