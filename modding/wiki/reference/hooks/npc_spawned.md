# npc_spawned

<span class="hook-kind event">event</span> &nbsp; Combat and survival

A creature has been placed in a level and its model built: anyone but the player and companions.

## Signature

```gdscript
on(&"npc_spawned", func(npc: Node3D): ...)
```

| Argument | Type | What |
|---|---|---|
| `npc` | `Node3D` | the creature, a KotorNPC (KotorDroid or KotorHumanoid) |


## Where the game calls it

KotorWorldEvents.creature_spawned, after the scene's own spawned()

## Notes

The place to give a creature something extra: a light, a particle effect, a child node with a script of the mod's. Its settings (sight_range, ability_chance, idle_chatter, never_throws, throws_grenades) can be changed here too.

## Example

```gdscript
func _mod_ready() -> void:
	on(&"npc_spawned", func(npc: Node3D) -> void:
		if npc is KotorDroid:
			npc.sight_range = 30.0)
```
