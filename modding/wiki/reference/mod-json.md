# mod.json

Every mod has a `mod.json` at the top of its folder (or at `mods/<id>/mod.json` inside its `.zip`).

```json
{
  "id": "hardcore",
  "name": "Hardcore",
  "version": "1.0.0",
  "author": "you",
  "description": "Shown on the Mods screen.",
  "api": 1,
  "entry": "main.gd",
  "load_after": [],
  "conflicts": [],
  "replaces": []
}
```

| Field | Required | Meaning |
|---|---|---|
| `id` | yes | The mod's name in code, saves and settings. Lowercase, no spaces. Never change it after release |
| `name` | | Shown on the Mods screen. Defaults to `id` |
| `version` | | Shown, and recorded in saves. Raise it when your saved data changes |
| `author` | | Shown on the Mods screen |
| `description` | | Shown on the Mods screen |
| `api` | | The hook version you wrote for. Now **1**. A mod for a newer version than the game's isn't loaded |
| `entry` | | The script to run. Default `main.gd`. `""` for a mod with no script, such as pure art |
| `load_after` | | Mod ids this one must load after |
| `load_before` | | Mod ids this one must load before. **Find best order** on the Mods screen sorts by both |
| `conflicts` | | Mod ids this one can't run with |
| `replaces` | | Game files your `.zip` or `mod.pck` replaces, such as `res://data/tuning.tres` |
| `textures` | | A folder of pictures that replace the game's textures by name. See [Texture overhauls](../guides/textures.md) |
| `icon` | | A square picture shown beside the mod's name on the Mods screen (PNG, JPG or WebP; 256 × 256 is plenty) |
| `pictures` | | Screenshots for the mod's page, which players scroll through, such as `["pictures/1.png", "pictures/2.png"]` |

The icon and pictures are read straight from the `.zip`, so they show even while the mod is off.
`modding/tools/pack_art_mod.py` keeps them in the zip as they are.

A folder mod may also hold a `mod.pck` (a Godot resource pack). It's mounted when the mod is on, like a `.zip`.
