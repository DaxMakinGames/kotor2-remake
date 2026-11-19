# Current limitations

> [!WARNING]
> **Read this first**
> This is an early demo that covers **only the first level**: Peragus and the Harbinger. Things are expected to be
> broken, and not everything can be fixed, ported or implemented. The project recreates the original engine: the
> game's own levels, scripts and rules, without modernizing its systems more than needed. Some of the limits below
> will go; some are there on purpose.

## What a mod can't do yet

| Limitation | What to do instead |
|---|---|
| **Only the demo exists:** Peragus (101–107) and the Harbinger (151–153). There are no other planets | Mods that hook rules and items will work in later levels too |
| **No new levels or areas.** A mod can't add a level or change a level's layout | Change what happens in a level with hooks and script functions |
| **Models can't be replaced**, by name or by path. Only textures can | New items wear the game's own bodies with their own textures ([Outfits](../guides/outfits.md)) |
| **Voices, music and sounds can't be replaced** | Play your own sounds from your mod's script |
| **Conversations can't be added or edited** directly | [Wrap a script function](../guides/script-functions.md), or change the globals a conversation checks |
| **Hooks exist for 50 decisions and events**, stores, influence, alignment, forms and minigames among them | Ask for the hook you need: each one is a small change in the game |
| **A folder mod's `main.gd` is read as source:** no `class_name`, no `preload` of files beside it | `load(mod_path("..."))`, or pack the mod into a `.zip` |
| **Turning mods on or off needs a restart** | Settings and new-game choices change at once |
| **Mac only for now.** A Windows build comes later | |
| **Pazaak and swoop racing aren't in yet**, so `minigame_started` only says `"turret"` | Listen for any kind: the others will use the same events |

The API itself is **locked for 1.0** (version 1): hooks, their arguments and context keys, `KotorMod`'s methods and `mod.json`'s fields can be added to but never removed or changed. Every release is checked against the lock (`modding_wiki/api_lock.py`).

## Known rough edges in the game itself

The demo's own bugs affect mods too: a hook can only be as right as the system it hooks. If something your mod
changes behaves oddly, check whether it does the same with every mod off before blaming your mod.
