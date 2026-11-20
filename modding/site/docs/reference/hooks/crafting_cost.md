# crafting_cost

<span class="hook-kind modifier">modifier</span> &nbsp; Character and progress

The components or chemicals an item takes to make at a workbench or lab station.

## Signature

```gdscript
hook(&"crafting_cost", func(value: int, ctx: Dictionary) -> int: ...)
```

**Value:** `int`, the item's worth divided by data/tuning.tres's credits_per_part. Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `station` | `String` | "bench" or "lab" |
| `item` | `String` | the item's resref |

## Where the game calls it

Kotor.crafting.cost_to_make

## Notes

The result is never below 1.

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"crafting_cost", func(cost: int, _ctx: Dictionary) -> int: return maxi(1, cost / 2))
```
