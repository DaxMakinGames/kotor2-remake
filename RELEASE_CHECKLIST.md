# Roadmap

Here's what's done, what I'm working on, and what's left before a 1.0. Checked boxes are done and tested.

> **Where things are right now:** early access: Peragus and the Harbinger start to finish, and the Ebon Hawk and Telos (0.9.6), not yet played through. 0.9.8 adds influence, the light and dark side, crystals, forms and the journal across planets.
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
- [ ] A full playthrough by someone who isn't me (this is where you come in)

**Before I call the demo finished**
- [ ] An end screen that says what's next and where to report bugs
- [x] A known-issues list ([KNOWN_ISSUES.md](KNOWN_ISSUES.md))
- [x] Gamepad support in every menu (first version)

## Planets

Every planet goes through the same three steps. First I **build** it (the pipeline converts it from your copy). Then
it's **walked** (every area toured: rooms, doors, containers, conversations and scripts). Then I **check** it by playing it myself.

| Planet | Build | Walk | Check |
|---|---|---|---|
| Peragus (mining facility) | ✅ | ✅ | in progress |
| The Harbinger | ✅ | ✅ | in progress |
| Telos: Citadel Station | ✅ | ✅ | ⬜ |
| Telos: the surface and the academy | ✅ | ✅ (not the swoop race) | ⬜ |
| The Ebon Hawk and the galaxy map | ✅ | ✅ | ⬜ |
| Nar Shaddaa | ⬜ | ⬜ | ⬜ |
| Dxun | ⬜ | ⬜ | ⬜ |
| Onderon | ⬜ | ⬜ | ⬜ |
| Dantooine | ⬜ | ⬜ | ⬜ |
| Korriban | ⬜ | ⬜ | ⬜ |
| The Ravager | ⬜ | ⬜ | ⬜ |
| Malachor V, the endings and credits | ⬜ | ⬜ | ⬜ |

## Game systems

Peragus doesn't use any of these, so they'll show up along with the planets that need them.

- [x] Stores (buying and selling) and credits (0.9.5)
- [x] The galaxy map (0.9.5)
- [x] Influence and companion conversations: influence from 0 to 100 starting at 50, "Influence gained" and "lost" on
      screen, and companions' alignment following yours as influence pulls them (0.9.8)
