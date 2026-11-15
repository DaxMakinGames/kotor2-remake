# KOTOR 2 Remake Modding Wiki

> [!WARNING]
> **An early demo: the first level only**
> Only Peragus and the Harbinger are rebuilt, and things are **expected to be broken**: missing features, bugs, rough
> edges. Not everything can be fixed, ported or implemented. The project is an **engine recreation** of KOTOR 2: the
> original game's levels, scripts and rules running as they did, without modernizing its systems more than needed.
> Mod support follows the same idea, and its API may change before 1.0. See [Current limitations](getting-started/limitations.md).

Mods for the KOTOR 2 remake can change how the game plays, not just how it looks. A mod can make fights harder or
easier, add game modes like Ironman, add new items and outfits, change the original game's scripts, and keep its own
saved state. All of that works without touching the game's files.

## Where to start

<div class="grid cards" markdown>

- **[Installing mods](getting-started/installing.md)**: where to put a mod, and the Mods screen.
- **[Your first mod](getting-started/first-mod.md)**: start from the Starter Mod, or write one in ten lines.
- **[Recipes](guides/recipes.md)**: short, complete mods for the common jobs, tested by the game.
- **[Bring a KOTOR mod over](guides/porting.md)**: what carries over from the original game's mods, and how.
- **[Packing and sharing](getting-started/packing.md)**: one `.zip` players drop in.
- **[Current limitations](getting-started/limitations.md)**: what mods can't do yet.
- **[Hooks explained](guides/hooks.md)**: how a mod changes the game.
- **[Hook reference](reference/hooks/index.md)**: every hook, with its arguments and an example.

</div>

## What a mod can do

| Kind of mod | How | Guide |
|---|---|---|
| Harder or easier play | Change damage, accuracy, healing, XP and Force costs as the game uses them | [Making a game mode](guides/game-modes.md) |
| A game mode (Ironman, survival) | New-game choices, events, your own saved state | [Settings and choices](guides/settings.md), [Saving](guides/saving.md) |
| New items, armor and outfits | Add items beside the game's own, with icons and textures | [Adding items](guides/items.md), [Outfits](guides/outfits.md) |
| Different story logic | Replace or wrap one of the original game's script functions | [Script functions](guides/script-functions.md) |
| Texture overhauls | A `textures` folder that replaces the game's textures by name | [Texture overhauls](guides/textures.md) |
| New models, sounds, conversations | Folders that replace the game's by name | [Recipes](guides/recipes.md), [Bring a KOTOR mod over](guides/porting.md) |
| Replacing data | Ship files at the game's paths, such as `res://data/tuning.tres` | [Packing](getting-started/packing.md) |

## The examples

- **[Hardcore](examples/hardcore.md)**: tougher fights and an Ironman mode. It uses most of the combat hooks.
- **[Prequel Robes](examples/prequel-robes.md)**: nine new robes added beside the game's own.
- **Starter Mod, Speedrun, Injuries, Power Cells, Pacifist Run and Lightsaber Duelist**: short mods on the public
  hooks, in the examples folder beside this wiki. Each starts switched off.

> [!NOTE]
> **The rule every mod follows**
> Mods **add** and **hook**; they never edit the game's files. That's what lets several mods run together and be
> switched off cleanly.
