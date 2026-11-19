# minigame_started

<span class="hook-kind event">event</span> &nbsp; Stores and minigames

A minigame has begun: "turret" (the Ebon Hawk's gun on Peragus) or "swoop" (the race on Telos). Pazaak will say so too once it's in.

## Signature

```gdscript
on(&"minigame_started", func(kind: String): ...)
```

| Argument | Type | What |
|---|---|---|
| `kind` | `String` | "turret" |


## Where the game calls it

KotorTurret, KotorSwoop

## Example

```gdscript
func _mod_ready() -> void:
	on(&"minigame_started", func(kind: String):
		write_log("minigame: " + kind))
```
