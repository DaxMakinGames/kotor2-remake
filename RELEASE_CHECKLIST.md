# Roadmap

Here's what's done, what I'm working on, and what's left before a 1.0. Checked boxes are done and tested.

> **Where things are right now:** it's an early demo, first level only: Peragus and the Harbinger, start to finish.
> There will be bugs. What I'm going for is an engine recreation of KOTOR 2, meaning the original levels, scripts and
> rules running the way they did, with a few modern touches (graphics settings, optional HD textures, an installer
> that does the work for you). I'm one person, so I won't be able to fix, port or add everything.

> **It's free to use, and it always will be.** Download it, play it, mod it, share it. You just need your own copy of
> KOTOR 2. Nobody's charging for anything here.

**Jump to:** [The demo](#the-demo-peragus-and-the-harbinger) · [Planets](#planets) · [Game systems](#game-systems) ·
[Installer](#installer) · [Modding](#modding) · [Modernization](#modernization) · [Platforms](#platforms) ·
[Stability](#stability) · [Releasing](#releasing) · [Legal](#legal)

---

## The demo: Peragus and the Harbinger

**Playable now**
- [x] The whole route: medbay, T3-M4, the mining tunnels, the fuel depot, the airlock, the dormitories, Kreia, the
      Harbinger, the hangar and the escape
- [x] Combat, Force powers, companions (switch with V), party orders
- [x] Character creation, male and female
- [x] Workbench, lab station and item upgrades
- [x] Saving and loading (dead enemies stay dead, open doors stay open)
- [x] Kreia's wake-up scene
- [x] Options for graphics, sound, controls and rebinding, subtitles, HUD scale and colors

**Still need to check by hand**
- [ ] T3-M4's walking, running, shooting and the lower camera
- [ ] Atton not gliding, his voice lining up with the text, blinking
- [ ] Floors and lighting in every room
- [ ] Combat balance (enemy numbers and XP)
- [ ] Voices on the later Peragus levels
- [ ] Crafting prices

**Before I call the demo finished**
- [ ] Gamepad support in every menu
- [ ] Bug free for first level (meaning should translate for other levels)

## Planets

Every planet goes through the same three steps. First I **build** it (the pipeline converts it from your copy). Then
a bot **walks** it (an automated playthrough). Then I **check** it by playing it myself.

| Planet | Build | Walk | Check |
|---|---|---|---|
| Peragus (mining facility) | ✅ | ✅ | in progress |
| The Harbinger | ✅ | ✅ | in progress |
| Telos: Citadel Station | ⬜ | ⬜ | ⬜ |
| Telos: the surface and the academy | ⬜ | ⬜ | ⬜ |
| The Ebon Hawk and the galaxy map | ⬜ | ⬜ | ⬜ |
| Nar Shaddaa | ⬜ | ⬜ | ⬜ |
| Dxun | ⬜ | ⬜ | ⬜ |
| Onderon | ⬜ | ⬜ | ⬜ |
| Dantooine | ⬜ | ⬜ | ⬜ |
| Korriban | ⬜ | ⬜ | ⬜ |
| The Ravager | ⬜ | ⬜ | ⬜ |
| Malachor V, the endings and credits | ⬜ | ⬜ | ⬜ |

## Game systems

Peragus doesn't use any of these, so they'll show up along with the planets that need them.

- [ ] Stores (buying and selling)
- [ ] Influence and companion conversations
- [ ] Training companions as Jedi
- [ ] The full party, and swapping members
- [ ] Lightsabers: building them, crystals, saber forms
- [ ] Prestige classes
- [ ] Light and dark side, and what they do to your powers and appearance
- [ ] Pazaak, swoop racing and the turret minigames
- [ ] The journal across planets
- [ ] Enemy talents (special moves the original AI used)
- [ ] Every original script function the game calls (the log lists any that are still missing)

## Installer

The Mac installer builds the game from your own copy of KOTOR 2, so nothing from the original game is in the download.

- [x] Finds KOTOR 2 (Steam or GOG) and the mods you've downloaded
- [x] Comes with its own Python and Godot, and only downloads Blender if you don't have it
- [x] One screen, one Install button. It tells you what's missing and notices when you've downloaded it
- [x] Shows progress and time left. If you cancel or it stops, Try again picks up where it left off
- [x] Turns the HD texture packs into mods you can switch off
- [x] Works with either TSLRCM build (PC or Switch)
- [x] Checks your free disk space first
- [x] Tested from scratch on one level
- [ ] Windows
- [ ] Linux and Steam Deck
- [ ] Checks the game works before you launch it the first time

## Modding

**Done**
- [x] Drag-and-drop mods: put a `.zip` or folder in the `mods` folder next to the game
- [x] A Mods screen with an on/off switch for each mod, icons, a picture gallery, and each mod's name, author,
      version and description
- [x] Collections, so you can save a set of mods under a name ("Hardcore playthrough", "HD overhaul") and switch
      between them
- [x] Load order, plus a "Find best order" button that sorts mods by what each one asks for
- [x] 30 hooks into the game's rules (damage, healing, XP, Force costs and more)
- [x] New-game choices (like Ironman) and saved data for each mod
- [x] New items and outfits that sit alongside the game's own
- [x] Texture overhauls that replace the game's textures by name
- [x] Packing tools and an example mod (Hardcore) in [modding/](modding)
- [x] A modding guide ([MODDING.md](MODDING.md))

**Later**
- [ ] Expand the modding wiki and make a seperate site for it
- [ ] Hooks for stores, influence, alignment and minigames, once those systems exist
- [ ] Replacing models, sounds and conversations
- [ ] Lock the modding API for 1.0, so new hooks can be added but nothing gets renamed or removed (this should help modders not have to rework everything they port)

## Modernization

I'm keeping this light on purpose.

- [x] Modern graphics settings, resolution and frame rate options
- [x] HD textures as optional mods (Vanilla Planets HD, Vanilla Characters HD)
- [x] Modern menus that still feel like the original
- [x] Rebindable controls and accessibility options
- [ ] Full gamepad support
- [ ] Better lighting where the original's lighting is broken
- [ ] Menus checked on widescreen and high-resolution displays

## Platforms

- [x] Mac (Apple Silicon)
- [ ] Windows
- [ ] Linux and Steam Deck

## Stability

- [x] Saves remember which mods you had on, and warn you if that's changed
- [ ] A crash log with the build number, and a message telling you where to find it
- [ ] A rare crash on a level change (I've seen it once, going from the mining tunnels to the fuel depot)
- [ ] Demo saves loading in later builds, or at least a clear message if they can't
- [ ] All the automated tests passing on every release build

## Releasing

- [x] Test builds on GitHub with the Mac installer
- [x] A readme with what it is, what you need and how to install it
- [x] Screenshots
- [ ] A known-issues list
- [ ] A changelog
- [ ] The version number on the title screen

## Legal

This is a fan project built on Lucasfilm's game, and these are the rules I stick to so it stays on the safe side.
(I'm not a lawyer, so this isn't legal advice.)

- [x] **No original game files** in any download or on this page. The installer builds everything from your own copy.
- [x] **Community mods come from your own downloads**, with links and credits ([COMMUNITY_MODS.md](COMMUNITY_MODS.md)).
- [x] **Free to use, always.** No price, no paid builds, no donations tied to the game.
- [x] **Clearly unofficial.** Not affiliated with or endorsed by Lucasfilm, Disney, Obsidian, Aspyr or EA.
- [ ] An unofficial name and logo (no official logos or box art)
