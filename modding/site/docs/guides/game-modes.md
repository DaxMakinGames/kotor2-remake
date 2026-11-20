# Making a game mode

A game mode is usually a handful of modifiers, a setting or two, and maybe a new-game choice. Here's how the common
ones are put together. [Hardcore](../examples/hardcore.md) is a complete one.

## Harder

| Change | Hook |
|---|---|
| Enemies hit harder | [damage_dealt](../reference/hooks/damage_dealt.md) where the victim is the player or the party |
| Enemies hit more often | [attack_bonus](../reference/hooks/attack_bonus.md) where the attacker is hostile |
| No healing over time | [regen_rate](../reference/hooks/regen_rate.md) → 0 |
| Weaker medpacs | [heal_amount](../reference/hooks/heal_amount.md) |
| Slower shields | [shield_rate](../reference/hooks/shield_rate.md) |
| Costlier Force powers | [force_cost](../reference/hooks/force_cost.md) |
| Quicker enemies | [enemy_think](../reference/hooks/enemy_think.md) |

## Easier (story mode)

The same hooks the other way. You take half damage, hit 3 more often, and regenerate in combat too:

```gdscript
extends KotorMod

func _party(n) -> bool:
	return n is Node and (n.is_in_group(&"player") or Kotor.party.has(n))

func _mod_ready() -> void:
	hook(&"damage_dealt", func(d: int, ctx: Dictionary) -> int: return maxi(d / 2, 1) if _party(ctx["victim"]) else d)
	hook(&"attack_bonus", func(b: int, ctx: Dictionary) -> int: return b + 3 if _party(ctx["attacker"]) else b)
	hook(&"xp_award", func(xp: int, _ctx: Dictionary) -> int: return roundi(xp * 1.5))
```

## Ironman

- A new-game choice: `add_new_game_choice(&"ironman", ...)`.
- Hide loading: [can_load](../reference/hooks/can_load.md) returns false.
- End the run when you fall: [player_down](../reference/hooks/player_down.md) calls `Kotor.all_is_lost()`.

## Survival

- **Hunger and fatigue** live in [save_data()](saving.md).
- **[heartbeat](../reference/hooks/heartbeat.md)** and **[level_leaving](../reference/hooks/level_leaving.md)**
  lower them.
- **[skill](../reference/hooks/skill.md)** and **[attack_bonus](../reference/hooks/attack_bonus.md)** drop as they
  fall.
- **Ration items** are added with [add_item](items.md). Using one raises the values; listen for
  [item_removed](../reference/hooks/item_removed.md).
- **A HUD bar:** add a `CanvasLayer` scene from your mod when [level_loaded](../reference/hooks/level_loaded.md) fires.

## Randomizer

A seed chosen as a new-game choice and stored in `save_data()`, so reloading gives the same layout. Shuffle starting
gear and stats on `game_started`. Shuffling loot and enemies needs the `container_loot` and `creature_spawn` hooks,
which are planned. Never move items or creatures marked `plot`: the story needs them where they are.
