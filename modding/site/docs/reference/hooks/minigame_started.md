# minigame_started

<span class="hook-kind event">event</span> &nbsp; Stores and minigames

A minigame has begun: "turret" (the Ebon Hawk's gun on Peragus), "swoop" (the races on Telos and Nar Shaddaa) or "pazaak" (once the side deck is picked and the first card is dealt).

## Signature

```gdscript
on(&"minigame_started", func(kind: String): ...)
```

| Argument | Type | What |
|---|---|---|
| `kind` | `String` | "turret" |


## Where the game calls it

KotorTurret, KotorSwoop, KotorPazaakUI

## Example

```gdscript
func _mod_ready() -> void:
	on(&"minigame_started", func(kind: String):
		write_log("minigame: " + kind))
```
