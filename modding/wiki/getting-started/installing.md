# Installing mods

Drop the mod's `.zip`, or its folder, into the **`mods` folder next to the game**, then open **Mods** on the title
screen.

| Platform | Where |
|---|---|
| Windows, Linux | `mods` beside the game's executable |
| Mac | `mods` beside `KOTOR2.app` (not inside it) |
| Any (also searched) | `user://mods`, which on a Mac is `~/Library/Application Support/Godot/app_userdata/kotor2/mods` |
| Running the project in the Godot editor | `mods/` in the project folder |

If you're not sure where it is, **Open mods folder** on the Mods screen creates the folder and opens it.

## The Mods screen

On the left, every mod found, with its icon and a switch to turn it on or off. Pick one to see, on the right, its name,
author, version, description and pictures, and to:

- **Change its load order:** *Load earlier* and *Load later* move it. **Find best order** sorts every mod by what
  their `mod.json` files ask (`load_after`, `load_before`). A mod's hooks run in this order.
- **Change its settings:** these take effect immediately and are kept between games.

## Collections

A collection is a saved set of which mods are on, and their order: "Hardcore playthrough", "HD overhaul". Set up your
mods, press **Save as...** and give it a name. Pick a collection from the list at the top to switch to it (then
**Restart to apply**). Deleting a collection keeps the mods themselves.

Turning mods on or off and changing the order take effect when the game restarts. **Restart to apply** does that for
you.

Conflicts between mods appear at the bottom, such as two mods that say they can't run together, or two mods replacing
the same file.

## New-game choices

Some mods offer choices that are made once, when a game starts. For example, Hardcore asks whether to play Ironman.
They appear after **New Game**, on the Game Rules screen, and stay with that game's saves.

## Saves and mods

Every save records the mods (and versions) it was made with. Loading a save made with different mods tells you
what's changed. A mod's own saved state travels with the save, so turning a mod off and on again doesn't lose it.

## Mod settings in Options

**Options → Mod settings** opens the same settings, during play as well as from the title screen.
