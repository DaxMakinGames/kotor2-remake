# Outfits and textures

An outfit is an [item](items.md) with a `worn` entry: which body it uses, and the texture for each body type.

```gdscript
add_item("myrobes_grey", {
	"name": "Grey Wanderer's Robe",
	"base": 35,                                    # Jedi Robe
	"cost": 700,
	"props": [["Armor", 0, 1]],
	"icon": "icons/grey.png",
	"worn": {
		"body": "i",                               # the robe body
		"texture_files": {"male": "textures/pmbi_grey.webp", "female": "textures/pfbi_grey.webp"},
	},
})
```

## Bodies

The player's outfit bodies are letters, the same as the original game's:

| Letter | Male body | Male textures | Female body |
|---|---|---|---|
| `a` | `pmbam` | `pmbama` (starting clothes) | `pfbam` |
| `b` | `n_commm` | `n_commm` | |
| `c` to `h` | `pmbcm` to `pmbhm` | `pmbc01`..., `pmbh01`... | `pfbcm` to `pfbhm` |
| `i` | `pmbim` (Jedi robe) | `pmbi01` to `pmbi09` | `pfbim` |
| `j`, `k`, `m` | `pmbjm`, `pmbkm`, `pmbmm` | `pmbj`, `pmbk`, `pmbm` | `pfbjm`, `pfbkm`, `pfbmm` |
| `n` | `pmbnm` | `pfbn01`... | `pfbnm` |

The models are in `import/kotor/creatures/`, and their textures in `import/kotor/creatures/textures/`. The full list is
`outfits` and `female_outfits` in the pipeline's `player_kit.json`.

## Textures

Your texture must be painted for **that body's layout** (its UV map). The quickest start is to open the game's own
texture for the body, `import/kotor/creatures/textures/pmbi04.png` for a robe, and paint over it.

> [!WARNING]
> **A texture made for another model won't fit**
> Textures made for a different model come out scrambled on ours. The [Prequel Robes](../examples/prequel-robes.md)
> textures are an example: they were painted for different robe models.

- **Formats:** WebP, PNG, JPG or TGA. Square or not; mipmaps are made when the texture loads.
- **Orientation:** the same way up as the game's PNGs. If yours shows upside down, flip it vertically.
- **Alpha:** ignored for clothing (the original game used it for shine).
