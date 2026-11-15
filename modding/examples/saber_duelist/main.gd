extends KotorMod
## Lightsaber Duelist: through the deflect_chance and deflected hooks, anyone of the party holding a lightsaber deflects
## bolts (on top of what Force Deflect gives), and a share of the deflected bolts fly back at the shooter for the damage
## they'd have done. Saber duels and saber blows get small bonuses through attack_bonus and damage_dealt.


func _mod_ready() -> void:
	add_option(&"deflect", "Chance a saber turns a bolt aside", TYPE_FLOAT, 0.35, 0.0, 0.9, 0.05)
	add_option(&"reflect", "Share of deflected bolts sent back", TYPE_FLOAT, 0.5, 0.0, 1.0, 0.05)
	add_option(&"duel_bonus", "Attack bonus, saber against saber", TYPE_INT, 2, 0, 6)
	add_option(&"saber_damage", "Saber damage (times)", TYPE_FLOAT, 1.1, 1.0, 2.0, 0.05)
	add_option(&"enemies_too", "Enemies with sabers get all this too", TYPE_BOOL, false)
	hook(&"deflect_chance", func(chance: float, ctx: Dictionary) -> float:
		var victim: Variant = ctx.get("victim")
		if _counts(victim) and KotorCombat.wields_saber(victim):
			return minf(chance + float(setting(&"deflect")), 0.95)
		return chance)
	on(&"deflected", _send_back)
	hook(&"attack_bonus", func(bonus: int, ctx: Dictionary) -> int:
		var a: Variant = ctx.get("attacker")
		var t: Variant = ctx.get("target")
		if _counts(a) and KotorCombat.wields_saber(a) and t is Node and is_instance_valid(t) and KotorCombat.wields_saber(t):
			return bonus + int(setting(&"duel_bonus"))
		return bonus)
	hook(&"damage_dealt", func(damage: int, ctx: Dictionary) -> int:
		var a: Variant = ctx.get("attacker")
		if _counts(a) and KotorCombat.wields_saber(a):
			return roundi(damage * float(setting(&"saber_damage")))
		return damage)


## the party, and enemies too if that's set
func _counts(n: Variant) -> bool:
	if not (n is Node and is_instance_valid(n)):
		return false
	var who := n as Node
	return who.is_in_group(&"player") or Kotor.party.has(who) or (bool(setting(&"enemies_too")) and who.is_in_group(&"hostile"))


func _send_back(victim: Node3D, attacker: Node3D, damage: int) -> void:
	if not _counts(victim) or not KotorCombat.wields_saber(victim) or attacker == null or not is_instance_valid(attacker):
		return
	if randf() >= float(setting(&"reflect")) or damage <= 0:
		return
	KotorVfx.bolt(KotorCombat.body_center(victim) + Vector3.UP * 0.1, KotorCombat.body_center(attacker), true)
	KotorCombat.hurt(victim, attacker, damage)
	var said := "%s sends the bolt back at %s" % [KotorCombat.display_name(victim), KotorCombat.display_name(attacker)]
	KotorCombat.log_line(said, said, "hit")         # the combat log, not a notice: in a firefight it happens a lot
