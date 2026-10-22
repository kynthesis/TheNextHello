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
	await process_frame
	var model := await Story.create()
	await process_frame
	check(model.content.era.start == "2009-10-23", "opening is in 2009")
	check(model.characters.size() == 5, "all five characters have profiles")
	var ages := {"Asahi": 29, "Mizuki": 23, "Natsumi": 24, "Daichi": 27, "Misaki": 29}
	for name: String in ages:
		var person: Dictionary = model.characters[name]
		var born := Time.get_datetime_dict_from_datetime_string(person.birthday, false)
		var age := 2009 - int(born.year) - (1 if int(born.month) > 10 or (int(born.month) == 10 and int(born.day) > 23) else 0)
		check(age == ages[name] and person.age_at_opening == age, "birthday preserves established age: " + name)
		check(not person.zodiac.is_empty() and not person.hobbies.is_empty() and not person.favorites.is_empty(), "personality has usable profile details: " + name)
	await social_state()
	await conversation_migration()
	await full_paths()
	check(visited.size() == model.content.nodes.size(), "all authored nodes reachable")
	check(model.state.node == "invite", "exploration does not mutate original")
	check(model.text("invite.line.0").contains("Random matchmaking"), "opening establishes a chance encounter")
	for entry: Dictionary in model.state.log:
		check(entry.speaker != "mossbyte", "Daichi does not introduce the couple")
	check(not (await model.send()), "no send without draft")
	var delivery := await Story.create()
	var original_facts: Dictionary = delivery.state.facts.duplicate(true)
	delivery.advance_delivery()
	check(delivery.state.node == "invite" and delivery.state.facts == original_facts, "typing/delivery cannot advance narrative or facts")
	delivery.reveal_all()
	check(not delivery.delivery_pending(), "instant reveal completes only presentation")
	delivery.draft("invite.choice.0")
	(await delivery.send())
	check(delivery.state.log.any(func(entry: Dictionary) -> bool: return entry.get("delivery") == "Sent"), "committed outgoing reply starts Sent")
	check(delivery.save_to("user://test_delivery.json"), "save while an outgoing message awaits its read receipt")
	var resumed := await Story.create()
	check((await resumed.load_from("user://test_delivery.json")) and resumed.state == JSON.parse_string(JSON.stringify(delivery.state)), "pending delivery and Sent state restore exactly")
	resumed.advance_delivery()
	check(resumed.state.log.any(func(entry: Dictionary) -> bool: return entry.get("delivery") == "Read"), "read receipt is a presentation transition")
	check(resumed.state.node == "bridge" and resumed.state.consumed == delivery.state.consumed, "read receipt cannot replay a choice")
	resumed.reveal_all()
	var delivered_log: Array = resumed.state.log.duplicate(true)
	resumed.reveal_all()
	check(resumed.state.log == delivered_log, "reveal and revisit cannot duplicate messages")
	DirAccess.remove_absolute("user://test_delivery.json")
	var badges := await Story.create()
	check(badges.unread_count("Notes") == 1 and badges.unread_count("Messages") == 1, "opening records a message and internal Events progress")
	badges.mark_app_read("Notes")
	check(badges.unread_count("Notes") == 0 and badges.unread_count("Messages") == 1, "reading one app preserves other badges")
	badges.draft("invite.choice.0")
	(await badges.send())
	check(badges.unread_count("Messages") == 2, "unread bubble counts multiple events")
	check(badges.unread_count("Notes") == 1, "changed objective refreshes Notes bubble")
	badges.mark_app_read("Messages")
	badges.draft("bridge.choice.0")
	(await badges.send())
	check(badges.unread_count("Photos") == 1, "new screenshot flags Photos")
	badges.mark_app_read("Photos")
	badges.draft("first_dm.choice.0")
	(await badges.send())
	check(badges.unread_count("Photos") == 0, "unchanged photo does not reappear as new")
	badges.draft("night.choice.0")
	(await badges.send())
	check(badges.unread_count("Calendar") == 1, "choice-created commitment flags Calendar")
	badges.mark_app_read("Calendar")
	check(badges.unread_count("Calendar") == 0, "opening Calendar clears its updates")
	var original_log: Array = model.state.log.duplicate(true)
	model.draft("invite.choice.0")
	check(model.state.node == "invite" and model.state.log == original_log, "draft has no story effects")
	model.state.app = "Notes"
	model.state.scroll.Notes = 143
	check(model.save_to("user://test_save.json"), "save unanswered choice and unsent draft")
	var loaded := await Story.create()
	check((await loaded.load_from("user://test_save.json")), "load exact snapshot")
	check(loaded.state == JSON.parse_string(JSON.stringify(model.state)), "draft, app, scroll, log and facts round trip")
	check(loaded.state.notifications == model.state.notifications, "notification history round trips")
	check(loaded.unread_count("Notes") == model.unread_count("Notes"), "badge state survives saving and loading")
	check(loaded.journal() == model.journal(), "Notes objectives restore from saved story state")
	check((await loaded.send()), "restored draft sends")
	check(not (await loaded.send()), "second send cannot duplicate transition")
	check(loaded.state.notifications.size() == 2, "one notification per incoming conversation update")
	check(loaded.save_to("user://test_save.json"), "second save makes backup")
	var corrupt := FileAccess.open("user://test_save.json", FileAccess.WRITE)
	corrupt.store_string("broken")
	corrupt.close()
	check((await loaded.load_from("user://test_save.json")), "corrupt primary recovers backup")
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
	check((await loaded.load_from("user://test_legacy.json")), "earlier prototype save still loads")
	check(loaded.state.log.back().speaker == "asahi" and loaded.state.facts.commitment == "Call with Mizuki", "saved cast references migrate")
	check(loaded.state.notifications.is_empty(), "older saves do not recreate obsolete mission notifications")
	check(loaded.unread_count("Notes") == 1, "earlier save highlights the Notes app")
	for old: String in ["Lantern Quest", "Games", "Desk", "Work", "Gallery", "Resonance", "Moments", "Vista", "Loop", "Bookmark"]:
		var old_save: Dictionary = model.state.duplicate(true)
		old_save.app = old
		old_save.scroll = {"Lantern Quest": 42, "Desk": 81, "Gallery": 12, "Bookmark": 90}
		old_save.app_updates = {"Gallery": ["invite"], "Desk": ["invite"]}
		old_save.notifications[0].app = "Lantern Quest"
		var old_file := FileAccess.open("user://test_legacy.json", FileAccess.WRITE)
		old_file.store_string(JSON.stringify(old_save))
		old_file.close()
		check((await loaded.load_from("user://test_legacy.json")), "old app save loads: " + old)
		check(loaded.state.app == ("Home" if old in Story.RETIRED_APPS else Story.APP_ALIASES[old]), "old app redirects safely: " + old)
		check(loaded.state.node == model.state.node and loaded.state.draft == model.state.draft and loaded.state.log == model.state.log, "app migration preserves story and draft")
		check(loaded.state.scroll.Messages == (81 if old == "Desk" else 42) and not loaded.state.scroll.has("Games") and not loaded.state.scroll.has("Work") and loaded.state.scroll.Photos == 12 and not loaded.state.scroll.has("Bookmark"), "scroll IDs migrate")
		check(loaded.state.notifications[0].app == "Messages" and loaded.unread_count("Photos") == 1, "notification and badge links migrate")
	DirAccess.remove_absolute("user://test_legacy.json")
	var path_events: Array = []
	for route in range(3):
		var branch := await Story.create()
		for id: String in ["invite.choice.0", "bridge.choice.0", "first_dm.choice.0", "night.choice." + str(route)]:
			check(branch.draft(id) and (await branch.send()), "route selection " + id)
		check((await branch.later()), "route's immediate event")
		check(branch.draft(str(branch.state.node) + ".choice.0") and (await branch.send()), "route event played")
		check((await branch.later()), "later callback played")
		while not branch.state.facts.has("available_events") and branch.current().has("later"):
			check((await branch.later()), "explicit time gate before opening callback")
		path_events.append(branch.state.facts.available_events)
		check(branch.current().has("later"), "opening route continues into its later playable consequence")
		check(not branch.journal().complete, "Notes points onward after the opening")
		for entry: Dictionary in branch.journal().completed:
			check(entry.id in branch.state.consumed, "Notes only lists events in this run")
	check(path_events[0] != path_events[1] and path_events[1] != path_events[2] and path_events[0] != path_events[2], "three routes unlock different later actions")
	for suffix: String in ["", ".bak", ".tmp"]:
		if FileAccess.file_exists("user://test_save.json" + suffix):
			DirAccess.remove_absolute("user://test_save.json" + suffix)
	await process_frame
	await process_frame
	print("Story tests: %d passed, %d failed; %d nodes covered" % [passed, failed, visited.size()])
	quit(1 if failed else 0)

