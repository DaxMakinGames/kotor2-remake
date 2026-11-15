# Testing a mod

## In the game

Run the project from the Godot editor with your mod in the project's `mods/` folder. The game's log (the editor's
Output panel) shows:

- `Mods: hardcore 1.0.0, ...` once your mod has loaded.
- Errors from your script, with line numbers.
- Anything you `write_log()`.
- A refused hook, with the reason.

If your mod isn't listed, open the Mods screen: a mod with problems shows them there.

## Automated

The game's own test, `tools/mod_test.gd`, loads the example mods and checks every hook through the real game code.
Copy its pattern for your mod:

```gdscript
var mods: KotorMods = Kotor.mods
mods.use_config("user://my_test.cfg")       # your own settings, not the player's
mods.only_extra = true                      # only your folder
mods.extra_folders = [ProjectSettings.globalize_path("res://my_mods")]
mods.reload()
assert(int(mods.modify(&"xp_award", 10)) == 20)
```

Run it with a window: `Godot --path <project> --resolution 1152x648 res://tools/your_test.tscn`.
