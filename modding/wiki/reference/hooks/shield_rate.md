# shield_rate

<span class="hook-kind modifier">modifier</span> &nbsp; Combat and survival

How fast the player's shield recharges, in points per second.

## Signature

```gdscript
hook(&"shield_rate", func(value: float, ctx: Dictionary) -> float: ...)
```

**Value:** `float`, 5.0 in the base game. Return it, changed or not. Returning `null` keeps it.

**ctx** is empty.

## Where the game calls it

Kotor._recover

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"shield_rate", func(rate: float, _ctx: Dictionary) -> float: return rate * 0.5)
```
