# defense

<span class="hook-kind modifier">modifier</span> &nbsp; Combat and survival

Someone's defense, what an attack roll must reach to hit them.

## Signature

```gdscript
hook(&"defense", func(value: int, ctx: Dictionary) -> int: ...)
```

**Value:** `int`, 10 plus Dexterity, armor and Force effects. Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `victim` | `Node3D` | who is being attacked |

## Where the game calls it

KotorCombat._defense

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"defense", func(defense: int, ctx: Dictionary) -> int:
		return defense - 2 if ctx["victim"] == Kotor._player() else defense)
```
