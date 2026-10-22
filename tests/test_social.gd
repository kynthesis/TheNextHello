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
	check(icon != null, "section tile exists: " + node_name)
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
	check(phone.frame.size.is_equal_approx(Vector2(414, 896)) and phone.frame.scale.x == phone.frame.scale.y, label + " portrait mobile app stays proportional")
	check(phone.frame.find_child("HomeIndicator", true, false) == null and phone.frame.name == "SocialNetwork", label + " no phone shell or gesture bar")
	check(phone.body.size.x <= phone.scroller.size.x + 1, label + " content fits without horizontal clipping")
	check(phone.scroller.size.y > 120, label + " story has usable reading area")
	check(phone.frame.find_child("SiteHeader", true, false).size.y < 90, label + " compact header stays readable")

func has_label(copy: String) -> bool:
	for label: Node in phone.body.find_children("*", "Label", true, false):
		if label.text == copy: return true
	return false

func load_scene_path(node: String) -> void:
	var paths: Array = JSON.parse_string(FileAccess.get_file_as_string("res://tests/story_paths.json"))
	for fixture: Dictionary in paths:
		if fixture.name != "node:" + node: continue
		var run: RefCounted = await phone.Story.create()
		for step: String in fixture.steps:
			if step == "later": (await run.later())
			else: run.draft(step); (await run.send())
		phone.story = run
		phone.story.reveal_all()
		phone._open(phone.story.current().app)
		await settle()
		return
	check(false, "fixture exists: " + node)

