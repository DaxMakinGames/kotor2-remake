# Conversations, quests and stores

A mod can add story of its own: a character with something to say, a quest in the journal, a store to trade at. The
**Cantina Errand** and **Aqualish Trader** examples (`modding/examples/cantina_errand`, `modding/examples/aqualish_trader`)
are whole ones to copy.

## A conversation of the mod's own

Put `.dialogue` files (Dialogue Manager's format) in a folder and name it in `mod.json`:

```json
{ "id": "my_quest", "name": "My Quest", "version": "1.0.0", "api": 1, "conversations": "conversations" }
```

A file with a name the game doesn't use is the mod's own. Give it to a character, by their tag, every time their
level loads:

```gdscript
on(&"level_loaded", func(module: String):
	if module == "207tel":
		give_conversation("CommM", "my_quest"))
```

or start it from anywhere with `start_conversation("my_quest", owner)`.

## What its lines do and test

The game's conversations run its scripts with `Kotor.act("name", ...)` and test them with `Kotor.cond("name", ...)`.
A mod's conversation does the same with names the mod gives:

```gdscript
add_conversation_check("quest_not_started", func(_params): return int(save_data().get("stage", 0)) == 0)
add_conversation_action("quest_take", func(_params, _owner):
	save_data()["stage"] = 1
	set_quest("my_quest", 10))
```

```
~ start
if Kotor.cond("quest_not_started", 0, 0, 0, 0, 0, "")
	=> offer

~ offer
Twi'lek: Could you help a friend of mine?
- I'll help. => take
- No. => END

~ take
$> Kotor.act("quest_take", 0, 0, 0, 0, 0, "")
Twi'lek: Thank you.
=> END
```

A mod's names are looked up before the game's, so pick ones of the mod's own (a prefix helps).

## A quest in the journal

```gdscript
add_quest("my_quest", "Medpacs for a Friend", {
	10: "A Twi'lek asked me for two medpacs.",
	20: "I gave him the medpacs.",
}, "Telos: Citadel Station")
set_quest("my_quest", 10)      # the journal shows the entry, as the game's own quests do
```

## A store

```gdscript
add_store("my_store", "Field Supplies", [
	{"resref": "g_i_medeqpmnt01", "infinite": true},     # never runs out
	"g_w_fraggren01",                                     # one of these
], 115, 50)                                               # sells at 115%, buys at 50%
add_conversation_action("store_open", func(_p, _owner): open_store("my_store"))
```
