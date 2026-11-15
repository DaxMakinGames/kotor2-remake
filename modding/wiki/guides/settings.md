# Settings and new-game choices

There are two ways to let players configure your mod.

| | Settings | New-game choices |
|---|---|---|
| Chosen | Any time: Mods screen, Options | Once, when starting a new game |
| Kept | Between games, for that player | With that game's saves |
| Good for | Difficulty sliders, toggles | Rules that define a run: Ironman, a randomizer's seed |

## Settings

```gdscript
func _mod_ready() -> void:
	add_option(&"enemy_damage", "Enemy damage", TYPE_FLOAT, 1.5, 1.0, 3.0, 0.25)
	add_option(&"regeneration", "Health comes back on its own", TYPE_BOOL, false)
	add_option(&"extra_grenades", "Extra grenades per crate", TYPE_INT, 1, 0, 5)

func _harder(damage: int, _ctx: Dictionary) -> int:
	return roundi(damage * float(setting(&"enemy_damage")))
```

`add_option(key, label, kind, default, low, high, step)`: `kind` is `TYPE_BOOL` (a switch), `TYPE_INT` or
`TYPE_FLOAT` (a slider from `low` to `high`). Read the current value with `setting(key)` **each time you need it**: the
player can change it while playing.

## New-game choices

```gdscript
func _mod_ready() -> void:
	add_new_game_choice(&"ironman", "Ironman", ["Off", "On"], 0, "One life. If you fall, the run is over.")

func _is_ironman() -> bool:
	return choice(&"ironman") == "On"
```

`add_new_game_choice(key, label, choices, default_index, text)` shows on the Game Rules screen after New Game.
`choice(key)` returns the picked entry from `choices` for the game being played. Loading an older save gives back the
choices it was started with.
