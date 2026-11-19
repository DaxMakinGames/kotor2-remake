# store_bought

<span class="hook-kind event">event</span> &nbsp; Stores and minigames

The player bought an item.

## Signature

```gdscript
on(&"store_bought", func(store: String, resref: String, price: int): ...)
```

| Argument | Type | What |
|---|---|---|
| `store` | `String` | the store's tag |
| `resref` | `String` | the item |
| `price` | `int` | what it cost |


## Where the game calls it

KotorStoreUI

## Example

```gdscript
func _mod_ready() -> void:
	on(&"store_bought", func(_store: String, resref: String, price: int):
		write_log("bought %s for %d" % [resref, price]))
```
