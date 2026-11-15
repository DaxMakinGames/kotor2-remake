# Hooks explained

A hook is a place where the game lets mods in. There are two kinds.

## Modifiers: change a value

Before the game uses a number or a decision, it asks every mod that hooked it. Each one gets the value and returns
it, changed or not:

```gdscript
hook(&"damage_dealt", func(damage: int, ctx: Dictionary) -> int:
	return damage * 2)
```

- **value**: what the game was about to use, already changed by any mod before yours.
- **ctx**: a Dictionary of what's involved, such as the attacker and victim. Each hook's page lists its keys.
- **Return** the value to use. Returning `null` keeps it as it was.

Mods run in [load order](compatibility.md), each changing what the last returned. So **change the value you're
given** (`damage * 2`, `damage + 3`) instead of computing a new one from scratch. That way every mod's change
counts.

## Events: hear that something happened

```gdscript
on(&"died", func(who: Node3D, killer):
	write_log("%s died" % who.name))
```

Every mod listening hears it, with the arguments on the hook's page. Events can't change anything themselves, but you
can act on them: give items, change your saved state, show a notice.

## Getting it wrong is safe

If you misspell a hook, or use `on()` with a modifier, the game refuses it and says why in its log:

```
Mod double_xp: there's no hook called xp_awarded (MODDING.md lists them)
Mod double_xp: damage_dealt is an modifier, not a event: use hook()
```

## Cost

With no mods hooked in, the game skips straight past every hook. One mod adds a function call. Keep hooks that run
often (`script_run`, `damage_dealt`, `skill`) cheap: no searching the scene, no file reads.

## Every hook

The [Hook reference](../reference/hooks/index.md) lists all of them by system, with the arguments, where the game calls
each one, and an example.
