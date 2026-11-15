# Your first mod

## The quickest start: copy the Starter Mod

The examples include **Starter Mod** (`starter`), made to be copied. It has one of each part a mod is made of: a
setting, a hook that changes a number, events, and its own saved state, each with a comment.

1. Copy the `starter` folder into your [mods folder](installing.md) and rename it, say to `my_mod`.
2. In its `mod.json`, change `"id"` to the folder's new name (`"my_mod"`) and `"name"` to what players should see.
3. Open **Mods** on the title screen and turn it on. Then edit `main.gd`, turn the mod off and on again, and your change
   is in: a mod reloads with no restart.

The rest of this page builds a mod from nothing, so you see what each part does.

## From nothing: double the experience

This builds a mod that doubles the experience you earn. It takes two files.

### 1. Make the folder

In the [mods folder](installing.md), make a folder called `double_xp`.

### 2. mod.json

```json
{
  "id": "double_xp",
  "name": "Double XP",
  "version": "1.0.0",
  "author": "you",
  "description": "Twice the experience from everything.",
  "api": 1,
  "entry": "main.gd"
}
```

`id` is how the game knows your mod: in saves, settings and other mods' `load_after`. Never change it after people
start using the mod. See [mod.json](../reference/mod-json.md) for every field.

### 3. main.gd

```gdscript
extends KotorMod

func _mod_ready() -> void:
	hook(&"xp_award", func(xp: int, _ctx: Dictionary) -> int: return xp * 2)
```

- `extends KotorMod`: every mod script starts this way. See [KotorMod](../reference/kotormod.md).
- `_mod_ready()`: runs once, after every mod has loaded.
- `hook(&"xp_award", ...)`: the game asks for its XP amount, and your function returns it doubled. See
  [xp_award](../reference/hooks/xp_award.md).

### 4. Try it

Start the game and open **Mods**: *Double XP* is listed and on. Start a game and kill something: the XP notice shows
twice the usual amount.

### 5. Make it a setting

Players like control. Make the multiplier a slider:

```gdscript
extends KotorMod

func _mod_ready() -> void:
	add_option(&"multiplier", "XP multiplier", TYPE_FLOAT, 2.0, 1.0, 5.0, 0.5)
	hook(&"xp_award", func(xp: int, _ctx: Dictionary) -> int:
		return roundi(xp * float(setting(&"multiplier"))))
```

It now appears on the Mods screen and in Options, and the value is kept between games. Next:
[Hooks explained](../guides/hooks.md) and [Packing and sharing](packing.md).

> [!WARNING]
> **Two things a folder mod can't do**
> A folder mod's `main.gd` is read as source text, so it can't use `class_name` or `preload` files beside it.
> Use `load(mod_path("file"))` instead, or pack the mod as a `.zip`.
