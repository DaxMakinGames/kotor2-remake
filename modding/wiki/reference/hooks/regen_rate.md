# regen_rate

<span class="hook-kind modifier">modifier</span> &nbsp; Combat and survival

How fast health comes back out of combat, in points per second.

## Signature

```gdscript
hook(&"regen_rate", func(value: float, ctx: Dictionary) -> float: ...)
```

**Value:** `float`, 2.0 in the base game. Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `who` | `Node3D` | the player (companions get the same rate) |

## Where the game calls it

Kotor._recover

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"regen_rate", func(_rate: float, _ctx: Dictionary) -> float: return 0.0)
```
