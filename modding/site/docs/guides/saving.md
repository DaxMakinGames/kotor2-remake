# Saving your mod's state

`save_data()` returns a Dictionary that belongs to your mod and travels with the game's saves. Change it freely: it's
written with every save, autosave or slot, and put back when that save loads.

```gdscript
func _mod_ready() -> void:
	on(&"died", func(_who, killer):
		if killer == Kotor._player():
			save_data()["kills"] = int(save_data().get("kills", 0)) + 1)
	on(&"game_started", func(new_game: bool):
		write_log("kills so far: %d" % int(save_data().get("kills", 0))))
```

- A new game starts every mod's `save_data()` empty.
- When `game_started` fires after a load, your data is already back.
- Store plain values: numbers, strings, bools, arrays and dictionaries of them. Never store nodes: they don't exist
  after loading.

## Never use the story's globals

The original game's scripts record the story in globals (`Kotor.set_global`). Read them as much as you like, and
listen with [global_changed](../reference/hooks/global_changed.md), but keep your own state in `save_data()`. Changing
a story global can break a quest in ways that only show hours later.

## Changing what you save

Saves record your mod's `version`. If a new version stores different data, raise the version and read old data
carefully:

```gdscript
var hunger := float(save_data().get("hunger", save_data().get("food", 0.0)))   # 1.0 called it "food"
```
