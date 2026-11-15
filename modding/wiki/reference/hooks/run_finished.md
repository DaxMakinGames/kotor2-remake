# run_finished

<span class="hook-kind event">event</span> &nbsp; Game flow

The end of what's playable: the demo's end screen, as the story leaves for the Ebon Hawk.

## Signature

```gdscript
on(&"run_finished", func(): ...)
```

No arguments.

## Where the game calls it

room_loader.gd, when the transition to the Ebon Hawk is reached

## Notes

Fires once per playthrough that reaches the end. Speedrun stops its timer here.

## Example

```gdscript
func _mod_ready() -> void:
	on(&"run_finished", func():
		write_log("Finished in %d kills" % int(save_data().get("kills", 0))))
```