- [ ] Training companions as Jedi
- [x] The full party, and swapping members (the party selection screen, 0.9.0)
- [x] Companion settings: orders, when to heal, how to fight, which powers (0.9.0)
- [x] Levels as data: a new level needs no game code, only building (0.9.0)
- [x] Lightsabers: colour crystals that change the blade (every colour's saber is built), and the seven lightsaber forms
      and four Force forms at the numbers their descriptions give (0.9.8). Building one is the story's: its scripts run as written
- [ ] Prestige classes
- [x] Light and dark side: companions' own alignment and its Force costs, and the dark side's four stages on your face (0.9.8)
- [ ] Pazaak and swoop racing (the turret minigame is in)
- [x] The journal across planets: grouped by planet, the latest news first, new updates marked, each quest's earlier entries (0.9.8)
- [x] Enemies' combat feats (Power Attack, Flurry, Critical Strike...) and critical hits (0.9.6)
- [ ] Every original script function the game calls: every built level has all it calls, except swoop racing's
      (tools/level_functions.py lists any that are missing)

## Installer

The Mac installer builds the game from your own copy of KOTOR 2, so nothing from the original game is in the download.

- [x] Finds KOTOR 2 (Steam or GOG) and the mods you've downloaded
- [x] Comes with its own Python and Godot, and only downloads Blender if you don't have it
- [x] One screen, one Install button. It tells you what's missing and notices when you've downloaded it
- [x] Shows progress and time left. If you cancel or it stops, Try again picks up where it left off
- [x] Turns the HD texture packs into mods you can switch off
- [x] Works with either TSLRCM build (PC or Switch)
- [x] Checks your free disk space first
- [x] Quick updates: replaces only the game when the game data hasn't changed
- [x] Unpacks mod downloads (.7z, .zip, .rar) by itself, so there's nothing to unzip
- [x] Tested from scratch on one level
- [ ] Tested from scratch on the whole demo, start to finish in the window
- [ ] Tested on a second Mac
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
- [x] 50 hooks into the game's rules and story (damage, healing, XP, Force costs, influence, alignment, stores and more)
- [x] New-game choices (like Ironman) and saved data for each mod
- [x] New items and outfits that sit alongside the game's own
- [x] Texture overhauls that replace the game's textures by name
- [x] Packing tools and an example mod (Hardcore) in [modding/](modding)
- [x] A modding guide ([MODDING.md](MODDING.md))

**Later**
- [ ] Put the modding wiki online
- [x] Hooks for stores, influence, alignment, forms, the journal and minigames (0.9.8)
- [x] Replacing models, sounds and conversations
- [x] Lock the modding API for 1.0, so new hooks can be added but nothing gets renamed or removed (0.9.8: every release is
      checked against the lock)

## Modernization

I'm keeping this light on purpose. The original's look and rules come first.

- [x] Modern graphics settings, resolution and frame rate options
- [x] HD textures as optional mods (Vanilla Planets HD, Vanilla Characters HD)
- [x] Modern menus that still feel like the original
- [x] Rebindable controls and accessibility options
- [x] Controller support: every action on a pad, menus with the d-pad and A/B, the right stick for the camera and
      the Force wheel, button names in prompts, vibration (new: tell me about any screen that doesn't work with it)
- [x] Quicksave and quickload (F5, F9), and the last three autosaves kept
- [x] A combat log on the HUD, with the dice rolls if you want them
- [x] A conversation log (K), and replies you've already chosen greyed out
- [x] Camera options: field of view, over-the-shoulder, swinging behind you as you walk
- [x] Lightsaber trails, and Enhanced Force effects (light, shockwaves, lightning arcs), with the originals as an option
- [x] Loot shows how an item compares with what you're wearing
- [x] The current objective pinned on the HUD; the map shows exits, loot not taken, and your own notes
- [x] A combat pause (Space, or B), and auto-pause when a fight starts or someone in the party falls
- [x] Companion tactics per companion: when to use a medpac, chase or stay back, which Force powers
- [x] Text size, a readable font (OpenDyslexic if installed), and camera shake options
- [x] Enhanced effects (Classic keeps the original's): glow, filmic tone mapping and soft shadowing in corners;
      lightsabers that light the room; glowing blaster bolts and scorch marks; layered explosions with a look per
      grenade type; hit flashes and shield ripples ([VFX plan](VFX_PLAN.md))
- [ ] Enhanced Force powers, holograms, steam and screens (the rest of the VFX plan)
- [ ] Better lighting where the original's lighting is broken
- [ ] Menus checked on widescreen and high-resolution displays

## Platforms

- [x] Mac (Apple Silicon)
- [ ] A signed Mac app, so you don't have to right-click and choose Open (that needs Apple's $99/year developer program)
- [ ] Windows (it'll warn you the app isn't signed)
- [ ] Linux and Steam Deck
- [ ] Minimum and recommended specs, actually measured
- [ ] Load times and frame rates measured in the heaviest scenes

## Stability

- [x] Saves remember which mods you had on, and warn you if that's changed
- [x] A crash notice: if the game closed unexpectedly, the title screen says so and offers to report it with its log
- [ ] A rare crash on a level change (I've seen it once, going from the mining tunnels to the fuel depot)
- [ ] Demo saves loading in later builds, or at least a clear message if they can't
- [ ] All the automated tests passing on every release build

## Releasing

- [x] Test builds on GitHub with the Mac installer
- [x] A readme with what it is, what you need and how to install it
- [x] Screenshots
- [x] A known-issues list
- [x] A bug report form on GitHub, and **Report a Bug** in the game that fills it in for you
- [ ] A changelog
- [x] The version number on the title screen
- [ ] A credits screen in the game
- [ ] A short video

## Legal

This is a fan project built on Lucasfilm's game, and these are the rules I stick to so it stays on the safe side.
(I'm not a lawyer, so this isn't legal advice.)

- [x] **No original game files** in any download or on this page. The installer builds everything from your own copy.
- [x] **Community mods come from your own downloads**, with links and credits ([COMMUNITY_MODS.md](COMMUNITY_MODS.md)).
- [x] **Free to use, always.** No price, no paid builds, no donations tied to the game.
- [x] **Clearly unofficial.** Not affiliated with or endorsed by Lucasfilm, Disney, Obsidian, Aspyr or EA.
- [ ] Pick a proper open licence for my own code, so "free to use" is official
- [ ] An unofficial name and logo (no official logos or box art)
