# minigame_started

<span class="hook-kind event">event</span> &nbsp; Stores and minigames

A minigame has begun. So far that's the Ebon Hawk's turret on Peragus; pazaak and swoop racing will say so too once they're in.

## Signature

```gdscript
on(&"minigame_started", func(kind: String): ...)
```

| Argument | Type | What |
|---|---|---|
| `kind` | `String` | "turret" |


## Where the game calls it

KotorTurret

## Example

```gdscript
func _mod_ready() -> void:
	on(&"minigame_started", func(kind: String):
		write_log("minigame: " + kind))
```
