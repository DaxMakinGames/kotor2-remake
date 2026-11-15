# door_opened

<span class="hook-kind event">event</span> &nbsp; Story and world

A door has opened, by anyone or any script.

## Signature

```gdscript
on(&"door_opened", func(door: Node3D): ...)
```

| Argument | Type | What |
|---|---|---|
| `door` | `Node3D` | the door (a KotorDoor) |


## Where the game calls it

door.gd (toggle)

## Example

```gdscript
func _mod_ready() -> void:
	on(&"door_opened", func(door: Node3D): pass)
```
