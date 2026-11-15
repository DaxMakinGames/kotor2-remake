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

1. **TSLRCM** (free, the one mod you need): [TSLRCM 1.8.6 on GameBanana](https://gamebanana.com/mods/617353). Save it in
   **Downloads**. Setup unpacks it by itself.
2. **Setup** from [Releases](https://github.com/DaxMakinGames/kotor2-remake/releases):
   **KOTOR2-Remake-Setup-Linux.tar.gz**, into **Downloads**.

## 3. Run Setup

1. Open **Dolphin** (the file manager) → **Downloads**.
2. Right-click **KOTOR2-Remake-Setup-Linux.tar.gz** → **Extract → Extract archive here**. Open the
   **KOTOR2RemakeSetup** folder it makes and double-click **AppRun** (if it asks, choose **Execute**).
3. Setup finds KOTOR 2 in your Steam library (the SD card too). On the **Mods** page, check TSLRCM is found; the
   **Recommended** tab lists optional upgrades.
4. Press **Install** and leave the Deck plugged in: the first build takes a while. You can watch each level being
   built.

The game goes into `~/Games/KOTOR 2 Remake/`.

## 4. Add it to Steam

1. Open **Steam** on the desktop → **Games** → **Add a Non-Steam Game to My Library...** → **Browse...**
2. Go to `/home/deck/Games/KOTOR 2 Remake/`, pick **KOTOR2.x86_64**, and press **Add Selected Programs**.
3. Optional: in your library, right-click it → **Properties** to rename it **KOTOR 2 Remake** and set artwork.
4. Leave **Compatibility** (Proton) off: it's a native Linux game.

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
- **The build stops:** turn on **Show details** and send the last lines with your report. **Try again** carries on
  where it stopped.
