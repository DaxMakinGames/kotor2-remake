# Known issues

Things I already know about in the demo, so you don't need to report them (but if you find out more, add it to the
issue linked here, or open one). Last updated for **0.9.6** (early access).

## Installing

- **macOS asks before opening Setup.** It isn't signed by Apple. Click **Done**, then **System Settings → Privacy &
  Security → Open Anyway**.
- **The first build takes a while.** That's normal: Setup converts every level from your copy of the game. If it
  stops, **Try again** carries on where it left off.
- **Windows and Steam Deck / Linux are experimental.** Both are new in 0.8.0 and only a few players have tried them so far.
  Setup may not find the game on every machine (choose its folder by hand), and the first build may fail somewhere the
  Mac's doesn't. Reports with Setup's **Show details** log (or **Copy report**) are the most useful thing you can send.
- **Setup 0.8.0 could freeze at the start of the build** with an empty details log (seen on Windows). Fixed in 0.8.1:
  press **Cancel** and run the new Setup.
- **Setup 0.9.0 stopped at "the mods" (step 4 of 27)** with "File exists" in its log, when the KOTOR 2 Community Patch
  (K2CP) was among the mods. Fixed in 0.9.5: run the new Setup.
- **Windows asks before running Setup** ("Windows protected your PC"): it isn't signed yet. **More info → Run anyway**.
- **On a Steam Deck, Setup runs in Desktop Mode.** It adds the game to Steam by itself; then play it in Game Mode
  ([INSTALL_STEAM_DECK.md](INSTALL_STEAM_DECK.md)).

## In the game

- **A rare crash when changing level.** Seen once, going from the mining tunnels to the fuel depot. If it happens to
  you, the title screen offers to report it with its log, which would really help.
- **Controller support is new.** If a screen can't be used with a controller, or a button does the wrong thing,
  please report it. Controller buttons can't be rebound yet (keys can, in Options),
  and "Party: hold or follow" has no controller button yet (it's H on the keyboard).
- **The map's markers** show exits, loot and your own notes, not where a quest wants you to go: the original game's
  journal only says what to do, not where.
- **The map shows only rooms you've been in.** Saves from before 0.7.0 didn't keep track, so the map starts again
  from the room you load into.
- **Voices on the later Peragus levels** haven't all been checked. Missing or wrong lines are worth reporting.
- **Combat balance** (enemy numbers, XP) hasn't been tuned by hand yet.
- **Some lighting and floors** may look too dark or patchy in places.
- **The end of the demo** doesn't yet say what's next.
- **Stores and the galaxy map are new** in 0.9.5. Peragus has no store, so they show up with Telos.
- **The party selection screen and Companion Settings are new** in 0.9.0. Peragus never asks for the party screen
  itself; open it from the Party page (**Choose party...**) to try it.

## Mods

- Mods can't add levels yet (they can replace models, sounds and conversations). See [MODDING.md](MODDING.md).
- Turning mods on or off takes effect at once, but models and textures already in a level change only when a level
  next loads. A mod that needs a restart says so on the Mods screen.
