# Replacing script functions

The story runs on the original game's compiled scripts, and they call NWScript functions such as `GetGlobalNumber`,
`CreateObject` and `GiveXPToCreature`. A mod can replace any of them, or wrap one and still call the game's own.

```gdscript
func _mod_ready() -> void:
	# twice the experience the story gives
	script_function("GiveXPToCreature", func(args: Array, vm, original: Callable) -> Variant:
		args[1] = int(args[1]) * 2
		return original.call(args, vm))
```

- **`args`**: the function's arguments, in the order the NWScript documentation gives them.
- **`vm`**: the script that's running. Pass it on to `original`.
- **`original`**: the game's own version. Call it to keep its behavior, or don't to replace it completely.

A mod can also supply a function the game doesn't have yet. The game's log lists those as
`Script engine: X is not implemented yet`.

> [!WARNING]
> These functions are what the story is built on. Change what they return only when you're sure no quest depends on
> it, and prefer the [hooks](hooks.md) when one fits. Only one mod can replace a given function: the last to load wins.
