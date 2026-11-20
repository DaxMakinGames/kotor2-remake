# can_attack

<span class="hook-kind modifier">modifier</span> &nbsp; Combat and survival

Whether an attack happens at all, asked before the roll. Return false to hold it back.

## Signature

```gdscript
hook(&"can_attack", func(value: bool, ctx: Dictionary) -> bool: ...)
```

**Value:** `bool`, true unless another mod already said no. Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `attacker` | `Node3D` | who's attacking |
| `target` | `Node3D` | who or what they're attacking (a creature, door or object) |
| `weapon` | `Dictionary` | the attacker's weapon's item data; empty for fists or a creature's natural weapon |

## Where the game calls it

KotorCombat.resolve, before the attack roll

## Notes

A held-back attack has no roll, no sound and no damage. Return the value you're given when you don't mind, so another mod's false stands.

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"can_attack", func(ok: bool, ctx: Dictionary) -> bool:
		var w: Dictionary = ctx["weapon"]
		if ctx["attacker"] == Kotor._player() and String(w.get("resref", "")).begins_with("w_blstrrfl"):
			return false     # no rifles for the Exile
		return ok)
```
