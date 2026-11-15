# damaged

<span class="hook-kind event">event</span> &nbsp; Combat and survival

Someone has taken damage.

## Signature

```gdscript
on(&"damaged", func(attacker: Node3D, victim: Node3D, amount: int): ...)
```

| Argument | Type | What |
|---|---|---|
| `attacker` | `Node3D` | who did it |
| `victim` | `Node3D` | who took it |
| `amount` | `int` | how much landed, before shields on the player |


## Where the game calls it

KotorCombat._take_damage

## Example

```gdscript
func _mod_ready() -> void:
	on(&"damaged", func(_from, to, amount: int):
		if to == Kotor._player() and amount >= 20:
			Kotor.notice.emit("That one hurt"))
```
