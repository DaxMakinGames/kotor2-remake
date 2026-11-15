extends KotorMod
## Starter Mod: a template to copy. It does three small things, one of each kind a mod is made of:
##   a setting   - "Experience multiplier", on the Mods screen and in Options → Mod settings
##   a hook      - xp_award: changes how much experience is given (a modifier: take a value, return it)
##   events      - died and level_loaded: hear that something happened, and keep a count in the save
## To make it yours: copy this folder, rename the folder and "id" in mod.json to the same new name, then edit below.
## Turning the mod off and on in the Mods screen reloads this file, so you can edit and try again without a restart.


func _mod_ready() -> void:
	# 1. a setting: key, label, kind, default, lowest, highest, step
	add_option(&"xp_multiplier", "Experience multiplier", TYPE_FLOAT, 1.5, 0.5, 3.0, 0.25)

	# 2. a hook: the game asks "how much experience?" and every mod that hooked it can change the answer
	hook(&"xp_award", func(xp: int, _ctx: Dictionary) -> int:
		return roundi(xp * float(setting(&"xp_multiplier"))))

	# 3. events: something happened. save_data() is this mod's own part of the save game
	on(&"died", func(_who: Node3D, killer):
		if killer != null and killer == Kotor._player():
			save_data()["kills"] = int(save_data().get("kills", 0)) + 1)
	on(&"level_loaded", func(module: String):
		write_log("arrived in %s with %d kills" % [module, int(save_data().get("kills", 0))])
		Kotor.notice.emit("Starter Mod: %d kills so far" % int(save_data().get("kills", 0))))
