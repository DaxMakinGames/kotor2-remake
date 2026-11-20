# container_opened

<span class="hook-kind event">event</span> &nbsp; Story and world

The player has opened a container: a footlocker, a corpse, a crate.

## Signature

```gdscript
on(&"container_opened", func(container: Node3D): ...)
```

| Argument | Type | What |
|---|---|---|
| `container` | `Node3D` | the container |


## Where the game calls it

Kotor.begin_container

## Example

```gdscript
func _mod_ready() -> void:
	on(&"container_opened", func(_box): save_data()["looted"] = int(save_data().get("looted", 0)) + 1)
```
