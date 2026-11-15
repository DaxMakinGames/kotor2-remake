# Recipes

Short, complete mods for the jobs that come up most. Each one is a whole `main.gd`: put it in a folder with a
`mod.json` (copy the [Starter Mod](../getting-started/first-mod.md)'s) and it works as it is. Every recipe here is loaded
and run by the game's tests (`tools/modding_docs_test.gd`), so they're kept working as the game changes.

To try one, turn the mod off and on again on the **Mods** screen after each edit: it reloads with no restart.

## Change a number: enemies hit harder

Hooks that change a value take it, and return it changed or not. Here every blow against the party does half again as
much. ([damage_dealt](../reference/hooks/damage_dealt.md))

```gdscript
extends KotorMod

func _mod_ready() -> void:
	hook(&"damage_dealt", func(damage: int, ctx: Dictionary) -> int:
		var victim = ctx["victim"]
		var ours: bool = victim is Node and (victim.is_in_group(&"player") or Kotor.party.has(victim))
		return roundi(damage * 1.5) if ours else damage)
```

## Let the player choose: a slider

The same, with the amount on the Mods screen and in **Options → Mod settings**. A setting is kept between games.
([Settings and new-game choices](settings.md))

```gdscript
extends KotorMod

func _mod_ready() -> void:
	add_option(&"enemy_damage", "Enemy damage", TYPE_FLOAT, 1.5, 1.0, 3.0, 0.25)
	add_option(&"friendly_fire", "Friendly fire", TYPE_BOOL, false)
	hook(&"damage_dealt", func(damage: int, ctx: Dictionary) -> int:
		var victim = ctx["victim"]
		if victim is Node and (victim.is_in_group(&"player") or Kotor.party.has(victim)):
			return roundi(damage * float(setting(&"enemy_damage")))
		return damage)
```

## Say no: no blasters for the Exile

A `bool` hook answers a yes-or-no question. `can_attack` is asked before every attack: return `false` to hold it back,
or the value you're given to leave the decision to other mods. ([can_attack](../reference/hooks/can_attack.md))

```gdscript
extends KotorMod

func _mod_ready() -> void:
	hook(&"can_attack", func(ok: bool, ctx: Dictionary) -> bool:
		if ctx["attacker"] == Kotor._player() and KotorCombat.is_ranged(ctx["attacker"]):
			Kotor.notice.emit("A Jedi doesn't need a blaster")
			return false
		return ok)
```

## A choice for a new game

Asked once, after **New Game**, and kept with that game's saves. Ironman modes are made this way.

```gdscript
extends KotorMod

func _mod_ready() -> void:
	add_new_game_choice(&"start_rich", "Start with supplies", ["Off", "On"], 0, "Three medpacs and two stims.")
	on(&"game_started", func(new_game: bool):
		if new_game and choice(&"start_rich") == "On":
			give_item("g_i_medeqpmnt01", 3)
			give_item("g_i_adrnaline003", 2))
```

## Keep count in the save

`save_data()` is your mod's own part of the save: anything you put in it comes back when that game is loaded.
([Saving your mod's state](saving.md))

```gdscript
extends KotorMod

func _mod_ready() -> void:
	on(&"died", func(_who: Node3D, killer):
		if killer != null and killer == Kotor._player():
			save_data()["kills"] = int(save_data().get("kills", 0)) + 1)
	on(&"level_loaded", func(_module: String):
		Kotor.notice.emit("Kills so far: %d" % int(save_data().get("kills", 0))))
```

## Something on the screen

A mod is a node, so it can hold its own interface: add a `CanvasLayer` and put controls in it. This counter sits in
the top right corner.

```gdscript
extends KotorMod

var _label: Label

func _mod_ready() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	_label = Label.new()
	_label.position = Vector2(20, 60)
	_label.add_theme_font_size_override("font_size", 18)
	_label.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.8))
	_label.add_theme_constant_override("outline_size", 4)
	layer.add_child(_label)
	_show()
	on(&"died", func(_who: Node3D, _killer):
		save_data()["defeated"] = int(save_data().get("defeated", 0)) + 1
		_show())

func _show() -> void:
	_label.text = "Enemies defeated: %d" % int(save_data().get("defeated", 0))
```

## A new item

Items are added beside the game's own; a mod can't take the name of one that exists. Start the name with your mod's
id. ([Adding items](items.md), [Item fields](../reference/item-fields.md))

```gdscript
extends KotorMod

func _mod_ready() -> void:
	add_item("recipe_stim", {
		"name": "Miner's Stim",
		"text": "A crude stimulant made from mining chemicals.",
		"base": 53,
		"cost": 80,
		"props": [["Ability", 0, 2]],
	})
	on(&"game_started", func(new_game: bool):
		if new_game:
			give_item("recipe_stim", 1))
```

## Follow the story

The original game keeps its story in globals. Read them and listen for them changing; never set them, since the
story's own scripts depend on them.

```gdscript
extends KotorMod

func _mod_ready() -> void:
	on(&"global_changed", func(global_name: String, value):
		write_log("%s is now %s" % [global_name, str(value)]))
	on(&"conversation_started", func(conv: String, _owner):
		write_log("talking: " + conv))
```

## Change what an original script does

The game runs the original's own compiled scripts, and they call NWScript functions. A mod can wrap one: change its
arguments, its result, or replace it. ([Replacing script functions](script-functions.md))

```gdscript
extends KotorMod

func _mod_ready() -> void:
	# every bit of experience the story's scripts give is doubled
	script_function("GiveXPToCreature", func(args: Array, vm, original: Callable) -> Variant:
		args[1] = int(args[1]) * 2
		return original.call(args, vm))
```

## Replace art, sounds or a conversation

No script at all: name folders in `mod.json` and put files in them named like the game's own. A file replaces the
game's one of the same name while the mod is on. ([Texture overhauls](textures.md), and
[Bring a KOTOR mod over](porting.md) for files made for the original game)

```json
{ "id": "my_swaps", "name": "My swaps", "version": "1.0.0", "api": 1, "entry": "",
  "textures": "textures", "models": "models", "sounds": "sounds", "conversations": "conversations" }
```

```
my_swaps/
  mod.json
  textures/plc_footlker.png        replaces the footlocker's texture
  models/w_blstrpstl_001.glb       replaces a blaster pistol's model
  sounds/101101atton001.ogg        replaces one of Atton's lines
  conversations/101atton.dialogue  replaces a whole conversation
```
