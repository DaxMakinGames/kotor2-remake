# xp_award

<span class="hook-kind modifier">modifier</span> &nbsp; Character and progress

Experience about to be given, for a kill or by the story.

## Signature

```gdscript
hook(&"xp_award", func(value: int, ctx: Dictionary) -> int: ...)
```

**Value:** `int`, the experience. Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `source` | `String` | "kill" for a kill, "story" for a script's reward, or a mod's own word |
| `victim` | `Node3D` | who was killed (only when source is "kill") |

## Where the game calls it

Kotor.give_xp

## Notes

Return 0 to give none: nothing is shown either.

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"xp_award", func(xp: int, ctx: Dictionary) -> int:
		return 0 if ctx.get("source") == "kill" else xp * 2)
```
