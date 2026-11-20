# Adding items

Mods add items **beside** the game's own. A mod can't take the name of an item the game already has, so nothing is
ever replaced.

```gdscript
func _mod_ready() -> void:
	add_item("mymod_stim", {
		"name": "Battle Stim",
		"text": "A crude stimulant brewed from mining chemicals.",
		"base": 53,               # a row of baseitems.2da: what kind of item it is (53 is Adrenaline, a stim)
		"cost": 120,
		"icon": "icons/battle_stim.png",
		"props": [["Ability", 0, 2]],
	})
	on(&"game_started", func(new_game: bool):
		if new_game: give_item("mymod_stim", 2))
```

- **The resref** (`mymod_stim`) is the item's name in code and saves. Start it with your mod's id so it can't clash
  with another mod's.
- **`base`** decides what the item is and where it can be equipped, from the game's `baseitems.2da` rows (35 Jedi
  Robe, 53 Adrenaline stims, 55 Medical Equipment, and so on). `Kotor.stats.rules()["base_items"]` lists them.
- **`props`** are the game's item properties, `[label, subtype, value]`, using `itempropdef.2da`'s labels. The
  character sheet and combat read them the same way as the game's own items: `Armor`, `AttackBonus`, `Ability`,
  `Skill`, `ImprovedSavingThrowsSpecific` and more.
- **`icon`** is a picture in your mod's folder, 128 × 128 for inventory icons.

Every field is on [Item fields](../reference/item-fields.md).

## Giving items

`give_item(resref, count)` puts an item in the party's inventory with its name and description. Hand out each item
once per game: remember what you've given in [save_data()](saving.md).

## If the mod is removed

Items a mod added stay in saves by their resref. With the mod off, they have no name or picture. Tell players to take
off a mod's armor before turning the mod off.