func full_paths() -> void:
	var paths: Array = JSON.parse_string(FileAccess.get_file_as_string("res://tests/story_paths.json"))
	var endings: Dictionary = {}
	for fixture: Dictionary in paths:
		var run := await Story.create()
		visited[run.state.node] = true
		for step: String in fixture.steps:
			var previous_date: String = run.current().timestamp.substr(0, 11)
			if step == "later":
				check((await run.later()), fixture.name + " explicit time transition")
			else:
				check(run.draft(step) and (await run.send()), fixture.name + " choice " + step)
				check(run.current().timestamp.substr(0, 11) == previous_date, "sending cannot advance to another story date")
			visited[run.state.node] = true
			check(run.valid(run.state), "reachable state is saveable")
		await process_frame
		check(run.state.node == fixture.node, "runtime matches content audit: " + fixture.name)
		check(run.current().app in Story.APPS, "scene uses an essential app")
		check(run.content.strings.has(run.current().objective), "scene objective has a stable ID")
		if fixture.has("ending"):
			check(run.state.facts.ending == fixture.ending and run.journal().complete, "ending resolves and Notes completes")
			endings[fixture.ending] = true
			if run.state.facts.get("first_meeting", false):
				check(run.state.facts.meeting_plan == "completed", "later uncertainty or separation cannot erase a completed meeting")
	check(endings.size() == 8, "all eight endings play through the Godot runtime")

