# Installing on Steam Deck (and Linux)

> [!WARNING]
> **Experimental.** The Steam Deck and Linux build is new and hasn't been run on a real Deck yet. If something goes
> wrong, please [report it](https://github.com/DaxMakinGames/kotor2-remake/issues): Setup's **Show details** log and what
> happened help the most.

Setup runs once in **Desktop Mode** to build the game from your copy of KOTOR 2. After that you play it from **Game
Mode** like any other game in your library, with the Deck's controls.

**You need:** KOTOR 2 installed through Steam on the Deck (the native version Steam installs by default), about 10 GB
of free space while it builds, and Wi-Fi the first time (Setup downloads Blender from blender.org).

## 1. Switch to Desktop Mode

Press the **Steam** button → **Power** → **Switch to Desktop**.

## 2. Get the two downloads

Open a browser (Firefox is in the Discover store if you don't have one):

1. **TSLRCM** (free, the one mod you need). Either:
   - **subscribe** to it on the [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=485537937): Setup
     finds it there, nothing to download; or
   - download [TSLRCM 1.8.6 from GameBanana](https://gamebanana.com/mods/617353) into **Downloads**. Setup unpacks it by
     itself. Saved somewhere else? Press **Choose the file...** on Setup's Mods page.
2. **Setup** from [Releases](https://github.com/DaxMakinGames/kotor2-remake/releases):
   **KOTOR2-Remake-Setup-Linux.tar.gz**, into **Downloads**.

## 3. Run Setup

1. Open **Dolphin** (the file manager) → **Downloads**.
2. Right-click **KOTOR2-Remake-Setup-Linux.tar.gz** → **Extract → Extract archive here**. Open the
   **KOTOR2RemakeSetup** folder it makes and double-click **AppRun** (if it asks, choose **Execute**).
3. Setup finds KOTOR 2 in your Steam library (the SD card too). On the **Mods** page, check TSLRCM is found; the
   **Recommended** tab lists optional upgrades.
4. The **Ready** page checks everything at once: space, TSLRCM, the internet for Blender, and that the Deck is plugged
   in. Leave **Steam library** ticked.
5. Press **Install** and leave the Deck plugged in. Setup shows how long is left, and you can watch each level being
   built. If it stops, it says what to do; **Try again** carries on where it stopped.

The game goes into `~/Games/KOTOR 2 Remake/`. When it's done, Setup removes everything it used to build it.

## 4. The game in Steam

Setup adds the game to your Steam library by itself, with its artwork. Steam has to close for a moment while it's
added: if it's open, press **Close Steam and add it** on the last page, and it opens again afterwards.

To add it by hand instead: **Steam** → **Games** → **Add a Non-Steam Game to My Library...** → **Browse...**, pick
`/home/deck/Games/KOTOR 2 Remake/KOTOR2.x86_64`, and press **Add Selected Programs**. Leave **Compatibility** (Proton)
off: it's a native Linux game.

## 5. Play in Game Mode

Double-click **Return to Gaming Mode** on the desktop. The game is in **Library → Non-Steam**. The Deck's controls work
out of the box.

**Suggested settings on the Deck** (Options → Graphics): Upscaling **FSR 2**, Render resolution **Quality (67%)**,
Effects **Enhanced** at **Medium**, or Classic for the longest battery life.

## Updating

Download the new Setup in Desktop Mode and run it. If your game data is still current, it says **Update** and takes
about a minute; your saves, settings and mods are kept, and the Steam shortcut keeps working.

## Other Linux PCs

The same steps work on desktop Linux (x86_64, with Vulkan graphics): run Setup, then start
`~/Games/KOTOR 2 Remake/KOTOR2.x86_64`, or add it to Steam as above.

## If something goes wrong

- **Setup can't find KOTOR 2:** press **Change...** on the *Your game* page and pick the game's folder: in your Steam
  library, `steamapps/common/Knights of the Old Republic II/steamassets`, or the game's folder itself if you installed
  the Windows version through Proton.
- **AppRun won't open:** right-click it → **Properties** → **Permissions** → tick **Is executable** → **OK**, and try
  again.
- **The build stops:** Setup says what went wrong and what to do. **Try again** carries on where it stopped. To report
  it, press **Copy report** (or **Report on GitHub**, which opens an issue to paste it into).
