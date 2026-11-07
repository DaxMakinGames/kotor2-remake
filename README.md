# KOTOR 2 Remake (fan project)

A fan remake of *Star Wars: Knights of the Old Republic II – The Sith Lords* in a modern engine. It runs the original
game's own levels, conversations and scripts, built on your computer from **your own copy** of the game.

> **Early demo: the first level only.** Peragus and the Harbinger, start to finish. Things are expected to be broken.
> It's an engine recreation: the original game as it was, with only light modernization. See the
> [roadmap](RELEASE_CHECKLIST.md) for what's done and what's next.

> **Unofficial and free.** Not affiliated with or endorsed by Lucasfilm, Disney, Obsidian, Aspyr or EA. This download
> contains **no files from the original game**: you need your own copy of KOTOR 2 (Steam or GOG).

## Download

Get **KOTOR2-Remake-Setup.dmg** from [Releases](../../releases) (Mac, Apple Silicon, macOS 14 or later). Windows comes
later.

## Install

1. **Have KOTOR 2** installed from Steam or GOG.
2. **Download TSLRCM** (free, required): [TSLRCM 1.8.6 on GameBanana](https://gamebanana.com/mods/617353). Unzip it
   in your Downloads folder.
3. **Optional, for sharper textures:** [Vanilla Planets HD](https://deadlystream.com/files/file/2976-vanilla-planets-hd/)
   and [Vanilla Characters HD](https://deadlystream.com/files/file/2987-vanilla-characters-hd-optimized/). Unzip them
   in Downloads too. They become mods you can switch off at any time.
4. **Open the dmg and run KOTOR 2 Remake Setup.** The first time, right-click it and choose **Open**, since it isn't
   signed by Apple. Setup checks everything and shows one **Install** button. If something's missing, it says what
   and updates by itself once you've downloaded it.
5. **Wait.** The first build takes an hour or more: Setup converts the game's levels from your copy. Then press
   **Play**.

Why these mods, and what each one does: [COMMUNITY_MODS.md](COMMUNITY_MODS.md).

## Testing and bug reports

This is a test build: thank you for trying it. Please report problems in [Issues](../../issues) with:
- what happened, and what you expected
- where in the game (which room)
- your Mac model and macOS version
- the game's log, if it crashed: `~/Library/Application Support/Godot/app_userdata/kotor2/logs`

## Mods

The remake has its own mod support: drop a mod's `.zip` into the `mods` folder beside the game and switch it on in
**Mods** on the title screen. Mods can change how the game plays (hard modes, Ironman, new items), not just how it
looks. Making mods: [MODDING.md](MODDING.md), with an example mod and the packing tools in [modding/](modding).

## Credits

- **The original game:** BioWare and Obsidian Entertainment. Star Wars is Lucasfilm's.
- **TSLRCM** by Zbyl2, DarthStoney, Hassat Hunter & VarsityPuppet (Switch port on
  [GameBanana](https://gamebanana.com/mods/617353)).
- **Optional mods, ported as examples:** Vanilla Planets HD and Vanilla Characters HD by Saul0097, Relighting TSL by J.
  Used without their authors' direct permission; nothing of theirs is included. Authors who'd like theirs left out
  can open an issue. Details: [COMMUNITY_MODS.md](COMMUNITY_MODS.md).
- **Tools:** [Godot Engine](https://godotengine.org) (MIT), [Dialogue Manager](https://github.com/nathanhoad/godot_dialogue_manager)
  (MIT), [KotorBlender](https://github.com/OpenKotOR/kotorblender) (GPL-3.0), [PyKotor](https://github.com/NickHugi/PyKotor)
  (LGPL), [Blender](https://www.blender.org) (GPL).
