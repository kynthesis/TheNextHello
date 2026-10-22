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

func _initialize() -> void:
	await process_frame
	phone = load("res://scenes/phone.tscn").instantiate()
	root.add_child(phone)
	phone.story.reset()
	phone.text_scale = 1.0
	phone.reduce_motion = false
	root.size = Vector2i(1280, 900)
	phone.sound_volume = 0.5
	phone._render()
	await settle()
	phone.banner_id = ""
	phone._refresh_overlay()
	await capture("home")
	check(phone.frame.find_child("NotesIcon", true, false).badge_count == 1, "new objective shows a numbered app bubble")
	await tap_icon("NotesIcon")
	check(phone.story.state.app == "Notes", "Notes is reachable from home")
	check(phone.story.state.node == "invite", "opening objectives does not advance story")
	await capture("notes")
	press("Continue in Lantern Quest  >")
	await settle()
	check(phone.story.state.app == "Lantern Quest", "objective links to the correct app")
	phone._open("Home")
	await settle()
	for icon: Node in phone.frame.find_children("NotesIcon", "Button", true, false):
		check(icon.badge_count == 0, "opening Notes clears bubbles on grid and dock")
	await swipe(Vector2(340, 540), Vector2(80, 540))
	check(phone.home_page == 1 and phone.story.state.app == "Home", "mouse swipe changes page without opening an app")
	await capture("home_page_two")
	await swipe(Vector2(80, 540), Vector2(340, 540), true)
	check(phone.home_page == 0, "touch swipe returns to first page")
	await tap_icon("MessagesIcon")
	check(phone.story.state.app == "Messages", "tapping an icon opens its app")
	await swipe(Vector2(205, 859), Vector2(205, 640))
	check(phone.story.state.app == "Home", "bottom mouse swipe returns Home")
	await swipe(Vector2(70, 42), Vector2(70, 210))
	check(phone.notification_center, "top swipe opens Notification Center")
	await capture("notifications")
	press("Lantern Quest\n01 / Party invite")
	await settle()
	check(phone.story.state.app == "Lantern Quest" and not phone.notification_center, "notification deep-links to app")
	check(phone.story.state.notifications[0].read, "opening app marks notification read")
	var count: int = phone.story.state.notifications.size()
	phone._open("Home")
	phone._open("Lantern Quest")
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
	check(phone.story.unread_count("Lantern Quest") == 0, "messages already displayed in the active app are read")
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
	phone._play_track(0)
	check(phone.player.playing, "music plays")
	phone._open("Messages")
	check(phone.player.playing, "music continues between apps")
	await settle()
	phone._scroll_bottom()
	await capture("messages")
	phone._toggle_music()
	check(not phone.player.playing, "music pauses")
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
	phone.text_scale = 2.0
	phone._open("Messages")
	await settle()
	fitted("200 percent text")
	await capture("large_text")
	for app: String in ["Home", "Notes"]:
		phone._open(app)
		await settle()
		fitted(app + " 200 percent text")
		await capture(app.to_lower() + "_large_text")
	phone._set_resolution(Vector2i(1280, 900))
	await settle()
	check(root.size == Vector2i(1280, 900), "resolution setting resizes window")
	phone.text_scale = 1.0
	phone.story.reset()
	phone._open("Home")
	phone.reduce_transparency = true
	phone._render()
	await settle()
	var glass_count := 0
	for panel: Node in phone.frame.find_children("*", "PanelContainer", true, false):
		if panel.material is ShaderMaterial:
			glass_count += 1
	check(glass_count == 0, "simplified surfaces disable paper texture")
	phone.reduce_transparency = false
	phone._render()
	await settle()
	glass_count = 0
	for panel: Node in phone.frame.find_children("*", "PanelContainer", true, false):
		if panel.material is ShaderMaterial:
			glass_count += 1
	check(glass_count >= 1, "home dock uses paper texture")
	phone.player.stop()
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
