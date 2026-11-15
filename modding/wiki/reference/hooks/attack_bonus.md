# attack_bonus

<span class="hook-kind modifier">modifier</span> &nbsp; Combat and survival

The attack bonus for one attack roll, the d20 roll plus this against the target's defense.

## Signature

```gdscript
hook(&"attack_bonus", func(value: int, ctx: Dictionary) -> int: ...)
```

**Value:** `int`, the bonus from level, ability, gear and Force effects. Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `attacker` | `Node3D` | who is attacking |
| `target` | `Node3D or null` | who they're attacking |

## Where the game calls it

KotorCombat._attack_bonus

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"attack_bonus", func(bonus: int, ctx: Dictionary) -> int:
		var a = ctx["attacker"]
		return bonus + 2 if a is Node and a.is_in_group(&"hostile") else bonus)
```
