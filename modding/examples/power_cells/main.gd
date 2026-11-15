extends KotorMod
## Power Cells: the party's blasters draw on one shared supply. "charge" in the save is what's left in the cell in use;
## the spare cells are an item in the inventory. Enemies' guns are left alone.

const CELL := "power_cell"


func _mod_ready() -> void:
	add_item(CELL, {"name": "Power cell", "base": 96, "cost": 25, "icon": "icons/power_cell.png",
			"text": "A sealed energy cell for blasters. A blaster swaps in a fresh one by itself when its cell runs dry.\n\n(Power Cells mod.)"})
	add_option(&"shots", "Shots per cell", TYPE_INT, 30, 5, 100, 5)
	add_option(&"start_with", "Cells at the start of a game", TYPE_INT, 3, 0, 10, 1)
	add_option(&"container_chance", "Chance a container holds cells", TYPE_FLOAT, 0.35, 0.0, 1.0, 0.05)
	add_option(&"body_chance", "Chance a fallen gunman carries one", TYPE_FLOAT, 0.5, 0.0, 1.0, 0.05)
	on(&"game_started", func(new_game: bool):
		if new_game:
			save_data()["charge"] = int(setting(&"shots"))
			save_data()["searched"] = []
			if int(setting(&"start_with")) > 0:
				give_item(CELL, int(setting(&"start_with")))
		elif not save_data().has("charge"):
			save_data()["charge"] = int(setting(&"shots")))       # a game from before the mod: a full cell to start
	hook(&"can_attack", _can_fire)
	on(&"attack_made", func(attacker: Node3D, _target: Node3D, _hits: bool):
		if _ours(attacker) and KotorCombat.is_ranged(attacker):
			save_data()["charge"] = maxi(int(save_data().get("charge", 0)) - 1, 0))
	on(&"container_opened", _search)
	on(&"died", func(who: Node3D, killer: Node3D):
		if who != null and is_instance_valid(who) and who.is_in_group(&"hostile") and KotorCombat.is_ranged(who) \
				and (_ours(killer) or killer == null) and randf() < float(setting(&"body_chance")):
			give_item(CELL, 1))


func _ours(n: Variant) -> bool:
	return n is Node and is_instance_valid(n) and ((n as Node).is_in_group(&"player") or Kotor.party.has(n))


func spare_cells() -> int:
	return int(Kotor.inventory.get(CELL, {}).get("count", 0))


func _can_fire(allowed: bool, ctx: Dictionary) -> bool:
	var who: Variant = ctx.get("attacker")
	if not allowed or not _ours(who) or not KotorCombat.is_ranged(who):
		return allowed
	if int(save_data().get("charge", 0)) > 0:
		return true
	if spare_cells() > 0:
		Kotor.remove_item(CELL, 1)
		save_data()["charge"] = int(setting(&"shots"))
		Kotor.notice.emit("Fresh power cell (%d spare)" % spare_cells())
		return true
	var now := Time.get_ticks_msec()
	if now - int(save_data().get("warned_at", -100000)) > 8000:      # once in a while, not every swing
		save_data()["warned_at"] = now
		Kotor.notice.emit("Out of power cells: the blaster won't fire")
	return false


## each container is searched once for cells, whatever else it holds
func _search(container: Node3D) -> void:
	if container == null:
		return
	var id := "%s/%s" % [Kotor.current_module, container.name]
	var searched: Array = save_data().get("searched", [])
	if searched.has(id):
		return
	searched.append(id)
	save_data()["searched"] = searched
	if randf() < float(setting(&"container_chance")):
		var n := randi_range(1, 2)
		give_item(CELL, n)
