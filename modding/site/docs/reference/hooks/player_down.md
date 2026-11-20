# player_down

<span class="hook-kind event">event</span> &nbsp; Combat and survival

The player has fallen. Unless a mod steps in, a companion can come and revive them.

## Signature

```gdscript
on(&"player_down", func(): ...)
```

No arguments.

## Where the game calls it

Kotor._player_down

## Example

```gdscript
func _mod_ready() -> void:
	on(&"player_down", func():
		if choice(&"ironman") == "On":
			Kotor.all_is_lost())
```
