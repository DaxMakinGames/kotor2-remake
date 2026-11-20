# skill

<span class="hook-kind modifier">modifier</span> &nbsp; Character and progress

A character's total in a skill, used everywhere the game checks one: locks, computers, crafting, conversation.

## Signature

```gdscript
hook(&"skill", func(value: int, ctx: Dictionary) -> int: ...)
```

**Value:** `int`, ranks plus ability, gear, feats and effects. Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `key` | `String` | whose: "player" or a companion's template, such as "p_atton" |
| `skill` | `int` | 0 Computer Use, 1 Demolitions, 2 Stealth, 3 Awareness, 4 Persuade, 5 Repair, 6 Security, 7 Treat Injury |

## Where the game calls it

Kotor.stats.skill

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"skill", func(total: int, ctx: Dictionary) -> int:
		return total + 5 if ctx["skill"] == 6 else total)
```
