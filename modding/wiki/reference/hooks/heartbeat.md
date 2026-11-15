# heartbeat

<span class="hook-kind event">event</span> &nbsp; Game flow

Every six-second round of play, the original game's own heartbeat. Not during conversations.

## Signature

```gdscript
on(&"heartbeat", func(seconds: float): ...)
```

| Argument | Type | What |
|---|---|---|
| `seconds` | `float` | the length of a round: 6 |


## Where the game calls it

kotor_world_events.gd

## Example

```gdscript
func _mod_ready() -> void:
	on(&"heartbeat", func(_seconds: float):
		save_data()["hunger"] = float(save_data().get("hunger", 0.0)) + 0.5)
```
