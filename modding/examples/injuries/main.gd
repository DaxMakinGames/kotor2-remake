extends KotorMod
## Injuries: a blow that takes a big share of someone's health may injure them; falling always does. Each injury is a
## penalty through the public hooks, kept per character in the save, until a medical station (000_medstation) treats it.

const INJURIES := {
	"broken_arm": {"name": "Broken arm", "what": "-2 to attack"},
	"cracked_ribs": {"name": "Cracked ribs", "what": "-2 to defense"},
	"torn_muscle": {"name": "Torn muscle", "what": "a quarter less damage"},
	"concussion": {"name": "Concussion", "what": "-2 to every skill"},
}
const MOST := 3                          # injuries one character can carry


func _mod_ready() -> void:
	add_option(&"heavy_share", "A heavy blow takes this share of health", TYPE_FLOAT, 0.3, 0.1, 0.6, 0.05)
	add_option(&"chance", "Chance a heavy blow injures", TYPE_FLOAT, 0.5, 0.0, 1.0, 0.05)
	add_option(&"falling_injures", "Falling in battle always injures", TYPE_BOOL, true)
	add_option(&"medpacs_treat", "A medpac treats one injury too", TYPE_BOOL, false)
	on(&"damaged", _hit)
	on(&"conversation_started", func(conv: String, _owner: Node):
		if conv.to_lower().contains("medstation"):
			_treat_everyone())
	hook(&"attack_bonus", func(bonus: int, ctx: Dictionary) -> int:
		return bonus - 2 if _has(ctx.get("attacker"), "broken_arm") else bonus)
	hook(&"defense", func(defense: int, ctx: Dictionary) -> int:
		return defense - 2 if _has(ctx.get("victim"), "cracked_ribs") else defense)
	hook(&"damage_dealt", func(damage: int, ctx: Dictionary) -> int:
		return roundi(damage * 0.75) if _has(ctx.get("attacker"), "torn_muscle") else damage)
	hook(&"skill", func(rank: int, ctx: Dictionary) -> int:
		return rank - 2 if "concussion" in _of(String(ctx.get("key", ""))) else rank)
	hook(&"heal_amount", func(amount: int, ctx: Dictionary) -> int:
		if bool(setting(&"medpacs_treat")):
			_treat_one(ctx.get("who"))
		return amount)


## a character's injuries, by their sheet key ("player", "atton", ...)
func _of(key: String) -> Array:
	return save_data().get("injuries", {}).get(key, [])


func _key(n: Variant) -> String:
	if not (n is Node and is_instance_valid(n)):
		return ""
	var who := n as Node
	if not (who.is_in_group(&"player") or Kotor.party.has(who)):
		return ""                            # only the party is hurt this way
	return String(Kotor.stats.key_of(who))


func _has(n: Variant, injury: String) -> bool:
	var key := _key(n)
	return key != "" and injury in _of(key)


func _hit(_attacker: Node3D, victim: Node3D, amount: int) -> void:
	var key := _key(victim)
	if key == "" or amount <= 0:
		return
	var fell := KotorCombat.is_down(victim) or KotorCombat.hit_points(victim) <= 0
	var heavy := amount >= KotorCombat.max_hit_points(victim) * float(setting(&"heavy_share"))
	if (fell and bool(setting(&"falling_injures"))) or (heavy and randf() < float(setting(&"chance"))):
		_injure(victim, key)


func _injure(victim: Node3D, key: String) -> void:
	var have: Array = _of(key).duplicate()
	if have.size() >= MOST:
		return
	var left := INJURIES.keys().filter(func(i): return not have.has(i))
	if left.is_empty():
		return
	var got: String = left.pick_random()
	have.append(got)
	var all: Dictionary = save_data().get("injuries", {})
	all[key] = have
	save_data()["injuries"] = all
	Kotor.notice.emit("%s: %s (%s until treated)" % [KotorCombat.display_name(victim), INJURIES[got]["name"], INJURIES[got]["what"]])
	write_log("%s injured: %s" % [key, got])


func _treat_everyone() -> void:
	var all: Dictionary = save_data().get("injuries", {})
	var count := 0
	for key in all:
		count += (all[key] as Array).size()
	if count == 0:
		return
	save_data()["injuries"] = {}
	Kotor.notice.emit("The medical station treats %d injur%s" % [count, "y" if count == 1 else "ies"])


func _treat_one(who: Variant) -> void:
	var key := _key(who)
	if key == "" or _of(key).is_empty():
		return
	var have: Array = _of(key).duplicate()
	var healed: String = have.pop_front()
	var all: Dictionary = save_data().get("injuries", {})
	all[key] = have
	save_data()["injuries"] = all
	Kotor.notice.emit("%s: %s treated" % [KotorCombat.display_name(who), INJURIES[healed]["name"]])
