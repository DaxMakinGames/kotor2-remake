<div align="center">

# KOTOR 2 Remake (fan project)

A fan remake of *Star Wars: Knights of the Old Republic II – The Sith Lords* in a modern engine.<br>
It runs the original game's own levels, conversations and scripts, built on your computer from **your own copy** of the game.

<img width="100%" alt="KOTOR 2 Remake" src="https://github.com/user-attachments/assets/a8e9cbd1-f9b6-405e-a0d7-b4107dbfbdad" />

</div>

> [!WARNING]
> **Early demo: the first level only.** Peragus and the Harbinger, start to finish. Things are expected to be broken.
> It's an engine recreation: the original game as it was, with only light modernization. See the
> [roadmap](RELEASE_CHECKLIST.md) for what's done and what's next.

> [!NOTE]
> **Unofficial and free.** Not affiliated with or endorsed by Lucasfilm, Disney, Obsidian, Aspyr or EA. This download
> contains **no files from the original game**: you need your own copy of KOTOR 2 (Steam or GOG).

---

## Download

Get **KOTOR2-Remake-Setup.dmg** from [Releases](../../releases) (Mac, Apple Silicon, macOS 14 or later). Windows comes
later.

## Install

1. **Have KOTOR 2** installed from Steam or GOG.
2. **Download TSLRCM** (free, required): [TSLRCM 1.8.6 on GameBanana](https://gamebanana.com/mods/617353). Leave it in
   your Downloads folder: Setup unpacks it by itself (the `.7z` too), so there's nothing to unzip.
3. **Open the dmg and run KOTOR 2 Remake Setup.** It isn't signed by Apple, so the first time macOS says it can't
   check it: click **Done**, open **System Settings → Privacy & Security**, scroll down and click **Open Anyway** next
   to KOTOR 2 Remake Setup, then confirm. Setup walks you through a few short pages (your game, mods, then
   **Install**). If something's missing, it says what and updates by itself once you've downloaded it.
4. **Wait.** The first build takes an hour or more: Setup converts the game's levels from your copy. Then press
   **Play**.

**Updating:** download the new Setup and run it. If your game data is still current, it says **Update** and only
replaces the game, in about a minute; your game data, mods, saves and settings stay as they are.

Why these mods, and what each one does: [COMMUNITY_MODS.md](COMMUNITY_MODS.md).

<table>
  <tr>
    <td width="50%"><img width="100%" alt="image" src="https://github.com/user-attachments/assets/526a6708-7255-41e1-97d8-43715a2c14bc" /></td>
    <td width="50%"><img width="100%" alt="image" src="https://github.com/user-attachments/assets/c5de1805-398f-4925-8256-a45906224cf8" /></td>
  </tr>
  <tr>
    <td width="50%"><img width="100%" alt="image" src="https://github.com/user-attachments/assets/25f2b1c3-5a4b-42fc-a619-1a8767d6cc9e" /></td>
    <td width="50%"><img width="100%" alt="image" src="https://github.com/user-attachments/assets/c954e3b6-792a-4b85-966c-afb47ecb56c4" /></td>
  </tr>
  <tr>
    <td width="50%"><img width="100%" alt="image" src="https://github.com/user-attachments/assets/52cd041b-c47b-4db2-a937-5b24f0264785" /></td>
    <td width="50%"><img width="100%" alt="image" src="https://github.com/user-attachments/assets/8020374c-4b16-46b8-9152-183ad9f682d1" /></td>
  </tr>
</table>

---

## Testing and bug reports

This is a test build: thank you for trying it. Before reporting, check the [known issues](KNOWN_ISSUES.md). Want to
help more? The [testing guide](TESTING.md) lists the parts that most need someone to play them.

The easiest way to report a problem is **Report a Bug**, on the title screen or the pause menu (Esc). Say what
happened and press **Open report on GitHub**: the build, the level and your computer are filled in for you, and
**Show files to attach** gathers the log and a screenshot. If the game crashes, the title screen offers to report it
next time you start it.

You can also open an [issue](../../issues/new/choose) by hand. The build number is at the bottom right of the title
screen.

## Mods

The remake has its own mod support: drop a mod's `.zip` into the `mods` folder beside the game and switch it on in
**Mods** on the title screen. Mods can change how the game plays (hard modes, Ironman, new items), not just how it
looks. Making mods: [MODDING.md](MODDING.md), with an example mod and the packing tools in [modding/](modding).

---

## Credits

| What | Who |
|---|---|
| **The original game** | BioWare and Obsidian Entertainment. Star Wars is Lucasfilm's. |
| **TSLRCM** | by Zbyl2, DarthStoney, Hassat Hunter & VarsityPuppet (Switch port on [GameBanana](https://gamebanana.com/mods/617353)). |
| **Optional mods, ported as examples** | Vanilla Planets HD and Vanilla Characters HD by Saul0097, Relighting TSL by J. Used without their authors' direct permission; nothing of theirs is included. Authors who'd like theirs left out can open an issue. Details: [COMMUNITY_MODS.md](COMMUNITY_MODS.md). |
| **Tools** | [Godot Engine](https://godotengine.org) (MIT), [Dialogue Manager](https://github.com/nathanhoad/godot_dialogue_manager) (MIT), [KotorBlender](https://github.com/OpenKotOR/kotorblender) (GPL-3.0), [PyKotor](https://github.com/NickHugi/PyKotor) (LGPL), [Blender](https://www.blender.org) (GPL). |
