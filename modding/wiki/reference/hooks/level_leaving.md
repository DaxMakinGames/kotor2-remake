# level_leaving

<span class="hook-kind event">event</span> &nbsp; Game flow

The player is about to leave a level for another one.

## Signature

```gdscript
on(&"level_leaving", func(module: String, to: String): ...)
```

| Argument | Type | What |
|---|---|---|
| `module` | `String` | the level being left |
| `to` | `String` | the level they're going to |


## Where the game calls it

Kotor.request_transition

## Notes

A good moment for survival-style clocks: time passes on the way.

## Example

```gdscript
func _mod_ready() -> void:
	on(&"level_leaving", func(from: String, to: String):
		save_data()["trips"] = int(save_data().get("trips", 0)) + 1)
```
