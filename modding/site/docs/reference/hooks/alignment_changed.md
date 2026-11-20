# alignment_changed

<span class="hook-kind event">event</span> &nbsp; Companions and alignment

An alignment shifted.

## Signature

```gdscript
on(&"alignment_changed", func(who: String, alignment: int, amount: int): ...)
```

| Argument | Type | What |
|---|---|---|
| `who` | `String` | "player" or a companion's template |
| `alignment` | `int` | where they are now |
| `amount` | `int` | how far it moved |


## Where the game calls it

Kotor.shift_alignment and Kotor.shift_npc_alignment

## Example

```gdscript
func _mod_ready() -> void:
	on(&"alignment_changed", func(who: String, now: int, _amount: int):
		if who == "player" and now == 0:
			write_log("fallen"))
```
