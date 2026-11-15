# Working with other mods

## Load order

Mods load in the order on the Mods screen. Each mod's hooks run in that order, each one getting the value the one
before returned. If your mod must come after another, say so in `mod.json`:

```json
"load_after": ["hardcore"]
```

The loader moves your mod after it, whatever order the player chose.

## Conflicts

If your mod can't work with another, list it:

```json
"conflicts": ["story_mode"]
```

The second one found isn't loaded, and the Mods screen says why. Use this sparingly: most mods can share hooks.

## Replaced files

List every game file your `.zip` replaces in `replaces`. When two mods replace the same file, the Mods screen says
which one wins (the later one).

## Good habits

- **Change the value you're given** in modifiers; don't overwrite it.
- **Start every resref with your mod's id:** items, and any keys you add.
- **Never write the story's globals.** Use `save_data()`.
- **Keep busy hooks cheap.**
- **Never bulk-load audio.** Load a sound when it's needed.
