# Installing on Windows

> [!WARNING]
> **Experimental.** The Windows build is new and hasn't been run on real Windows hardware yet. If something goes wrong,
> please [report it](https://github.com/DaxMakinGames/kotor2-remake/issues): Setup's **Show details** log and what
> happened help the most.

**You need:** Windows 10 or 11 (64-bit), KOTOR 2 from Steam or GOG, about 10 GB of free space while it builds, and an
internet connection the first time (Setup downloads Blender from blender.org if you don't have it).

## 1. Get the two downloads

1. **TSLRCM** (free, the one mod you need): [TSLRCM 1.8.6 on GameBanana](https://gamebanana.com/mods/617353). Leave it
   in your **Downloads** folder. Setup unpacks it by itself, so there's nothing to unzip.
2. **KOTOR2-Remake-Setup-Windows.zip** from [Releases](https://github.com/DaxMakinGames/kotor2-remake/releases).

## 2. Run Setup

1. Right-click the zip, choose **Extract All**, and open the folder it makes.
2. Run **KOTOR 2 Remake Setup.exe**. It isn't signed yet, so Windows may show *"Windows protected your PC"*: click
   **More info**, then **Run anyway**.
3. Setup finds KOTOR 2 in Steam or GOG. If it doesn't, choose the game's folder (the one with `chitin.key` in it).
4. On the **Mods** page, check TSLRCM is found. The **Recommended** tab lists optional upgrades worth getting.
5. Press **Install**. The first build takes a while: Setup converts the game's levels from your own copy. You can watch
   each level being built.

The game goes into `%LOCALAPPDATA%\Programs\KOTOR 2 Remake` (no administrator needed) unless you choose another folder.

## 3. Play

Press **Play** at the end, or run **KOTOR2.exe** in the game's folder. To have it in your Steam library: in Steam,
**Games → Add a Non-Steam Game to My Library → Browse**, pick `KOTOR2.exe`, and press **Add Selected Programs**.

## Updating

Download the new Setup and run it. If your game data is still current, it says **Update** and takes about a minute;
your saves, settings and mods are kept.

## If something goes wrong

- **Setup can't find KOTOR 2:** press **Change...** on the *Your game* page and pick the game's folder.
- **Antivirus stops Setup:** it runs Python, Blender and Godot to build the game; allow Setup's folder.
- **The build stops:** turn on **Show details** and send the last lines with your report. **Try again** carries on
  where it stopped.