func _initialize() -> void:
	await process_frame
	phone = load("res://scenes/social.tscn").instantiate()
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
	(await phone.story.reset())
	phone.reduce_motion = false
	phone.instant_messages = true
	root.size = Vector2i(414, 896)
	phone.sound_volume = 0.5
	phone._render()
	await settle()
	phone._open("Home")
	await settle()
	fitted("desktop")
	check(phone.frame.find_child("SectionGrid", true, false) != null, "Home offers a familiar section grid")
	check(phone.frame.find_child("ChatSidebar", true, false) == null, "mobile layout never adds desktop sidebars")
	var tiles: Array = phone.body.find_children("*", "Button", true, false).filter(func(button: Node) -> bool: return button.get_script() == phone.AppIcon)
	check(tiles.size() == 7, "exactly seven main sections")
	check(phone.frame.find_child("SiteLogo", true, false).text == "facebook", "requested Facebook wordmark is displayed")
	check(phone.frame.find_child("Notifications", true, false) != null, "Home has the classic Notifications footer")
	var search: LineEdit = phone.body.find_child("FriendSearch", true, false)
	search.text_submitted.emit("natsumi")
	await settle()
	check(phone.friend_profile == "Natsumi", "friend search opens an accepted friend's profile")
	phone._open("Home")
	await settle()
	search = phone.body.find_child("FriendSearch", true, false)
	search.text_submitted.emit("mizuki")
	await settle()
	check(phone.friend_profile == "" and phone.status == "No friends found for that name.", "friend search cannot reveal a future contact")
	phone._open("Home")
	await settle()
	check(phone.frame.find_child("MusicLink", true, false) != null, "music is a header utility")
	var music_node_before: String = phone.story.state.node
	phone._show_music()
	await settle()
	fitted("music")
	check(phone.music.available().size() == 3, "music library initially shows three songs")
	check(phone.frame.find_child("Track_your_coat", true, false) == null, "locked song titles are hidden")
	press("Version B")
	await settle()
	check(phone.music.options().variant == "b" and phone.music.options().playing, "version button starts selected recording")
	press("Pause")
	await settle()
	check(phone.music.player.stream_paused, "pause control pauses audio")
	var music_volume: HSlider = phone.frame.find_child("MusicVolume", true, false)
	music_volume.value = 0.3
	check(is_equal_approx(phone.music.volume, 0.3) and is_equal_approx(phone.sound_volume, 0.5), "music volume is independent of interface sounds")
	check(phone.story.state.node == music_node_before, "music controls never advance the story")
	await capture("social_music")
	press("Back to story")
	await settle()
	check(not phone.music_view and phone.frame.find_child("SectionGrid", true, false) != null, "closing music returns to previous screen")
	phone._show_music()
	await settle()
	phone.story.state.scroll.Home = 123
	phone._open("Settings")
	await settle()
	check(phone.story.state.scroll.Home == 123, "leaving music for another utility preserves story scroll")
	phone._open("Home")
	await settle()
	await capture("social_home")
	await tap_icon("HomeTile")
	check(phone.feed_view and has_label("Tokyo. Rain again. At least the view is doing something with it."), "news feed opens from its tile")
	check(not has_label("Mizuki") and has_label("Natsumi"), "feed shows an existing friend without revealing future contacts")
	check(phone.story.state.node == "invite", "browsing feed does not advance story")
	press("Like")
	await settle()
	check("feed_window" in phone.story.state.likes, "feed reactions persist in run state")
	press("Comment")
	await settle()
	check(has_label("Still haven't bought a plant for this window."), "feed comment expands without sending a reply")
	await capture("social_feed")
	phone._open("Home")
	await settle()
	await tap_icon("ProfileTile")
	check(has_label("Birthday: 1980-05-09 / Taurus"), "Asahi profile shows the authored birthday and sign")
	check(not has_label(phone.story.characters.Asahi.private_want), "profile never exposes private writer notes")
	check(phone.profile_view and has_label("Tachibana Asahi\nasahi / Tokyo, Japan"), "profile belongs to Asahi")
	phone._open("Home")
	await settle()
	await tap_icon("FriendsTile")
	check(phone.friends_view and phone.story.social().friends == ["Natsumi"], "Friends starts with Asahi's existing friend")
	press("View Natsumi's profile")
	await settle()
	check(phone.friend_profile == "Natsumi", "Friends opens a real friend profile")
	press("View photos")
	await settle()
	check(has_label("PHOTOS / NATSUMI"), "friend photos live on the friend profile")
	press("Profile")
	await settle()
	press("Share")
	await settle()
	check("friend_Natsumi" in phone.story.social().shares, "Share saves an approved friend post")
	press("Comment")
	await settle()
	var comment: TextEdit = phone.body.find_child("CommentInput", true, false)
	comment.text = "Keep the crooked print."
	comment.text_changed.emit()
	press("Post comment")
	await settle()
	check(phone.story.social().comments.friend_Natsumi == ["Keep the crooked print."], "comments are authored by the player and saved")
	phone._open_profile()
	await settle()
	var status_input: TextEdit = phone.body.find_child("StatusInput", true, false)
	status_input.text = "Rain again. Good evening for a game."
	status_input.text_changed.emit()
	press("Post status")
	await settle()
	check(phone.story.social().posts.back().copy == "Rain again. Good evening for a game.", "Profile publishes a status")
	phone._show_feed()
	await settle()
	check(has_label("Rain again. Good evening for a game."), "posted status appears in News Feed")
	phone._open("Photos")
	await settle()
	check(not has_label("MIZUKI'S DESK"), "own Photos does not contain a friend's private work")
	await load_scene_path("first_dm")
	phone._show_requests()
	await settle()
	check(phone.story.pending_requests() == ["Mizuki"], "Mizuki requests friendship after the chance encounter")
	press("Accept Mizuki")
	await settle()
	check("Mizuki" in phone.story.social().friends and phone.story.state.node == "first_dm", "accepting a request adds a friend without advancing story")
	(await phone.story.reset())
	phone._open("Calendar")
	await settle()
	press("Continue in Lantern Quest  >")
	await settle()
	check(phone.story.state.app == "Games", "notes link to the active story section")
	phone._show_notifications()
	await settle()
	await capture("social_notifications")
	press("Lantern Quest\n01 / A chance encounter")
	await settle()
	check(phone.story.state.app == "Games" and not phone.notification_center, "notification links to story section")
	var count: int = phone.story.state.notifications.size()
	phone._open("Home")
	phone._open("Games")
	await settle()
	check(phone.story.state.notifications.size() == count, "browsing cannot replay notifications")
	press(phone.story.text(phone.story.choices()[0].text))
	await settle()
	check(phone.story.state.node == "invite", "draft does not send")
	press("Send reply  >")
	await settle()
	check(phone.story.state.node == "bridge", "Send advances story")
	await create_timer(0.25).timeout
	check(phone.banner_id == "bridge", "new event shows notification banner")
	phone._open("Settings")
	await settle()
	var old_scroll: int = phone.scroller.scroll_vertical
	await swipe(Vector2(220, 650), Vector2(220, 280))
	check(phone.scroller.scroll_vertical > old_scroll, "mouse drag scrolls content")
	phone._open("Settings")
	await settle()
	phone.scroller.scroll_vertical = 0
	old_scroll = phone.scroller.scroll_vertical
	await swipe(Vector2(220, 650), Vector2(220, 280), true)
	check(phone.scroller.scroll_vertical > old_scroll, "touch drag scrolls mobile content")
	for app: String in phone.Story.APPS:
		phone._open(app)
		await settle()
		check(phone.body.get_child_count() > 0, app + " renders content")
	phone.sfx.stop()
	phone.sound_volume = 0
	phone._play_sound("received")
	check(not phone.sfx.playing, "interface volume zero mutes sounds")
	phone.sound_volume = 0.55
	phone.reduce_motion = true
	for resolution: Vector2i in [Vector2i(1280, 720), Vector2i(1920, 1080), Vector2i(3440, 1440), Vector2i(800, 700), Vector2i(360, 800)]:
		root.size = resolution
		phone._open("Home")
		await settle()
		fitted(str(resolution))
		phone._open("Games")
		await settle()
		fitted("chat " + str(resolution))
		if resolution.x == 360: await capture("social_narrow")
	phone._set_resolution(Vector2i(1120, 800))
	await settle()
	(await phone.story.reset())
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
	await load_scene_path("private_photo")
	phone._open("Photos")
	await settle()
	check(not has_label("MIZUKI'S DESK"), "private work draft never appears in own photos")
	phone._open("Messages")
	await settle()
	press("Shared attachments")
	await settle()
	check(has_label("MIZUKI'S DESK") and not phone._can_present(), "private attachments remain accessible in their DM without advancing delivery")
	press("Back to conversation")
	await settle()
	check(not phone.attachments_view and phone.story.state.node == "private_photo", "attachment browsing preserves scene")
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
	print("Social UI tests: %d passed, %d failed" % [passed, failed])
	phone.queue_free()
	await process_frame
	quit(1 if failed else 0)
