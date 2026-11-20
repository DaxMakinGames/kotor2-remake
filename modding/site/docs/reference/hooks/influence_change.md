# influence_change

<span class="hook-kind modifier">modifier</span> &nbsp; Companions and alignment

How much a companion's influence moves when a conversation or script changes it (ModifyInfluence).

## Signature

```gdscript
hook(&"influence_change", func(value: int, ctx: Dictionary) -> int: ...)
```

**Value:** `int`, the change, + for gained and - for lost. Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `npc` | `int` | the companion's party slot (0 Atton, 1 Bao-Dur, 2 Mandalore, ...) |
| `influence` | `int` | their influence before the change, 0 to 100 |
| `template` | `String` | their template, p_atton and so on |

## Where the game calls it

Kotor.change_influence

## Notes

Influence stays within 0 to 100 whatever you return. Everyone starts at 50.

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"influence_change", func(amount: int, _ctx: Dictionary) -> int: return amount * 2)
```
