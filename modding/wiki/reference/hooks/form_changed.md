# form_changed

<span class="hook-kind event">event</span> &nbsp; Lightsabers and forms

Someone took up a form, or let one go.

## Signature

```gdscript
on(&"form_changed", func(key: String, kind: String, power: int): ...)
```

| Argument | Type | What |
|---|---|---|
| `key` | `String` | the character ("player" or a companion's template) |
| `kind` | `String` | "saber" or "force" |
| `power` | `int` | the form's power id (258 to 268), or -1 when dropped |


## Where the game calls it

KotorForms.set_active

## Example

```gdscript
func _mod_ready() -> void:
	on(&"form_changed", func(key: String, _kind: String, power: int):
		write_log("%s: form %d" % [key, power]))
```
