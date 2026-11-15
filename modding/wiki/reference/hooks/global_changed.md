# global_changed

<span class="hook-kind event">event</span> &nbsp; Story and world

One of the story's global numbers or booleans has changed. This is how the original scripts record progress.

## Signature

```gdscript
on(&"global_changed", func(name: String, value: int): ...)
```

| Argument | Type | What |
|---|---|---|
| `name` | `String` | the global's name, such as "101PER_Kreia_Joined" |
| `value` | `int or bool` | its new value |


## Where the game calls it

Kotor.set_global and Kotor.set_global_bool

## Notes

Read globals freely; never change the story's own. Keep your mod's state in save_data().

## Example

```gdscript
func _mod_ready() -> void:
	on(&"global_changed", func(name: String, value):
		if name == "101PER_Kreia_Joined" and value: Kotor.notice.emit("Kreia joins you"))
```
