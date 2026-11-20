# journal_updated

<span class="hook-kind event">event</span> &nbsp; Story and world

A quest's entry in the journal changed (a script's AddJournalQuestEntry moved it to another state).

## Signature

```gdscript
on(&"journal_updated", func(quest: String, state: int): ...)
```

| Argument | Type | What |
|---|---|---|
| `quest` | `String` | the quest's tag, lower case (rules.json "quests") |
| `state` | `int` | its new state, one of the quest's entry IDs |


## Where the game calls it

KotorGameEngine._fn_AddJournalQuestEntry

## Notes

Only real changes: setting a quest to the state it's already in says nothing.

## Example

```gdscript
func _mod_ready() -> void:
	on(&"journal_updated", func(quest: String, state: int):
		write_log("%s is now at %d" % [quest, state]))
```
