# game_started

<span class="hook-kind event">event</span> &nbsp; Game flow

A game has begun: a new one, once character creation finishes, or a saved one, once it has finished loading.

## Signature

```gdscript
on(&"game_started", func(new_game: bool): ...)
```

| Argument | Type | What |
|---|---|---|
| `new_game` | `bool` | true for a new game, false for a loaded save |


## Where the game calls it

kotor_character_creation.gd (begin) and kotor_checkpoint.gd (once the loaded level is up)

## Notes

Your save_data() is already filled in when this runs, so check it before handing anything out twice.

## Example

```gdscript
func _mod_ready() -> void:
	on(&"game_started", func(new_game: bool):
		if new_game:
			give_item("g_i_medeqpmnt01", 3))
```
