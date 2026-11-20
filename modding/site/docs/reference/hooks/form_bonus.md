# form_bonus

<span class="hook-kind modifier">modifier</span> &nbsp; Lightsabers and forms

One of a form's numbers, as it applies right now: a lightsaber form (Shii-Cho to Juyo) or a Force form (Force Channel to Force Mastery).

## Signature

```gdscript
hook(&"form_bonus", func(value: float, ctx: Dictionary) -> float: ...)
```

**Value:** `float`, the total from the forms the character has up: points of attack, defense, deflection, threat range and so on, or a percentage for the Force forms' costs and regeneration. Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `who` | `Node` | the character |
| `what` | `String` | attack, defense, damage, deflect, threat, crit_mult, attacks, crit_attack, fp_cost_pct, fp_regen_pct, regen_in_combat... (KotorForms.FORMS) |

## Where the game calls it

KotorForms.bonus

## Notes

Defense against your current target and attack against a lightsaber are already counted in when they apply. Force forms' costs and regeneration are read by key through KotorForms.force_bonus, which this hook doesn't cover yet.

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"form_bonus", func(value: float, ctx: Dictionary) -> float:
		return value * 2.0 if ctx["what"] == "deflect" else value)
```
