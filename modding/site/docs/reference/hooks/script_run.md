# script_run

<span class="hook-kind event">event</span> &nbsp; Story and world

One of the original game's scripts is about to run.

## Signature

```gdscript
on(&"script_run", func(script_name: String, owner: Node): ...)
```

| Argument | Type | What |
|---|---|---|
| `script_name` | `String` | the script, in lower case, such as "a_cut_kreia" |
| `owner` | `Node` | who runs it |


## Where the game calls it

Kotor._run

## Notes

This runs very often. Do as little as you can in it.

## Example

```gdscript
func _mod_ready() -> void:
	on(&"script_run", func(script_name: String, _owner): if script_name == "a_cut_kreia": write_log("Kreia rises"))
```
