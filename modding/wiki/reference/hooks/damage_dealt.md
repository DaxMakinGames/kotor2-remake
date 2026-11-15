# damage_dealt

<span class="hook-kind modifier">modifier</span> &nbsp; Combat and survival

Damage about to be taken, after resistances. Every kind passes here: blows, shots, grenades, Force powers and scripts.

## Signature

```gdscript
hook(&"damage_dealt", func(value: int, ctx: Dictionary) -> int: ...)
```

**Value:** `int`, the damage, already above 0. Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `attacker` | `Node3D` | who did it (may be the victim, for some script damage) |
| `victim` | `Node3D` | who takes it |
| `type` | `int` | the damage type, 0 for an ordinary blow |

## Where the game calls it

KotorCombat._take_damage

## Notes

Shields and items still absorb what they can after this. Scripts that kill outright pass very large numbers, so lowering damage won't save someone a story scene means to kill.

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"damage_dealt", func(damage: int, ctx: Dictionary) -> int:
		var v = ctx["victim"]
		var party: bool = v is Node and (v.is_in_group(&"player") or Kotor.party.has(v))
		return roundi(damage * 1.5) if party else damage)
```
