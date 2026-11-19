# influence_changed

<span class="hook-kind event">event</span> &nbsp; Companions and alignment

A companion's influence moved, after it was kept within 0 to 100. The game also says "Influence gained" or "lost" on screen.

## Signature

```gdscript
on(&"influence_changed", func(npc: int, influence: int, amount: int): ...)
```

| Argument | Type | What |
|---|---|---|
| `npc` | `int` | the companion's party slot |
| `influence` | `int` | their influence now |
| `amount` | `int` | how far it really moved |


## Where the game calls it

Kotor.change_influence

## Example

```gdscript
func _mod_ready() -> void:
	on(&"influence_changed", func(npc: int, now: int, _amount: int):
		if now >= 90:
			write_log("slot %d is devoted" % npc))
```
