# can_equip

<span class="hook-kind modifier">modifier</span> &nbsp; Character and progress

Whether someone may put an item on.

## Signature

```gdscript
hook(&"can_equip", func(value: bool, ctx: Dictionary) -> bool: ...)
```

**Value:** `bool`, true to allow it. Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `key` | `String` | who |
| `slot` | `String` | the slot: head, implant, armor, gauntlet, belt, right_arm, left_arm, right_hand |
| `resref` | `String` | the item |

## Where the game calls it

Kotor.stats.equip

## Notes

When refused, the player is told "Can't equip that".

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"can_equip", func(ok: bool, ctx: Dictionary) -> bool:
		return ok and not (ctx["slot"] == "armor" and Kotor.stats.level_of(ctx["key"]) < 3))
```
