# conversation_ended

<span class="hook-kind event">event</span> &nbsp; Story and world

A conversation has ended, after its last scripts ran.

## Signature

```gdscript
on(&"conversation_ended", func(conv: String): ...)
```

| Argument | Type | What |
|---|---|---|
| `conv` | `String` | the conversation's name |


## Where the game calls it

Kotor's end of conversation (_finish_conversation)

## Example

```gdscript
func _mod_ready() -> void:
	on(&"conversation_ended", func(conv: String): pass)
```
