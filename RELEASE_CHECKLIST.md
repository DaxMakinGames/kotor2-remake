# Roadmap and release checklist

What's done, what's next, and what a 1.0 needs. Ticked boxes are done and tested.

> **Where it stands:** an early **demo** covering the first level only: Peragus and the Harbinger, start to finish.
> Expect bugs. The goal is an **engine recreation** of KOTOR 2: the original game's levels, scripts and rules running
> as they did, with only light modernization (better graphics settings, HD textures as optional mods, a modern
> installer). Not everything can be fixed, ported or added, especially by one person.

**Contents:** [The demo](#the-demo-peragus-and-the-harbinger) ·
[Planets](#planets) · [Game systems](#game-systems) · [Installer](#installer) · [Modding](#modding) ·
[Modernization](#modernization) · [Platforms](#platforms) · [Stability](#stability) · [Releasing](#releasing) ·
[Legal](#legal-rules-every-release-follows)

---

## The demo: Peragus and the Harbinger

**Playable now**
- [x] The whole route, start to end screen: medbay → T3-M4 → mining tunnels → fuel depot → airlock → dormitories →
      Kreia → the Harbinger → hangar → escape
- [x] Combat, Force powers, companions (switch with V), party orders
- [x] Character creation, male and female
- [x] Workbench, lab station and item upgrades
- [x] Saving and loading: dead enemies stay dead, open doors stay open
- [x] Kreia's wake-up scene
- [x] Options: graphics, sound, controls and rebinding, subtitles, HUD scale, colors

**Still to check by hand**
- [ ] T3-M4: walking, running, shooting, the lower camera
- [ ] Atton: no gliding, voice in time with the text, blinking
- [ ] Floors and lighting in every room
- [ ] Combat balance: enemy numbers and XP
- [ ] Voices on the later Peragus levels
- [ ] Crafting prices
- [ ] A full playthrough by someone other than me, with notes

**Before the demo is "finished"**
- [ ] The end screen says what's next and links bug reports
- [ ] A known-issues list
- [ ] Gamepad: every menu reachable without a mouse

## Planets

Each planet goes through the same steps: **build** (the pipeline converts it), **walk** (an automated bot plays
through it), **check** (played by hand).

| Planet | Build | Walk | Check |
|---|---|---|---|
| Peragus (mining facility) | ✅ | ✅ | in progress |
| The Harbinger | ✅ | ✅ | in progress |
| Telos: Citadel Station | ⬜ | ⬜ | ⬜ |
| Telos: the surface and the academy | ⬜ | ⬜ | ⬜ |
| The Ebon Hawk (the hub) and the galaxy map | ⬜ | ⬜ | ⬜ |
| Nar Shaddaa | ⬜ | ⬜ | ⬜ |
| Dxun | ⬜ | ⬜ | ⬜ |
| Onderon | ⬜ | ⬜ | ⬜ |
| Dantooine | ⬜ | ⬜ | ⬜ |
| Korriban | ⬜ | ⬜ | ⬜ |
| The Ravager | ⬜ | ⬜ | ⬜ |
| Malachor V, the endings and credits | ⬜ | ⬜ | ⬜ |

## Game systems

Peragus doesn't use these, so they come with the planets that do.

- [ ] Stores: buying and selling
- [ ] Influence and companion conversations
- [ ] Training companions as Jedi
- [ ] The full party: every companion, and swapping members
- [ ] Lightsabers: building them, crystals, saber forms
- [ ] Prestige classes
- [ ] Light and dark side: its effects on powers and appearance
- [ ] Minigames: Pazaak, swoop racing, turrets
- [ ] The journal across planets
- [ ] Enemy talents (some special moves the original AI script used)
- [ ] Every original script function the game calls (the log lists any still missing)

## Installer

The Mac installer (`KOTOR2-Remake-Setup.dmg`) builds the game from your own copy of KOTOR 2, so nothing from the
original game is in the download.

- [x] Finds KOTOR 2 (Steam or GOG) and your downloaded mods
- [x] Brings its own Python and Godot; downloads Blender only if you don't have it
- [x] Shows progress and time left; Cancel and Try again carry on where it stopped
- [x] HD texture packs become mods you can switch off
- [x] Accepts either TSLRCM build (PC or Switch)
- [x] Checks free disk space before starting
- [x] Tested from nothing for one level
- [ ] Tested from nothing for the whole demo, by pressing Install in the window
- [ ] Tested on a second Mac
- [ ] Windows installer
- [ ] Linux and Steam Deck
- [ ] Checks the built game before its first launch

## Modding

**Done**
- [x] Drop-in mods: a `.zip` or folder in the `mods` folder beside the game
- [x] Mods screen: on and off, load order, settings, conflicts
- [x] 30 hooks into the game's rules (damage, healing, XP, Force costs, and more)
- [x] New-game choices (like Ironman) and each mod's own saved data
- [x] New items and outfits beside the game's own
- [x] Texture overhauls that replace the game's textures by name
- [x] Tools to pack mods (`tools/pack_mod.sh`, `tools/pack_art_mod.py`)
- [x] Example mods: Hardcore, Prequel Robes
- [x] The modding guide and wiki

**Next update**
- [x] **Collections:** save the mods you have on as a named set ("Hardcore playthrough", "HD overhaul") and switch
      between sets
- [x] **Pictures:** a square icon for each mod, and a gallery of screenshots on its page
- [x] **A cleaner Mods screen:** the list on the left with an on/off switch per mod; on the right the mod's name,
      author, version, description and pictures
- [x] **Find best order:** sort the load order from what each mod's `mod.json` says (`load_after`, `load_before`)

**Later**
- [ ] Publish the wiki online
- [ ] Hooks for stores, influence, alignment and minigames, as those systems arrive
- [ ] Replacing models, sounds and conversations
- [ ] Freeze the modding API (version 1) for 1.0: hooks may be added, never renamed or removed

## Modernization

Kept light on purpose: the original's look and rules come first.

- [x] Modern graphics settings, resolution and frame rate options
- [x] HD textures as optional mods (Vanilla Planets HD, Vanilla Characters HD)
- [x] Modern menus in the original's spirit
- [x] Rebindable controls and accessibility options
- [ ] Full gamepad support
- [ ] Better lighting where the original's bakes are broken
- [ ] Widescreen and high-resolution menus checked at every size

## Platforms

- [x] Mac (Apple Silicon)
- [ ] Mac signing, so it opens without right-click → Open (needs Apple's $99/year developer program)
- [ ] Windows (it will warn that the app is unsigned)
- [ ] Linux and Steam Deck
- [ ] Minimum and recommended specs, measured
- [ ] Load times and frame rates measured in the heaviest scenes

## Stability

- [x] Saves record their mods, and loading says when they differ
- [ ] A crash log with the build number, and where to find it after a crash
- [ ] A rare crash on level change (seen once going from the mining tunnels to the fuel depot)
- [ ] Saves from the demo load in later builds, or say clearly that they can't
- [ ] Every automated test passing on the release build

## Releasing

- [x] Pre-releases on GitHub with the Mac installer
- [x] A readme: what it is, what you need, how to install
- [ ] A known-issues list
- [ ] Bug reports: an issue template (build, Mac model, save file, log)
- [ ] A changelog
- [ ] The version number on the title screen
- [ ] A credits screen in the game
- [ ] Screenshots and a short video

## Legal: rules every release follows

This is a fan project built on Lucasfilm's game. These rules keep it on the safe side. (Not legal advice.)

- [x] **No original game files** in any download or in this repository. The installer builds them from your own copy.
- [x] **Community mods come from your own downloads**, with links and credits ([COMMUNITY_MODS.md](COMMUNITY_MODS.md)).
- [x] **Free, always.** No price, no paid builds, no donations tied to the game.
- [x] **Clearly unofficial:** not affiliated with or endorsed by Lucasfilm, Disney, Obsidian, Aspyr or EA.
- [ ] A licence for this project's own code
- [ ] An unofficial name and logo (no official logos or box art)
