extends SceneTree

const Story := preload("res://scripts/story.gd")
var passed := 0
var failed := 0
var visited: Dictionary = {}

func check(condition: bool, label: String) -> void:
	if condition:
		passed += 1
	else:
		failed += 1
		push_error("FAIL: " + label)

func _initialize() -> void:
	var model := Story.new()
	walk(model)
	check(visited.size() == model.content.nodes.size(), "all authored nodes reachable")
	check(model.state.node == "invite", "exploration does not mutate original")
	check(not model.send(), "no send without draft")
	var badges := Story.new()
	check(badges.unread_count("Notes") == 1 and badges.unread_count("Lantern Quest") == 1, "opening highlights objectives and game invitation")
	badges.mark_app_read("Notes")
	check(badges.unread_count("Notes") == 0 and badges.unread_count("Lantern Quest") == 1, "reading one app preserves other badges")
	badges.draft("invite.choice.0")
	badges.send()
	check(badges.unread_count("Lantern Quest") == 2, "unread bubble counts multiple events")
	check(badges.unread_count("Notes") == 1, "changed objective refreshes Notes bubble")
	badges.mark_app_read("Lantern Quest")
	badges.draft("bridge.choice.0")
	badges.send()
	check(badges.unread_count("Gallery") == 1, "new screenshot flags Gallery")
	badges.mark_app_read("Gallery")
	badges.draft("first_dm.choice.0")
	badges.send()
	check(badges.unread_count("Gallery") == 0, "unchanged photo does not reappear as new")
	badges.draft("night.choice.0")
	badges.send()
	check(badges.unread_count("Calendar") == 1, "choice-created commitment flags Calendar")
	badges.mark_app_read("Calendar")
	check(badges.unread_count("Calendar") == 0, "opening Calendar clears its updates")
	var original_log: Array = model.state.log.duplicate(true)
	model.draft("invite.choice.0")
	check(model.state.node == "invite" and model.state.log == original_log, "draft has no story effects")
	model.state.app = "Notes"
	model.state.scroll.Notes = 143
	check(model.save_to("user://test_save.json"), "save unanswered choice and unsent draft")
	var loaded := Story.new()
	check(loaded.load_from("user://test_save.json"), "load exact snapshot")
	check(loaded.state == JSON.parse_string(JSON.stringify(model.state)), "draft, app, scroll, log and facts round trip")
	check(loaded.state.notifications == model.state.notifications, "notification history round trips")
	check(loaded.unread_count("Notes") == model.unread_count("Notes"), "badge state survives saving and loading")
	check(loaded.journal() == model.journal(), "Notes objectives restore from saved story state")
	check(loaded.send(), "restored draft sends")
	check(not loaded.send(), "second send cannot duplicate transition")
	check(loaded.state.notifications.size() == 2, "one notification per consumed event")
	check(loaded.save_to("user://test_save.json"), "second save makes backup")
	var corrupt := FileAccess.open("user://test_save.json", FileAccess.WRITE)
	corrupt.store_string("broken")
	corrupt.close()
	check(loaded.load_from("user://test_save.json"), "corrupt primary recovers backup")
	check(loaded.state == JSON.parse_string(JSON.stringify(model.state)), "backup retains previous exact position")
	var bad: Dictionary = model.state.duplicate(true)
	bad.version = 999
	check(not model.valid(bad), "future schema refused")
	bad = model.state.duplicate(true)
	bad.node = "missing"
	check(not model.valid(bad), "unknown node refused")
	bad = model.state.duplicate(true)
	bad.draft = "wrong_node.choice"
	check(not model.valid(bad), "invalid draft refused")
	bad = model.state.duplicate(true)
	bad.notifications = [{"id": "invite", "text": "invite.title", "app": "NotAnApp", "read": false}]
	check(not model.valid(bad), "malformed notification refused")
	var legacy: Dictionary = model.state.duplicate(true)
	legacy.erase("notifications")
	legacy.erase("app_updates")
	legacy.log.append({"speaker": "haru", "text": "first_dm.reply.0"})
	legacy.facts.commitment = "Call with Yui"
	var legacy_file := FileAccess.open("user://test_legacy.json", FileAccess.WRITE)
	legacy_file.store_string(JSON.stringify(legacy))
	legacy_file.close()
	check(loaded.load_from("user://test_legacy.json"), "earlier prototype save still loads")
	check(loaded.state.log.back().speaker == "asahi" and loaded.state.facts.commitment == "Call with Mizuki", "saved cast references migrate")
	check(loaded.state.notifications.size() == 1, "earlier save receives current notification once")
	check(loaded.unread_count("Notes") == 1, "earlier save highlights the Notes app")
	DirAccess.remove_absolute("user://test_legacy.json")
	var path_events: Array = []
	for route in range(3):
		var branch := Story.new()
		for id: String in ["invite.choice.0", "bridge.choice.0", "first_dm.choice.0", "night.choice." + str(route)]:
			check(branch.draft(id) and branch.send(), "route selection " + id)
		check(branch.later(), "route's immediate event")
		check(branch.draft(str(branch.state.node) + ".choice.0") and branch.send(), "route event played")
		check(branch.later(), "later callback played")
		path_events.append(branch.state.facts.available_events)
		check(branch.choices().is_empty() and not branch.current().has("later"), "route terminates cleanly")
		check(branch.journal().complete, "Notes marks the opening complete")
		for entry: Dictionary in branch.journal().completed:
			check(entry.id in branch.state.consumed, "Notes only lists events in this run")
	check(path_events[0] != path_events[1] and path_events[1] != path_events[2] and path_events[0] != path_events[2], "three routes unlock different later actions")
	for suffix: String in ["", ".bak", ".tmp"]:
		if FileAccess.file_exists("user://test_save.json" + suffix):
			DirAccess.remove_absolute("user://test_save.json" + suffix)
	print("Story tests: %d passed, %d failed; %d nodes covered" % [passed, failed, visited.size()])
	quit(1 if failed else 0)

func walk(model: RefCounted) -> void:
	visited[model.state.node] = true
	var journal: Dictionary = model.journal()
	check(journal.objective != "" and journal.app == model.current().app, "every node has actionable objective guidance")
	check(model.content.strings.has(model.current().objective), "objective has a stable string ID")
	for entry: Dictionary in model.current().get("lines", []):
		check(model.content.strings.has(entry.text), "localized line " + entry.text)
	for choice: Dictionary in model.choices():
		check(model.content.nodes.has(choice.to), "valid target " + choice.to)
		var child := Story.new()
		child.state = model.state.duplicate(true)
		check(child.draft(choice.id) and child.send(), "choice executes " + choice.id)
		check(child.valid(child.state), "result is serializable valid state")
		if not visited.has(child.state.node):
			walk(child)
	if model.current().has("later"):
		var child := Story.new()
		child.state = model.state.duplicate(true)
		check(child.later(), "day transition")
		if not visited.has(child.state.node):
			walk(child)
