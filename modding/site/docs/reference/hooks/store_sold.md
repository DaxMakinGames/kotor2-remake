# store_sold

<span class="hook-kind event">event</span> &nbsp; Stores and minigames

The player sold an item.

## Signature

```gdscript
on(&"store_sold", func(store: String, resref: String, price: int): ...)
```

| Argument | Type | What |
|---|---|---|
| `store` | `String` | the store's tag |
| `resref` | `String` | the item |
| `price` | `int` | what the store paid |


## Where the game calls it

KotorStoreUI

## Example

```gdscript
func _mod_ready() -> void:
	on(&"store_sold", func(_store: String, resref: String, price: int):
		write_log("sold %s for %d" % [resref, price]))
```
