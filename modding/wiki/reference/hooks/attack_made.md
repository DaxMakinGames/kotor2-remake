# attack_made

<span class="hook-kind event">event</span> &nbsp; Combat and survival

An attack roll has been made against a creature, and whether it hit.

## Signature

```gdscript
on(&"attack_made", func(attacker: Node3D, target: Node3D, hits: bool): ...)
```

| Argument | Type | What |
|---|---|---|
| `attacker` | `Node3D` | who attacked |
| `target` | `Node3D` | who was attacked |
| `hits` | `bool` | whether the roll hit (a deflected bolt still counts as a hit here) |


## Where the game calls it

KotorCombat.resolve, right after the roll

## Notes

Not called for attacks on doors and objects, or for attacks a can_attack hook held back.

## Example

```gdscript
func _mod_ready() -> void:
	on(&"attack_made", func(attacker: Node3D, _target: Node3D, hits: bool):
		if attacker == Kotor._player() and not hits:
			save_data()["misses"] = int(save_data().get("misses", 0)) + 1)
```
