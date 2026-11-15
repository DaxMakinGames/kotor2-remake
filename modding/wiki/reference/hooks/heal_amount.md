# heal_amount

<span class="hook-kind modifier">modifier</span> &nbsp; Combat and survival

How much a medpac or repair kit heals.

## Signature

```gdscript
hook(&"heal_amount", func(value: int, ctx: Dictionary) -> int: ...)
```

**Value:** `int`, the item's own amount plus Wisdom or Intelligence and Treat Injury or Repair. Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `item` | `String` | the item's resref |
| `who` | `Node3D` | who is healed |

## Where the game calls it

kotor_quick_items.gd (_heal)

## Notes

The result is never below 1.

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"heal_amount", func(amount: int, _ctx: Dictionary) -> int: return amount / 2)
```
