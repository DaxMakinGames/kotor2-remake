# dark_stage

<span class="hook-kind modifier">modifier</span> &nbsp; Companions and alignment

How deep the dark side's marks show on the player's face: 0 for none, 1 to 4 for the four textures heads.2da gives each head (evil, very evil and so on).

## Signature

```gdscript
hook(&"dark_stage", func(value: int, ctx: Dictionary) -> int: ...)
```

**Value:** `int`, 0 to 4, from KotorCreature.DARK_STAGES (alignment 40, 30, 20 and 10 and below). Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `alignment` | `int` | the player's alignment |

## Where the game calls it

KotorCreature.dark_stage

## Notes

Return 0 to keep the face as it was made. The face changes when the stage does.

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"dark_stage", func(_stage: int, _ctx: Dictionary) -> int: return 0)
```
