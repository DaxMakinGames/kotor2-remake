# can_load

<span class="hook-kind modifier">modifier</span> &nbsp; Game flow

Whether the player may load a save mid-game: the pause menu's Load button, and the game-over screen's Load Checkpoint.

## Signature

```gdscript
hook(&"can_load", func(value: bool, ctx: Dictionary) -> bool: ...)
```

**Value:** `bool`, true to allow loading. Return it, changed or not. Returning `null` keeps it.

**ctx** is empty.

## Where the game calls it

kotor_pause_menu.gd (open) and kotor_game_over.gd

## Notes

When false, the game-over screen offers New Game instead. Hardcore's Ironman uses this.

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"can_load", func(allowed: bool, _ctx: Dictionary) -> bool:
		return allowed and choice(&"ironman") != "On")
```
