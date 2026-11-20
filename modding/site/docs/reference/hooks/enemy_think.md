# enemy_think

<span class="hook-kind modifier">modifier</span> &nbsp; Combat and survival

Seconds between the enemies' decisions: who to fight, where to move, when to throw.

## Signature

```gdscript
hook(&"enemy_think", func(value: float, ctx: Dictionary) -> float: ...)
```

**Value:** `float`, 0.4 by default (data/tuning.tres). Return it, changed or not. Returning `null` keeps it.

**ctx** is empty.

## Where the game calls it

KotorEnemyAI._process

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"enemy_think", func(seconds: float, _ctx: Dictionary) -> float: return seconds * 0.5)
```
