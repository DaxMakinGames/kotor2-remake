# Known issues

Things I already know about in the demo, so you don't need to report them (but if you find out more, add it to the
issue linked here, or open one). Last updated for **0.7.3-demo**.

## Installing

- **macOS asks before opening Setup.** It isn't signed by Apple. Click **Done**, then **System Settings → Privacy &
  Security → Open Anyway**.
- **The first build takes an hour or more.** That's normal: Setup converts every level from your copy of the game.
  If it stops, **Try again** carries on where it left off.
- **Mac only** for now. Windows is planned.

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

## Mods

- Mods can't add levels, or replace models, sounds or conversations yet. See [MODDING.md](MODDING.md).
- Turning mods on or off needs a restart (**Restart to apply** on the Mods screen).
