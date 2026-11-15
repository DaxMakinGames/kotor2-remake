# Item fields

For `add_item(resref, data)`. File names are inside your mod's folder.

| Field | Type | Meaning |
|---|---|---|
| `name` | String | Shown everywhere |
| `text` | String | The description |
| `base` | int | A row of the game's `baseitems.2da`: what kind of item it is and where it's worn |
| `cost` | int | Its worth in credits. Crafting and breaking down use it |
| `props` | Array | Item properties, `[label, subtype, value]`, using `itempropdef.2da` labels |
| `icon` | String | A picture file, 128 × 128 for inventory icons |
| `tag` | String | What scripts call it. Defaults to the resref |
| `charges` | int | Uses, for items that have them |
| `upgrade_level` | int | How upgradeable at a workbench (0 none, 1 some, 2 fully) |
| `dice` | Array | Extra damage dice for a weapon, `[[count, sides]]` |
| `worn` | Dictionary | For outfits: `{"body": letter, "texture_files": {"male": file, "female": file}}`. See [Outfits](../guides/outfits.md) |

## Common base items

| Row | Kind |
|---|---|
| 35 | Jedi Robe |
| 36 | Jedi Knight Robe |
| 37 | Jedi Master Robe |
| 53 | Adrenaline (stims) |
| 55 | Medical Equipment |

The full list: `Kotor.stats.rules()["base_items"]`.

## Common properties

| Label | Subtype | Value |
|---|---|---|
| `Armor` | 0 | Defense bonus |
| `AttackBonus` | 0 | Attack bonus |
| `Ability` | 0 STR, 1 DEX, 2 CON, 3 INT, 4 WIS, 5 CHA | Bonus |
| `Skill` | Skill index (0 to 7) | Bonus |
| `ImprovedSavingThrowsSpecific` | 1 Fortitude, 2 Reflex, 3 Will | Bonus |
