# Classic KOTOR 2 mods

Years of KOTOR 2 mods were made for the original's Override folder. Some of them come over as they are.

1. Make a folder called **KOTOR2 Classic Mods** in your Downloads folder.
2. Put each classic mod's folder in it, unpacked, as you downloaded it.
3. Run Setup: its build lays what the remake can use over the game it builds from.

**What comes over:** textures (`.tga`, `.tpc`, `.dds`, with their `.txi`) and models (`.mdl`, `.mdx`), by name, as
the original would use them. A texture or model mod usually just works.

**What doesn't:** scripts, conversations, templates and tables (`.ncs`, `.dlg`, `.utc`, `.uti`, `.2da` and the like),
and TSLPatcher installers (`tslpatchdata`). The remake runs the game's own story, with TSLRCM's fixes, and a mod's
version of one of those was never tested with it. Most of what such a mod does can be rebuilt as a mod of this game:
hooks for rules, `add_item` for items, a conversation of the mod's own for dialogue (see Conversations, quests and
stores), and Bring a KOTOR mod over for the rest.

What was used from each, and what wasn't, is in the build's `classic_mods.json`.
