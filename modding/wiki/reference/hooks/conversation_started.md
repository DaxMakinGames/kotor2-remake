# conversation_started

<span class="hook-kind event">event</span> &nbsp; Story and world

A conversation has begun.

## Signature

```gdscript
on(&"conversation_started", func(conv: String, owner: Node): ...)
```

| Argument | Type | What |
|---|---|---|
| `conv` | `String` | the conversation's name, such as "101kreia" |
| `owner` | `Node` | who it belongs to |


## Where the game calls it

Kotor.start_dialogue

## Example

```gdscript
func _mod_ready() -> void:
	on(&"conversation_started", func(conv: String, _owner): write_log("talking: " + conv))
```
