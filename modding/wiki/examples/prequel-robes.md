# Prequel Robes

Nine Jedi robes in the style of the prequel films, added **beside** the game's own robes. Source:
`modding/examples/prequel_robes`. Textures: *K2 Prequel Robes, Saul's Edit 1.1*.

> [!WARNING]
> **Not ready to ship yet**
> These textures were painted for different robe models than the game's, and that mod's folder has only textures.
> On the game's robe body they come out scrambled. The mod needs the robe models the textures were made for. Until
> then it isn't packed into a `.zip`.

## How it adds rather than replaces

The original mod overwrote the game's robe textures (`pmbi01`... and `pfbi01`...), changing every Jedi robe in the
game. This version:

- **Adds nine new items** (`prequel_robe_01`...), each with the same stats as the robe it's based on (`robes.json`).
  Jedi Robe (Prequel) is as good as the Jedi Robe.
- **Gives each its own textures and icon**, by file (`worn.texture_files`), so the game's `pmbi04` is untouched.
- **Hands out only the two Padawan robes** at the start, since the others are far stronger than anything on Peragus.
  The *All nine robes from the start* setting gives the rest.

```gdscript
for r in _robes:
	var n := String(r["variant"])
	add_item("prequel_robe_" + n, {
		"name": r["name"], "base": r["base"], "cost": r["cost"], "props": r["props"],
		"icon": "icons/ia_jedirobe_0%s.png" % n,
		"worn": {"body": "i", "texture_files": {"male": "textures/pmbi%s.webp" % n, "female": "textures/pfbi%s.webp" % n}}})
```
