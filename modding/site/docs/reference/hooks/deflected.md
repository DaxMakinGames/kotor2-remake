# deflected

<span class="hook-kind event">event</span> &nbsp; Combat and survival

A bolt was turned aside, with the damage it would have done.

## Signature

```gdscript
on(&"deflected", func(victim: Node3D, attacker: Node3D, damage: int): ...)
```

| Argument | Type | What |
|---|---|---|
| `victim` | `Node3D` | who turned it aside |
| `attacker` | `Node3D` | who fired it |
| `damage` | `int` | what it would have done |


## Where the game calls it

KotorCombat.resolve, when a deflect_chance roll succeeds

## Notes

KotorCombat.hurt(attacker, damage) sends the damage back, as Lightsaber Duelist does for some bolts.

## Example

```gdscript
func _mod_ready() -> void:
	on(&"deflected", func(victim: Node3D, attacker: Node3D, damage: int):
		if victim == Kotor._player() and randf() < 0.3:
			KotorCombat.hurt(attacker, damage))
```
