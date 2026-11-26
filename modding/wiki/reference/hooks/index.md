# Hooks

Every hook the game offers, 50 in all. **Modifiers** change a value before the game uses it: every mod that hooked one gets it in load order. **Events** tell every listening mod that something happened. See [Hooks explained](../../guides/hooks.md) for how to use them.

## Game flow

| Hook | Kind | What it's for |
|---|---|---|
| [game_started](game_started.md) | event | A game has begun: a new one, once character creation finishes, or a saved one, once it has finished loading. |
| [level_loaded](level_loaded.md) | event | A level has finished loading and the player is in it. |
| [level_leaving](level_leaving.md) | event | The player is about to leave a level for another one. |
| [heartbeat](heartbeat.md) | event | Every six-second round of play, the original game's own heartbeat. Not during conversations. |
| [paused](paused.md) | event | The pause menu has opened or closed. |
| [run_finished](run_finished.md) | event | The end of what's playable: the demo's end screen, as the story leaves for the Ebon Hawk. |
| [can_load](can_load.md) | modifier | Whether the player may load a save mid-game: the pause menu's Load button, and the game-over screen's Load Checkpoint. |

## Combat and survival

| Hook | Kind | What it's for |
|---|---|---|
| [attack_bonus](attack_bonus.md) | modifier | The attack bonus for one attack roll, the d20 roll plus this against the target's defense. |
| [defense](defense.md) | modifier | Someone's defense, what an attack roll must reach to hit them. |
| [damage_dealt](damage_dealt.md) | modifier | Damage about to be taken, after resistances. Every kind passes here: blows, shots, grenades, Force powers and scripts. |
| [can_attack](can_attack.md) | modifier | Whether an attack happens at all, asked before the roll. Return false to hold it back. |
| [attack_made](attack_made.md) | event | An attack roll has been made against a creature, and whether it hit. |
| [deflect_chance](deflect_chance.md) | modifier | The chance that a ranged hit is turned aside by its target. |
| [deflected](deflected.md) | event | A bolt was turned aside, with the damage it would have done. |
| [damaged](damaged.md) | event | Someone has taken damage. |
| [died](died.md) | event | A creature has died (not a party member going down). |
| [player_down](player_down.md) | event | The player has fallen. Unless a mod steps in, a companion can come and revive them. |
| [regen_rate](regen_rate.md) | modifier | How fast health comes back out of combat, in points per second. |
| [shield_rate](shield_rate.md) | modifier | How fast the player's shield recharges, in points per second. |
| [heal_amount](heal_amount.md) | modifier | How much a medpac or repair kit heals. |
| [enemy_think](enemy_think.md) | modifier | Seconds between the enemies' decisions: who to fight, where to move, when to throw. |
| [npc_scene](npc_scene.md) | modifier | The scene a creature in a level is made from: a mining droid, a droid, a person, or a mod's own kind. |
| [npc_spawned](npc_spawned.md) | event | A creature has been placed in a level and its model built: anyone but the player and companions. |

## Character and progress

| Hook | Kind | What it's for |
|---|---|---|
| [xp_award](xp_award.md) | modifier | Experience about to be given, for a kill or by the story. |
| [skill](skill.md) | modifier | A character's total in a skill, used everywhere the game checks one: locks, computers, crafting, conversation. |
| [force_cost](force_cost.md) | modifier | What a Force power costs to use. |
| [level_up](level_up.md) | event | Someone has taken a level. |
| [item_added](item_added.md) | event | Items have gone into the party's inventory. |
| [item_removed](item_removed.md) | event | Items have left the party's inventory: used, sold, broken down or taken by a script. |
| [can_equip](can_equip.md) | modifier | Whether someone may put an item on. |
| [crafting_cost](crafting_cost.md) | modifier | The components or chemicals an item takes to make at a workbench or lab station. |

## Story and world

| Hook | Kind | What it's for |
|---|---|---|
| [conversation_started](conversation_started.md) | event | A conversation has begun. |
| [conversation_ended](conversation_ended.md) | event | A conversation has ended, after its last scripts ran. |
| [global_changed](global_changed.md) | event | One of the story's global numbers or booleans has changed. This is how the original scripts record progress. |
| [door_opened](door_opened.md) | event | A door has opened, by anyone or any script. |
| [container_opened](container_opened.md) | event | The player has opened a container: a footlocker, a corpse, a crate. |
| [script_run](script_run.md) | event | One of the original game's scripts is about to run. |
| [journal_updated](journal_updated.md) | event | A quest's entry in the journal changed (a script's AddJournalQuestEntry moved it to another state). |

## Companions and alignment

| Hook | Kind | What it's for |
|---|---|---|
| [influence_change](influence_change.md) | modifier | How much a companion's influence moves when a conversation or script changes it (ModifyInfluence). |
| [influence_changed](influence_changed.md) | event | A companion's influence moved, after it was kept within 0 to 100. The game also says "Influence gained" or "lost" on screen. |
| [alignment_change](alignment_change.md) | modifier | How far an alignment shifts: the player's, or a companion's (their own, or following the player's when influence pulls them). |
| [alignment_changed](alignment_changed.md) | event | An alignment shifted. |
| [dark_stage](dark_stage.md) | modifier | How deep the dark side's marks show on the player's face: 0 for none, 1 to 4 for the four textures heads.2da gives each head (evil, very evil and so on). |

## Stores and minigames

| Hook | Kind | What it's for |
|---|---|---|
| [store_price](store_price.md) | modifier | What an item costs to buy at a store, or what the store pays for it. |
| [store_bought](store_bought.md) | event | The player bought an item. |
| [store_sold](store_sold.md) | event | The player sold an item. |
| [minigame_started](minigame_started.md) | event | A minigame has begun: "turret" (the Ebon Hawk's gun on Peragus), "swoop" (the races on Telos and Nar Shaddaa) or "pazaak" (once the side deck is picked and the first card is dealt). |
| [minigame_finished](minigame_finished.md) | event | A minigame has ended. |

## Lightsabers and forms

| Hook | Kind | What it's for |
|---|---|---|
| [form_bonus](form_bonus.md) | modifier | One of a form's numbers, as it applies right now: a lightsaber form (Shii-Cho to Juyo) or a Force form (Force Channel to Force Mastery). |
| [form_changed](form_changed.md) | event | Someone took up a form, or let one go. |
