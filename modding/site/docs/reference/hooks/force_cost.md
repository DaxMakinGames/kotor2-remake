# force_cost

<span class="hook-kind modifier">modifier</span> &nbsp; Character and progress

What a Force power costs to use.

## Signature

```gdscript
hook(&"force_cost", func(value: int, ctx: Dictionary) -> int: ...)
```

**Value:** `int`, the power's cost, scaled by alignment. Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `key` | `String` | who is using it |
| `power` | `int` | the power's row in spells.2da |

## Where the game calls it

Kotor.force.cost_of

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"force_cost", func(cost: int, _ctx: Dictionary) -> int: return ceili(cost * 1.25))
```
