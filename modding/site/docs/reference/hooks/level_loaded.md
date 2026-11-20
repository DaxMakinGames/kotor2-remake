# level_loaded

<span class="hook-kind event">event</span> &nbsp; Game flow

A level has finished loading and the player is in it.

## Signature

```gdscript
on(&"level_loaded", func(module: String): ...)
```

| Argument | Type | What |
|---|---|---|
| `module` | `String` | the level's name, such as "101per" |


## Where the game calls it

room_loader.gd, once loaded is true

## Example

```gdscript
func _mod_ready() -> void:
	on(&"level_loaded", func(module: String):
		write_log("arrived in " + module))
```
