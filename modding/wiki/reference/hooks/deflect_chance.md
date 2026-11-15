# deflect_chance

<span class="hook-kind modifier">modifier</span> &nbsp; Combat and survival

The chance that a ranged hit is turned aside by its target.

## Signature

```gdscript
hook(&"deflect_chance", func(value: float, ctx: Dictionary) -> float: ...)
```

**Value:** `float`, 0 to 1: the Force Deflect and Force Redirect powers give some, anyone else 0. Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `victim` | `Node3D` | who was hit |
| `attacker` | `Node3D` | who fired |

## Where the game calls it

KotorCombat._deflects, for a ranged attack that hit

## Notes

Asked only when the roll hit and the attacker's weapon is ranged.

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"deflect_chance", func(chance: float, ctx: Dictionary) -> float:
		if ctx["victim"] == Kotor._player():
			return maxf(chance, 0.25)
		return chance)
```
