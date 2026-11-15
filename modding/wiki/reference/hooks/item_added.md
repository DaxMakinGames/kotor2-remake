# item_added

<span class="hook-kind event">event</span> &nbsp; Character and progress

Items have gone into the party's inventory.

## Signature

```gdscript
on(&"item_added", func(resref: String, count: int): ...)
```

| Argument | Type | What |
|---|---|---|
| `resref` | `String` | the item |
| `count` | `int` | how many |


## Where the game calls it

Kotor.add_item

## Example

```gdscript
func _mod_ready() -> void:
	on(&"item_added", func(resref: String, count: int): write_log("+%d %s" % [count, resref]))
```
