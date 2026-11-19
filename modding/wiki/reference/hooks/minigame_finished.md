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
| `result` | `int` | the minigame's own result global (107PER_MG_FINISHED for the turret) |


## Where the game calls it

KotorTurret

## Example

```gdscript
func _mod_ready() -> void:
	on(&"minigame_finished", func(kind: String, _result: int):
		give_item("g_i_medeqpmnt01") if kind == "turret" else null)
```