func social_state() -> void:
	var run := await Story.create()
	check(run.pending_requests().is_empty(), "no request before meeting")
	check(not run.answer_request("Mizuki", true), "cannot accept an unearned request")
	run.draft("invite.choice.0"); (await run.send())
	run.draft("bridge.choice.0"); (await run.send())
	check(run.pending_requests() == ["Mizuki"], "encounter creates pending friend request")
	var before: Dictionary = run.state.facts.duplicate(true)
	check(run.answer_request("Mizuki", true) and not run.answer_request("Mizuki", true), "request acceptance is idempotent")
	check(run.state.facts == before and run.state.node == "first_dm", "social acceptance preserves narrative state")
	check(run.post_status("My first status") and not run.post_status("   ") and not run.post_status("x".repeat(281)), "status validates blank and overlong text")
	check(run.add_comment("friend_Natsumi", "Nice print.") and not run.add_comment("friend_Natsumi", ""), "comments validate content")
	run.social().shares.append("friend_Natsumi")
	check(run.save_to("user://test_social.json"), "social state saves")
	var loaded := await Story.create()
	check((await loaded.load_from("user://test_social.json")) and loaded.social() == run.social(), "requests, posts, comments and shares restore")
	var malformed: Dictionary = run.state.duplicate(true)
	malformed.social.posts = [42]
	check(not run.valid(malformed), "malformed social posts cannot replace a valid save")
	run.state.erase("social")
	check(run.save_to("user://test_social.json") and (await loaded.load_from("user://test_social.json")) and loaded.social().friends == ["Natsumi"], "older saves gain safe social defaults")
	var declined := await Story.create()
	declined.draft("invite.choice.0"); (await declined.send())
	declined.draft("bridge.choice.0"); (await declined.send())
	check(declined.answer_request("Mizuki", false) and declined.pending_requests().is_empty() and "Mizuki" not in declined.social().friends, "declining a request keeps it out of Friends")
	for suffix: String in ["", ".bak", ".tmp"]: DirAccess.remove_absolute("user://test_social.json" + suffix)

func conversation_migration() -> void:
	var paths: Array = JSON.parse_string(FileAccess.get_file_as_string("res://tests/story_paths.json"))
	for target: String in ["party_evening", "work_decision"]:
		var run := await Story.create()
		for fixture: Dictionary in paths:
			if fixture.name != "node:" + target: continue
			for step: String in fixture.steps:
				if step == "later": await run.later()
				else:
					run.draft(step)
					await run.send()
			break
		var legacy: Dictionary = run.state.duplicate(true)
		legacy.app = "Games" if target == "party_evening" else "Work"
		for entry: Dictionary in legacy.log:
			if entry.thread in ["Mizuki", "After Hours"] and entry.text.get_slice(".", 0) in ["invite", "bridge", "splash", "guild_plan", "guild_event", "guild_guide", "party_evening"]:
				entry.app = "Games"
				entry.thread = "Lantern Quest"
			elif entry.thread == "Hoshino Studio": entry.app = "Work"
		legacy.notifications.append({"id": target, "app": legacy.app, "text": target + ".title", "read": false})
		var file := FileAccess.open("user://test_rehomed.json", FileAccess.WRITE)
		file.store_string(JSON.stringify(legacy))
		file.close()
		var loaded := await Story.create()
		check(await loaded.load_from("user://test_rehomed.json"), "removed conversation screen migrates: " + target)
		check(loaded.state.app == "Messages" and loaded.state.node == target and loaded.state.facts == run.state.facts and loaded.state.consumed == run.state.consumed, "migration preserves narrative position and consequences: " + target)
		check(loaded.state.log == run.state.log, "migration restores every transcript to its DM/group: " + target)
		check(loaded.state.notifications.all(func(notice: Dictionary) -> bool: return notice.kind == "message"), "mission notices are discarded: " + target)
		var thread := "After Hours" if target == "party_evening" else "Hoshino Studio"
		check(thread in loaded.threads() and loaded.visible_log("Messages", "Lantern Quest").is_empty(), "removed categories do not reappear as threads: " + target)
	DirAccess.remove_absolute("user://test_rehomed.json")
