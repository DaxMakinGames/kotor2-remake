# The Kotor object

`Kotor` is the game: an autoload every script can reach. Mods may use its **public** parts, the names without a
leading underscore. Underscored names are internal and change without notice.

## Commonly used

| Name | What it is |
|---|---|
| `Kotor._player()` | The player's node. The one underscored name mods may use, since there's no public alternative yet |
| `Kotor.party` | The companions with you (an Array of nodes) |
| `Kotor.notice.emit(text)` | A short message on screen |
| `Kotor.add_item(resref, name, count, tag, text, kind)` / `remove_item(resref, count)` | Inventory. `give_item` on KotorMod fills the fields in for you |
| `Kotor.inventory` | resref → `{name, count, ...}` |
| `Kotor.get_global(name)`, `get_global_bool(name)` | The story's state: read, don't write |
| `Kotor.give_xp(amount)` | Experience, through the `xp_award` hook |
| `Kotor.all_is_lost()` | Game over |
| `Kotor.player_hp`, `player_max_hp`, `player_force` | The player's numbers |
| `Kotor.in_dialogue`, `Kotor.ui_open` | Whether a conversation or a menu is up |
| `Kotor.equipped_weapon`, `equipped_armor` | What the player has on |

## Its parts

| Part | Use it for |
|---|---|
| `Kotor.stats` | Character sheets: `skill(key, i)`, `attack_bonus(key)`, `level_of(key)`, `item_rules(resref)`, `rules()` |
| `Kotor.force` | Force powers: `cost_of(id)`, `power(id)` |
| `Kotor.crafting` | Workbench and lab station |
| `Kotor.checkpoint` | Saving: `save_now()` |
| `Kotor.mods` | Mod support itself: `get_mod(id)`, `entry(id)`, `mod_list()` |

Character keys: `"player"`, or a companion's template, such as `"p_atton"` or `"p_kreia"`.
