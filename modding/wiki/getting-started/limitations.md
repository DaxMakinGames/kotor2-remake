# Current limitations

> [!WARNING]
> **Read this first**
> This is an early demo that covers **Peragus, the Harbinger and Telos's Citadel Station and surface**. Things are expected to be
> broken, and not everything can be fixed, ported or implemented. The project recreates the original engine: the
> game's own levels, scripts and rules, without modernizing its systems more than needed. Some of the limits below
> will go; some are there on purpose.

## What a mod can't do yet

| Limitation | What to do instead |
|---|---|
| **Only the demo's levels exist:** Peragus, the Harbinger and Telos. There are no other planets yet | Mods that hook rules and items will work in later levels too |
| **No new levels or areas.** A mod can't add a level or change a level's layout | Change what happens in a level with hooks and script functions |
| **Models can't be replaced**, by name or by path. Only textures can | New items wear the game's own bodies with their own textures ([Outfits](../guides/outfits.md)) |
| **Voices, music and sounds can't be replaced** | Play your own sounds from your mod's script |
| **The game's own conversations can't be edited** directly. A mod can add conversations of its own and give them to characters | [Conversations, quests and stores](../guides/conversations.md); for the game's, [wrap a script function](../guides/script-functions.md) or change the globals they check |
| **Hooks exist for 50 decisions and events**, stores, influence, alignment, forms and minigames among them | Ask for the hook you need: each one is a small change in the game |
| **A folder mod's `main.gd` is read as source:** no `class_name`, no `preload` of files beside it | `load(mod_path("..."))`, or pack the mod into a `.zip` |
| **Classic Override mods:** only their textures and models come over, not scripts, conversations or 2DA tables | [Classic KOTOR 2 mods](../guides/classic-mods.md) |
| **Turning mods on or off needs a restart** | Settings and new-game choices change at once |
| **Mac only for now.** A Windows build comes later | |

The API itself is **locked for 1.0** (version 1): hooks, their arguments and context keys, `KotorMod`'s methods and `mod.json`'s fields can be added to but never removed or changed. Every release is checked against the lock (`modding_wiki/api_lock.py`).

## Known rough edges in the game itself

The demo's own bugs affect mods too: a hook can only be as right as the system it hooks. If something your mod
changes behaves oddly, check whether it does the same with every mod off before blaming your mod.
