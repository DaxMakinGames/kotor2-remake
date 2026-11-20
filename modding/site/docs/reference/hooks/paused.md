# paused

<span class="hook-kind event">event</span> &nbsp; Game flow

The pause menu has opened or closed.

## Signature

```gdscript
on(&"paused", func(open: bool): ...)
```

| Argument | Type | What |
|---|---|---|
| `open` | `bool` | true when it opens |


## Where the game calls it

kotor_pause_menu.gd

## Example

```gdscript
func _mod_ready() -> void:
	on(&"paused", func(open: bool): _clock_running = not open)
```
