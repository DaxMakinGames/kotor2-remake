# Installing on Windows

> [!WARNING]
> **Experimental.** The Windows build is new and hasn't been run on real Windows hardware yet. If something goes wrong,
> please [report it](https://github.com/DaxMakinGames/kotor2-remake/issues): Setup's **Show details** log and what
> happened help the most.

**You need:** Windows 10 or 11 (64-bit), KOTOR 2 from Steam or GOG, about 25 GB of free space while it builds, and an
internet connection the first time (Setup downloads Blender from blender.org if you don't have it).

## 1. Get the two downloads

1. **TSLRCM** (free, the one mod you need). Any of these works:
   - **subscribe** to it on the [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=485537937):
     Setup finds it there;
   - download [TSLRCM 1.8.6 from GameBanana](https://gamebanana.com/mods/617353) into **Downloads**. Setup unpacks it
     by itself. Saved somewhere else? Press **Choose the file...** on Setup's Mods page;
   - already ran TSLRCM's own installer (the `.exe` from Deadly Stream) into your KOTOR 2 folder? Setup finds it there.
2. **KOTOR2-Remake-Setup-Windows.zip** from [Releases](https://github.com/DaxMakinGames/kotor2-remake/releases).

## 2. Run Setup

1. Right-click the zip, choose **Extract All**, and open the folder it makes.
2. Run **KOTOR 2 Remake Setup.exe**. It isn't signed yet, so Windows may show *"Windows protected your PC"*: click
   **More info**, then **Run anyway**.
3. Setup finds KOTOR 2 in Steam or GOG. If it doesn't, choose the game's folder (the one with `chitin.key` in it).
4. On the **Mods** page, check TSLRCM is found. The **Recommended** tab lists optional upgrades worth getting.
5. The **Ready** page checks everything at once, and has the shortcuts: **Start menu**, **Desktop**, and **Steam
   library**.
6. Press **Install**. The first build takes a while: Setup converts the game's levels from your own copy, shows how
   long is left, and lets you watch each level being built.

The game goes into `%LOCALAPPDATA%\Programs\KOTOR 2 Remake` (no administrator needed) unless you choose another folder.
When it's done, Setup removes everything it used to build it: only the game and its mods folder are left.

## 3. Play

Press **Play** at the end, or use the Start menu or desktop shortcut. If you ticked **Steam library**, it's in Steam
too (Steam closes for a moment while it's added, if it was open).

## Updating

Download the new Setup and run it. If your game data is still current, it says **Update** and takes about a minute;
your saves, settings and mods are kept.

## If something goes wrong

- **Setup can't find KOTOR 2:** press **Change...** on the *Your game* page and pick the game's folder.
- **Antivirus stops Setup:** it runs Python, Blender and Godot to build the game; allow Setup's folder.
- **The build stops:** Setup says what went wrong and what to do. **Try again** carries on where it stopped. To report
  it, press **Copy report** (or **Report on GitHub**, which opens an issue to paste it into).
