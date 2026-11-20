# level_up

<span class="hook-kind event">event</span> &nbsp; Character and progress

Someone has taken a level.

## Signature

```gdscript
on(&"level_up", func(key: String, level: int): ...)
```

| Argument | Type | What |
|---|---|---|
| `key` | `String` | who |
| `level` | `int` | their new level |


## Where the game calls it

Kotor.stats.apply_level_up

## Example

```gdscript
func _mod_ready() -> void:
	on(&"level_up", func(key: String, level: int):
		if level == 5: give_item("g_i_medeqpmnt02"))
```
