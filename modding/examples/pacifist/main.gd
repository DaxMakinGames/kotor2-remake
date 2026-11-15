extends KotorMod
## Pacifist Run: kill experience is taken away (the xp_award hook's "kill" source), story experience raised, and an enemy
## met in a fight (either side attacked) who's still standing when the party leaves the level is "spared": experience,
## once per enemy. Kills are counted in the save; Strict says so the moment the first one happens.


func _mod_ready() -> void:
	add_option(&"kill_xp", "Experience for a kill (share)", TYPE_FLOAT, 0.0, 0.0, 1.0, 0.25)
	add_option(&"story_xp", "Experience for the story (times)", TYPE_FLOAT, 1.5, 1.0, 3.0, 0.25)
	add_option(&"spared_xp", "Experience per enemy spared", TYPE_INT, 25, 0, 200, 5)
	add_new_game_choice(&"strict", "Strict pacifist", ["Off", "On"], 0, "A single kill breaks the run, and the game tells you so.")
	hook(&"xp_award", func(amount: int, ctx: Dictionary) -> int:
		match String(ctx.get("source", "story")):
			"kill":
				return roundi(amount * float(setting(&"kill_xp")))
			"story":
				return roundi(amount * float(setting(&"story_xp")))
		return amount)
	on(&"game_started", func(new_game: bool):
		if new_game:
			save_data()["kills"] = 0
			save_data()["spared"] = []
			if String(choice(&"strict")) == "On":
				Kotor.notice.emit("Strict pacifist: take no lives"))
	on(&"attack_made", _met)
	on(&"died", _died)
	on(&"level_leaving", func(from: String, _to: String): _count_spared(from))
	on(&"run_finished", _summary)


func _ours(n: Variant) -> bool:
	return n is Node and is_instance_valid(n) and ((n as Node).is_in_group(&"player") or Kotor.party.has(n))


func _id(n: Node) -> String:
	return "%s/%s" % [Kotor.current_module, n.name]


## an enemy the party fought, either way round, for the count when it leaves
func _met(attacker: Node3D, target: Node3D, _hits: bool) -> void:
	var enemy: Node3D = target if _ours(attacker) else (attacker if _ours(target) else null)
	if enemy != null and is_instance_valid(enemy) and enemy.is_in_group(&"hostile"):
		enemy.set_meta(&"pacifist_met", true)


func _died(who: Node3D, killer: Node3D) -> void:
	if who == null or not is_instance_valid(who) or not who.is_in_group(&"hostile") or not _ours(killer):
		return
	var kills := int(save_data().get("kills", 0)) + 1
	save_data()["kills"] = kills
	if kills == 1 and String(choice(&"strict")) == "On":
		Kotor.notice.emit("The pacifist run is broken: a life was taken")
		save_data()["broken"] = true
	elif kills == 1:
		Kotor.notice.emit("First kill: no experience for it")


func _count_spared(_from: String) -> void:
	var spared: Array = save_data().get("spared", [])
	var count := 0
	for n in get_tree().get_nodes_in_group(&"hostile"):
		if n is Node3D and is_instance_valid(n) and n.get_meta(&"pacifist_met", false) and not KotorCombat.is_dead(n) and not spared.has(_id(n)):
			spared.append(_id(n))
			count += 1
	save_data()["spared"] = spared
	if count > 0 and int(setting(&"spared_xp")) > 0:
		Kotor.give_xp(count * int(setting(&"spared_xp")), {"source": "spared"})
		Kotor.notice.emit("Spared %d %s: +%d experience" % [count, "enemy" if count == 1 else "enemies", count * int(setting(&"spared_xp"))])


func _summary() -> void:
	var kills := int(save_data().get("kills", 0))
	var spared := (save_data().get("spared", []) as Array).size()
	Kotor.notice.emit("Pacifist run: %d kill%s, %d spared%s" % [kills, "" if kills == 1 else "s", spared, "  (a true pacifist)" if kills == 0 else ""])
	write_log("finished: %d kills, %d spared" % [kills, spared])
