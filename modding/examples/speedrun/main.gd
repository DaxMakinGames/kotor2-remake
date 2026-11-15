extends KotorMod
## Speedrun: in-game time, the way speedrunners time it. Loading screens and the pause menu don't count (the mod's node
## stops with the game when it's paused); conversations and cutscenes do. Every level reached is a split, compared with
## the best run so far, which is kept in user://speedrun_best.json across games.

var BEST_FILE := KotorBuild.user_root() + "speedrun_best.json"     # a test's runs never touch the player's best
const MOST_A_FRAME := 0.1            # a hitch counts, a gap (the window hidden, the game stopped) doesn't

var _loading := false
var _running := false
var _last_us := 0
var _hud: Label
var _split_line: Label
var _best := {}


func _mod_ready() -> void:
	add_option(&"show_splits", "Show the last split under the timer", TYPE_BOOL, true)
	add_option(&"tenths", "Show tenths of a second", TYPE_BOOL, true)
	_best = _read_best()
	_make_hud()
	on(&"game_started", func(new_game: bool):
		if new_game or not save_data().has("elapsed"):
			save_data()["elapsed"] = 0.0
			save_data()["splits"] = {}
			save_data()["finished"] = false
		_running = not bool(save_data().get("finished", false))
		_last_us = Time.get_ticks_usec())
	on(&"level_leaving", func(_from: String, _to: String): _loading = true)
	on(&"level_loaded", _arrived)
	on(&"run_finished", _finish)


func _process(_delta: float) -> void:
	var now := Time.get_ticks_usec()
	var step := minf((now - _last_us) / 1000000.0, MOST_A_FRAME)
	_last_us = now
	if _running and not _loading and Kotor.current_module != "":
		save_data()["elapsed"] = float(save_data().get("elapsed", 0.0)) + step
	if _hud != null:
		_hud.visible = _running or bool(save_data().get("finished", false))
		_hud.text = clock(float(save_data().get("elapsed", 0.0)))


func _arrived(module: String) -> void:
	_loading = false
	_last_us = Time.get_ticks_usec()
	if not _running:
		return
	var splits: Dictionary = save_data().get("splits", {})
	if splits.has(module):
		return                                   # a level visited again isn't a new split
	var at := float(save_data().get("elapsed", 0.0))
	splits[module] = at
	save_data()["splits"] = splits
	_show_split(module.to_upper(), at, _best.get("splits", {}).get(module, -1.0))


func _finish() -> void:
	if not _running:
		return
	_running = false
	save_data()["finished"] = true
	var total := float(save_data().get("elapsed", 0.0))
	var old := float(_best.get("total", -1.0))
	_show_split("FINISH", total, old)
	if old < 0.0 or total < old:
		_best = {"total": total, "splits": save_data().get("splits", {}).duplicate()}
		var f := FileAccess.open(BEST_FILE, FileAccess.WRITE)
		if f:
			f.store_string(JSON.stringify(_best))
		Kotor.notice.emit("New personal best: %s" % clock(total))
	else:
		Kotor.notice.emit("Run over: %s (best %s)" % [clock(total), clock(old)])
	write_log("run finished in %s" % clock(total))


func _show_split(label: String, at: float, best: float) -> void:
	if _split_line == null or not bool(setting(&"show_splits")):
		return
	var text := "%s  %s" % [label, clock(at)]
	var color := Color(1, 1, 1, 0.8)
	if best >= 0.0:
		var diff := at - best
		text += "  (%s%s)" % ["+" if diff >= 0.0 else "-", clock(absf(diff))]
		color = Color(1.0, 0.55, 0.5) if diff > 0.0 else Color(0.55, 0.9, 0.6)
	_split_line.text = text
	_split_line.modulate = color


## 1:02:03.4, 12:03.4 or 3.4
func clock(seconds: float) -> String:
	var whole := int(seconds)
	var h := whole / 3600
	var m := (whole / 60) % 60
	var s := whole % 60
	var tail := (".%d" % (int(seconds * 10.0) % 10)) if bool(setting(&"tenths")) else ""
	if h > 0:
		return "%d:%02d:%02d%s" % [h, m, s, tail]
	return "%d:%02d%s" % [m, s, tail]


func _read_best() -> Dictionary:
	if not FileAccess.file_exists(BEST_FILE):
		return {}
	var d: Variant = JSON.parse_string(FileAccess.get_file_as_string(BEST_FILE))
	return d if d is Dictionary else {}


func _make_hud() -> void:
	var layer := CanvasLayer.new()
	layer.layer = 50
	add_child(layer)
	var box := VBoxContainer.new()
	box.anchor_left = 1.0
	box.anchor_right = 1.0
	box.offset_left = -260
	box.offset_top = 14
	box.offset_right = -18
	box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	layer.add_child(box)
	_hud = Label.new()
	_hud.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	_hud.add_theme_font_size_override("font_size", 26)
	_hud.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.8))
	_hud.add_theme_constant_override("outline_size", 6)
	box.add_child(_hud)
	_split_line = Label.new()
	_split_line.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	_split_line.add_theme_font_size_override("font_size", 15)
	_split_line.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.8))
	_split_line.add_theme_constant_override("outline_size", 4)
	box.add_child(_split_line)
	_hud.visible = false
