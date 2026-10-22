extends SceneTree

var failed := 0
var passed := 0
var phone: Control

func check(condition: bool, label: String) -> void:
	if condition:
		passed += 1
	else:
		failed += 1
		push_error("FAIL: " + label)

func settle() -> void:
	for i in range(16):
		await process_frame

func capture(name: String) -> void:
	await settle()
	await RenderingServer.frame_post_draw
	root.get_texture().get_image().save_png("res://.local/" + name + ".png")

func press(text: String) -> void:
	for button: Node in phone.frame.find_children("*", "Button", true, false):
		if button.text == text:
			button.pressed.emit()
			return
	check(false, "button present: " + text)

func swipe(start: Vector2, finish: Vector2, touch := false) -> void:
	var a: Vector2 = phone.frame.get_global_transform() * start
	var b: Vector2 = phone.frame.get_global_transform() * finish
	if touch:
		var down := InputEventScreenTouch.new()
		down.position = a
		down.pressed = true
		Input.parse_input_event(down)
		var drag := InputEventScreenDrag.new()
		drag.position = b
		drag.relative = b - a
		Input.parse_input_event(drag)
		var up := InputEventScreenTouch.new()
		up.position = b
		Input.parse_input_event(up)
	else:
		var down := InputEventMouseButton.new()
		down.button_index = MOUSE_BUTTON_LEFT
		down.position = a
		down.pressed = true
		Input.parse_input_event(down)
		var drag := InputEventMouseMotion.new()
		drag.button_mask = MOUSE_BUTTON_MASK_LEFT
		drag.position = b
		drag.relative = b - a
		Input.parse_input_event(drag)
		var up := InputEventMouseButton.new()
		up.button_index = MOUSE_BUTTON_LEFT
		up.position = b
		Input.parse_input_event(up)
	await settle()

func tap_icon(node_name: String) -> void:
	var icon: Control = phone.frame.find_child(node_name, true, false)
	check(icon != null, "home icon exists: " + node_name)
	if icon == null:
		return
	var point := icon.get_global_transform() * (icon.size / 2)
	var down := InputEventMouseButton.new()
	down.button_index = MOUSE_BUTTON_LEFT
	down.position = point
	down.pressed = true
	Input.parse_input_event(down)
	var up := InputEventMouseButton.new()
	up.button_index = MOUSE_BUTTON_LEFT
	up.position = point
	Input.parse_input_event(up)
	await settle()

func fitted(label: String) -> void:
	var visual: Vector2 = phone.frame.size * phone.frame.scale
	check(is_equal_approx(visual.x / visual.y, 414.0 / 896.0), label + " fixed phone ratio")
	check(phone.frame.position.x >= 0 and phone.frame.position.y >= 0 and phone.frame.position.x + visual.x <= root.size.x + 1 and phone.frame.position.y + visual.y <= root.size.y + 1, label + " complete device fits")
	check(phone.screen.size.is_equal_approx(Vector2(394, 876)), label + " app canvas stays fixed")
	check(phone.body.size.x <= phone.scroller.size.x + 1, label + " content fits without horizontal clipping")
	check(phone.ui.get_child_count() == 1 and phone.ui.get_child(0) == phone.frame, label + " only the phone is presented")

func has_label(copy: String) -> bool:
	for label: Node in phone.body.find_children("*", "Label", true, false):
		if label.text == copy: return true
	return false

func load_scene_path(node: String) -> void:
	var paths: Array = JSON.parse_string(FileAccess.get_file_as_string("res://tests/story_paths.json"))
	for fixture: Dictionary in paths:
		if fixture.name != "node:" + node: continue
		var run: RefCounted = phone.Story.new()
		for step: String in fixture.steps:
			if step == "later": run.later()
			else: run.draft(step); run.send()
		phone.story.state = run.state
		phone.story.reveal_all()
		phone._open(phone.story.current().app)
		await settle()
		return
	check(false, "fixture exists: " + node)

