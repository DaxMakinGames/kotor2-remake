extends KotorMod
## Hardcore: the test mod for mod support (MODDING.md). Every number is a setting on the Mods screen and in Options;
## Ironman is chosen once, when a new game starts. Uses only the public hooks.

const PARTY_HURT := ["player", "party"]


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
	on(&"game_started", func(new_game: bool):
		if _ironman():
			Kotor.notice.emit("Ironman: one life")
		save_data()["started_as"] = "ironman" if _ironman() else "normal")


func _ironman() -> bool:
	return String(choice(&"ironman")) == "On"


func _is_enemy(n: Variant) -> bool:
	return n is Node and is_instance_valid(n) and (n as Node).is_in_group(&"hostile")


func _harder_hits(damage: int, ctx: Dictionary) -> int:
	var victim: Variant = ctx.get("victim")
	var hits_party: bool = victim is Node and is_instance_valid(victim) and ((victim as Node).is_in_group(&"player") or Kotor.party.has(victim))
	return roundi(damage * float(setting(&"enemy_damage"))) if hits_party and _is_enemy(ctx.get("attacker")) else damage


func _fell() -> void:
	if not _ironman():
		return
	save_data()["fell"] = true
	write_log("ironman: the run is over")
	Kotor.checkpoint.forget()          # the autosave goes: Continue can't bring this run back
	Kotor.all_is_lost()
