# npc_scene

<span class="hook-kind modifier">modifier</span> &nbsp; Combat and survival

The scene a creature in a level is made from: a mining droid, a droid, a person, or a mod's own kind.

## Signature

```gdscript
hook(&"npc_scene", func(value: String, ctx: Dictionary) -> String: ...)
```

**Value:** `String`, the game's pick, a scene's path (res://scenes/npc/...). Return another path, or a PackedScene. Return it, changed or not. Returning `null` keeps it.

**ctx** holds:

| Key | Type | What |
|---|---|---|
| `resref` | `String` | the creature's template |
| `appearance_id` | `int` | its row in appearance.2da |
| `body` | `String` | its body model's name, such as c_mk1_drd |
| `instance` | `Dictionary` | everything the level or template says about it |

## Where the game calls it

KotorNPC.create

## Notes

The scene's root must be a KotorNPC: inherit one of the game's (droid.tscn, humanoid.tscn, mining_droid.tscn). Anything else is ignored with a warning and the game's own scene is used. The model is built into whatever scene is picked, so it still looks like itself. A folder mod can't ship a scene with its own scripts; pack it as a .zip or .pck, or use npc_spawned to add to the game's scene instead. Companions aren't NPCs and never come here.

## Example

```gdscript
func _mod_ready() -> void:
	hook(&"npc_scene", func(scene: String, ctx: Dictionary) -> Variant:
		return "res://mods/tough_droids/elite_droid.tscn" if ctx.body == "c_mk2_drd" else null)
```