func _initialize() -> void:
	await process_frame
	phone = load("res://scenes/phone.tscn").instantiate()
	root.add_child(phone)
	var legacy_settings := ConfigFile.new()
	legacy_settings.load("user://settings.cfg")
	legacy_settings.set_value("reading", "scale", 2.0)
	legacy_settings.save("user://settings.cfg")
	phone._load_settings()
	check(phone._theme().default_font_size == 16, "old large-text preference cannot change standard text size")
	phone._save_settings()
	legacy_settings.clear()
	legacy_settings.load("user://settings.cfg")
	check(not legacy_settings.has_section_key("reading", "scale"), "saving settings removes obsolete text-scale preference")
	phone.story.reset()
	phone.reduce_motion = false
	phone.instant_messages = true
	root.size = Vector2i(1280, 900)
	phone.sound_volume = 0.5
	phone._render()
	await settle()
	root.size = Vector2i(414, 896)
	await settle()
	fitted("phone-sized window")
	check(phone.frame.position.is_zero_approx() and phone.frame.scale.is_equal_approx(Vector2.ONE), "default portrait window is filled by the phone")
	await capture("asahi_phone")
	root.size = Vector2i(1280, 900)
	await settle()
	phone.banner_id = ""
	phone._refresh_overlay()
	await capture("home")
	var launcher_apps: Array = []
	for icon: Node in phone.body.find_children("*", "Button", true, false):
		if icon.get_script() == phone.AppIcon:
			launcher_apps.append(icon.app)
	check(launcher_apps == ["Messages", "Games", "Work", "Photos", "Calendar", "Notes", "Settings"], "launcher contains exactly seven clearly named apps")
	phone._open("Resonance")
	check(phone.story.state.app == "Home", "retired apps cannot be opened")
	check(phone.frame.find_child("NotesIcon", true, false).badge_count == 1, "new objective shows a numbered app bubble")
	await tap_icon("NotesIcon")
	check(phone.story.state.app == "Notes", "Notes is reachable from home")
	check(phone.story.state.node == "invite", "opening objectives does not advance story")
	await capture("notes")
	press("Continue in Games  >")
	await settle()
	check(phone.story.state.app == "Games", "objective links to the correct app")
	phone._open("Home")
	await settle()
	for icon: Node in phone.frame.find_children("NotesIcon", "Button", true, false):
		check(icon.badge_count == 0, "opening Notes clears its app badge")
	await swipe(Vector2(340, 540), Vector2(80, 540))
	check(phone.story.state.app == "Home", "horizontal swipe stays on the single home page")
	await swipe(Vector2(80, 540), Vector2(340, 540), true)
	check(phone.story.state.app == "Home", "touch swipe stays on the single home page")
	await tap_icon("MessagesIcon")
	check(phone.story.state.app == "Messages", "tapping an icon opens its app")
	await swipe(Vector2(205, 859), Vector2(205, 640))
	check(phone.story.state.app == "Home", "bottom mouse swipe returns Home")
	await swipe(Vector2(70, 42), Vector2(70, 210))
	check(phone.notification_center, "top swipe opens Notification Center")
	await capture("notifications")
	press("Games\n01 / A chance encounter")
	await settle()
	check(phone.story.state.app == "Games" and not phone.notification_center, "notification deep-links to app")
	check(phone.story.state.notifications[0].read, "opening app marks notification read")
	var count: int = phone.story.state.notifications.size()
	phone._open("Home")
	phone._open("Games")
	await settle()
	check(phone.story.state.notifications.size() == count, "reopening app cannot replay notifications")
	var reply: String = phone.story.text(phone.story.choices()[0].text)
	press(reply)
	await settle()
	check(phone.story.state.node == "invite", "draft does not send")
	await capture("draft")
	press("Send reply  >")
	await settle()
	check(phone.story.state.node == "bridge", "Send advances story")
	check(phone.story.unread_count("Notes") == 1, "next objective restores Notes bubble")
	check(phone.story.unread_count("Games") == 0, "messages already displayed in the active app are read")
	check(phone.story.state.notifications.size() == 2, "one saved notification per new event")
	await create_timer(0.25).timeout
	check(phone.banner_id == "bridge", "new event shows notification banner")
	check(phone.sfx.stream == phone.sounds.received, "incoming event uses received sound")
	await capture("banner")
	phone._open("Settings")
	await settle()
	var old_scroll: int = phone.scroller.scroll_vertical
	await swipe(Vector2(220, 650), Vector2(220, 280))
	check(phone.scroller.scroll_vertical > old_scroll, "mouse drag scrolls app")
	await swipe(Vector2(205, 859), Vector2(205, 640), true)
	check(phone.story.state.app == "Home", "bottom touch swipe returns Home")
	for app: String in phone.Story.APPS:
		phone._open(app)
		await settle()
		check(phone.body.get_child_count() > 0, app + " renders content")
	phone._open("Messages")
	await settle()
	phone._scroll_bottom()
	await capture("messages")
	phone.sfx.stop()
	phone.sound_volume = 0
	phone._play_sound("received")
	check(not phone.sfx.playing, "interface sound volume zero mutes notification sounds")
	phone.sound_volume = 0.55
	phone.reduce_motion = true
	phone._open("Home")
	check(phone.screen.scale == Vector2.ONE, "reduced motion skips transitions")
	for resolution: Vector2i in [Vector2i(1280, 720), Vector2i(1920, 1080), Vector2i(2560, 1440), Vector2i(3440, 1440), Vector2i(360, 800)]:
		root.size = resolution
		await settle()
		fitted(str(resolution))
	await capture("portrait")
	for app: String in ["Messages", "Home", "Notes"]:
		phone._open(app)
		await settle()
		fitted(app + " standard text")
	phone._set_resolution(Vector2i(1280, 900))
	await settle()
	check(root.size == Vector2i(1280, 900), "resolution setting resizes window")
	phone.story.reset()
	phone._open("Home")
	# Four contacts are distinct threads; choosing history never progresses the story.
	await load_scene_path("natsumi_invite")
	check(phone._thread() == "Natsumi", "current contact opens the correct thread")
	press("Conversations")
	await settle()
	press("Mizuki")
	await settle()
	check(phone._thread() == "Mizuki" and phone.story.state.node == "natsumi_invite", "thread navigation preserves story position")
	check(not has_label(phone.story.text("natsumi_invite.line.0")), "another contact's messages cannot leak into Mizuki's thread")
	for ending_node: String in ["end_together", "end_distance", "end_friendship", "end_goodbye", "end_unsaid", "end_burnout", "end_open", "end_secret"]:
		await load_scene_path(ending_node)
		check(has_label("STORY COMPLETE"), "ending renders its completion state: " + ending_node)
		fitted(ending_node)
	phone._scroll_bottom()
	await capture("secret_ending")
	# Exercise actual timed presentation separately from instant-message smoke coverage.
	phone.instant_messages = false
	phone.reduce_motion = false
	phone._restart()
	phone._open("Games")
	await settle()
	phone.delivery_timer.stop()
	check(is_instance_valid(phone.typing_label), "incoming typing indicator is visible")
	var dots_before: String = phone.typing_label.text
	await create_timer(0.30).timeout
	check(phone.typing_label.text != dots_before, "typing dots animate")
	await capture("incoming_typing")
	phone._show_messages()
	phone._draft("invite.choice.0")
	await process_frame
	await create_timer(0.10).timeout
	var preview: Label = phone.body.find_child("DraftText", true, false)
	check(preview != null and preview.visible_characters > 0 and preview.visible_characters < preview.text.length(), "Asahi's draft visibly types character by character")
	check(phone.story.state.node == "invite" and phone.draft_typing, "POV typing never sends a reply")
	check(phone.body.find_child("SendDraft", true, false).disabled, "Send waits for typing or explicit skip")
	await capture("asahi_typing")
	await phone.draft_tween.finished
	check(not phone.draft_typing and not phone.body.find_child("SendDraft", true, false).disabled, "natural composition completion enables Send")
	check(preview.text == phone.story.text("invite.reply.0") and preview.visible_characters == -1, "typing pauses preserve the complete selected reply")
	check(phone.story.state.node == "invite" and phone.story.state.draft == "invite.choice.0", "finishing composition leaves the reply unsent")
	phone._draft("invite.choice.0")
	await process_frame
	phone._finish_typing()
	phone._send()
	await settle()
	phone.delivery_timer.stop()
	check(has_label("Sent"), "committed message displays Sent")
	await capture("message_sent")
	phone._delivery_tick()
	await settle()
	phone.delivery_timer.stop()
	check(has_label("Read") and phone.story.state.node == "bridge", "read receipt changes presentation, not narrative position")
	await capture("message_read")
	var consumed_before: Array = phone.story.state.consumed.duplicate()
	phone._show_messages()
	check(phone.story.state.consumed == consumed_before, "skip typing cannot commit another choice")
	phone._draft("bridge.choice.0")
	await process_frame
	phone._open("Home")
	await settle()
	check(phone.story.state.node == "bridge" and phone.story.state.draft == "bridge.choice.0" and not phone.draft_typing, "leaving mid-composition preserves the unsent draft")
	phone.instant_messages = true
	phone._open("Games")
	await settle()
	check(phone.story.state.node == "bridge", "returning to a draft never auto-sends it")
	var inspector: Node = root.get_node_or_null("MCPGameInspector")
	if inspector != null and inspector._error_log != null:
		var runtime_errors: Dictionary = inspector._error_log.poll(0, false)
		check(runtime_errors.count == 0, "no runtime or shader errors during UI suite")
	DirAccess.remove_absolute("user://autosave.json")
	DirAccess.remove_absolute("user://autosave.json.bak")
	print("Phone tests: %d passed, %d failed" % [passed, failed])
	phone.queue_free()
	await process_frame
	quit(1 if failed else 0)
