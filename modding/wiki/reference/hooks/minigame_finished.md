# minigame_finished

<span class="hook-kind event">event</span> &nbsp; Stores and minigames

A minigame has ended.

## Signature

```gdscript
on(&"minigame_finished", func(kind: String, result: int): ...)
```

| Argument | Type | What |
|---|---|---|
| `kind` | `String` | "turret" |
| `result` | `int` | the minigame's own result: 107PER_MG_FINISHED for the turret; for a swoop race its time in hundredths of a second (59:59.99, 359999, when the race was lost or forfeited) |


## Where the game calls it

KotorTurret, KotorSwoop

## Example

```gdscript
func _mod_ready() -> void:
	on(&"minigame_finished", func(kind: String, _result: int):
		give_item("g_i_medeqpmnt01") if kind == "turret" else null)
```
