# item_removed

<span class="hook-kind event">event</span> &nbsp; Character and progress

Items have left the party's inventory: used, sold, broken down or taken by a script.

## Signature

```gdscript
on(&"item_removed", func(resref: String, count: int): ...)
```

| Argument | Type | What |
|---|---|---|
| `resref` | `String` | the item |
| `count` | `int` | how many |


## Where the game calls it

Kotor.remove_item

## Example

```gdscript
func _mod_ready() -> void:
	on(&"item_removed", func(resref: String, _count: int): pass)
```
