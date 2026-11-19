# store_price

<span class="hook-kind modifier">modifier</span> &nbsp; Stores and minigames

What an item costs to buy at a store, or what the store pays for it.

## Signature

```gdscript
hook(&"store_price", func(value: int, ctx: Dictionary) -> int: ...)
```

**Value:** `int`, the price: the item's worth times the store's markup (buying) or markdown (selling), and what the store's script added. Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `store` | `String` | the store's tag |
| `resref` | `String` | the item |
| `buying` | `bool` | true when you buy, false when you sell |

## Where the game calls it

KotorStoreUI.buy_price and sell_price

## Notes

Never below 0 (and buying never below 1 before your hook).

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"store_price", func(price: int, ctx: Dictionary) -> int:
		return price * 3 / 2 if ctx["buying"] else price)
```
