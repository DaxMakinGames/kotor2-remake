# died

<span class="hook-kind event">event</span> &nbsp; Combat and survival

A creature has died (not a party member going down).

## Signature

```gdscript
on(&"died", func(who: Node3D, killer: Node3D): ...)
```

| Argument | Type | What |
|---|---|---|
| `who` | `Node3D` | who died |
| `killer` | `Node3D or null` | the last one to hit them |


## Where the game calls it

KotorCombat._die

## Example

```gdscript
func _mod_ready() -> void:
	on(&"died", func(who: Node3D, killer):
		if killer == Kotor._player():
			save_data()["kills"] = int(save_data().get("kills", 0)) + 1)
```
