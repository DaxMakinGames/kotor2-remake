# Hardcore

The test mod for mod support. Source: `modding/examples/hardcore`; packed as `modding/examples/dist/hardcore.zip`.

## What it does

| Setting | Default | Hook |
|---|---|---|
| Enemy damage | ×1.5 against the party | [damage_dealt](../reference/hooks/damage_dealt.md) |
| Enemy accuracy bonus | +2 | [attack_bonus](../reference/hooks/attack_bonus.md) |
| Health comes back on its own | off | [regen_rate](../reference/hooks/regen_rate.md) |
| Medpac strength | ×0.5 | [heal_amount](../reference/hooks/heal_amount.md) |
| Shield recharge speed | ×0.5 | [shield_rate](../reference/hooks/shield_rate.md) |
| Force power cost | ×1.25 | [force_cost](../reference/hooks/force_cost.md) |

**Ironman**, a new-game choice: Load is hidden ([can_load](../reference/hooks/can_load.md)); falling ends the run
([player_down](../reference/hooks/player_down.md)), deletes the autosave, and the game-over screen offers a new game.

## The whole script

```gdscript
extends KotorMod

func _mod_ready() -> void:
	add_option(&"enemy_damage", "Enemy damage", TYPE_FLOAT, 1.5, 1.0, 3.0, 0.25)
	add_option(&"enemy_accuracy", "Enemy accuracy bonus", TYPE_INT, 2, 0, 6)
	add_option(&"regeneration", "Health comes back on its own", TYPE_BOOL, false)
	add_option(&"healing", "Medpac strength", TYPE_FLOAT, 0.5, 0.25, 1.0, 0.05)
	add_option(&"shield_recharge", "Shield recharge speed", TYPE_FLOAT, 0.5, 0.0, 1.0, 0.1)
	add_option(&"force_cost", "Force power cost", TYPE_FLOAT, 1.25, 1.0, 2.0, 0.05)
	add_new_game_choice(&"ironman", "Ironman", ["Off", "On"], 0,
			"One life. If you fall, the run is over: no reviving, no loading. The autosave is deleted.")

	hook(&"damage_dealt", _harder_hits)
	hook(&"attack_bonus", func(bonus: int, ctx: Dictionary) -> int:
		return bonus + int(setting(&"enemy_accuracy")) if _is_enemy(ctx.get("attacker")) else bonus)
	hook(&"regen_rate", func(rate: float, _ctx: Dictionary) -> float:
		return rate if bool(setting(&"regeneration")) else 0.0)
	hook(&"heal_amount", func(amount: int, _ctx: Dictionary) -> int:
		return maxi(roundi(amount * float(setting(&"healing"))), 1))
	hook(&"shield_rate", func(rate: float, _ctx: Dictionary) -> float:
		return rate * float(setting(&"shield_recharge")))
	hook(&"force_cost", func(cost: int, _ctx: Dictionary) -> int:
		return ceili(cost * float(setting(&"force_cost"))))
	hook(&"can_load", func(allowed: bool, _ctx: Dictionary) -> bool:
		return allowed and not _ironman())
	on(&"player_down", _fell)
```

The rest of the file has the helpers `_ironman()`, `_is_enemy()`, `_harder_hits()` and `_fell()`. Read
`modding/examples/hardcore/main.gd` for them.
