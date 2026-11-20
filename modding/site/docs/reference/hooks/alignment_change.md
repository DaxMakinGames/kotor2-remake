# alignment_change

<span class="hook-kind modifier">modifier</span> &nbsp; Companions and alignment

How far an alignment shifts: the player's, or a companion's (their own, or following the player's when influence pulls them).

## Signature

```gdscript
hook(&"alignment_change", func(value: int, ctx: Dictionary) -> int: ...)
```

**Value:** `int`, the shift, + towards the light side and - towards the dark. Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `who` | `String` | "player" or the companion's template |
| `alignment` | `int` | where they are before the shift, 0 (dark) to 100 (light) |

## Where the game calls it

Kotor.shift_alignment and Kotor.shift_npc_alignment

## Notes

Companions follow the player's shifts by (influence - 50) / 50: all the way at 100, not at all at 50, the other way below.

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"alignment_change", func(amount: int, ctx: Dictionary) -> int:
		return amount * 2 if ctx["who"] == "player" and amount < 0 else amount)
```
