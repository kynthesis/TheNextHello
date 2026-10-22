extends Control

const Story := preload("res://scripts/story.gd")
const AppIcon := preload("res://scripts/app_icon.gd")
const PixelArt := preload("res://scripts/pixel_art.gd")
const MusicLibrary := preload("res://scripts/music.gd")
const ChatBubble := preload("res://scripts/chat_bubble.gd")
const Avatar := preload("res://scripts/avatar.gd")
const InterfaceAudio := preload("res://scripts/interface_audio.gd")
const INK := Color("252525")
const MUTED := Color("777c85")
const BLUE := Color("3b5998")
const SURFACE := Color("ffffff")
const PAPER := Color("eef0f7")
const RULE := Color("c4c9d4")
const MOBILE_SIZE := Vector2(414, 896)
const SECTION_NAMES := {"Home": "Home", "Calendar": "Events", "Notes": "Events"}
var profile_view := false
var feed_view := false
var friends_view := false
var comments_open := ""
var requests_view := false
var friend_profile := ""
var friend_photos := false
var attachments_view := false
var status_draft := ""
var comment_draft := ""
var story: HelloStory
var ui: Control
var frame: Control
var screen: PanelContainer
var body: VBoxContainer
var scroller: ScrollContainer
var status := ""
var confirm_restart := false
var confirm_later := false
var saved_app := ""
var notification_center := false
var sfx: AudioStreamPlayer
var sound_volume := 0.55
var reduce_motion := false
var transition: Tween
var gesture_start := Vector2.ZERO
var gesture_active := false
var gesture_dragged := false
var gesture_scroll := 0
var gesture_can_scroll := false
var sounds: Dictionary = {}
var delivery_timer: Timer
var dots_timer: Timer
var typing_label: Label
var dots := 0
var view_thread := ""
var inbox := false
var instant_messages := false
var draft_tween: Tween
var draft_typing := false
var suspended := false
var music: Node
var music_view := false
var known_songs: Array = []

func _ready() -> void:
	story = await Story.create()
	get_tree().auto_accept_quit = false
	RenderingServer.set_default_clear_color(Color("171c28"))
	sfx = AudioStreamPlayer.new()
	sfx.name = "InterfaceSounds"
	sfx.max_polyphony = 4
	add_child(sfx)
	music = MusicLibrary.new()
	music.name = "MusicLibrary"
	add_child(music)
	music.changed.connect(_music_changed)
	for cue: String in ["tap", "typing", "space", "sent", "received"]:
		sounds[cue] = _sound(cue)
	delivery_timer = Timer.new()
	delivery_timer.one_shot = true
	delivery_timer.wait_time = 0.45
	delivery_timer.timeout.connect(_delivery_tick)
	add_child(delivery_timer)
	dots_timer = Timer.new()
	dots_timer.wait_time = 0.25
	dots_timer.timeout.connect(_animate_dots)
	add_child(dots_timer)
	dots_timer.start()
	_load_settings()
	(await story.load_from("user://autosave.json"))
	music.sync(story, true)
	known_songs = music.available().map(func(entry: Dictionary) -> String: return entry.id)
	status = ""
	ui = Control.new()
	ui.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	ui.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(ui)
	resized.connect(_layout)
	_render()

func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_RESUMED and is_instance_valid(delivery_timer):
		suspended = false
		music.suspend(false)
		dots_timer.start()
		if draft_tween and draft_tween.is_valid(): draft_tween.play()
		_sync_presentation.call_deferred()
	if what in [NOTIFICATION_APPLICATION_PAUSED, NOTIFICATION_WM_CLOSE_REQUEST] and is_instance_valid(ui):
		suspended = true
		music.suspend(true)
		delivery_timer.stop()
		dots_timer.stop()
		if draft_tween and draft_tween.is_valid(): draft_tween.pause()
		_remember()
		story.save_to("user://autosave.json")
		if what == NOTIFICATION_WM_CLOSE_REQUEST:
			get_tree().quit()

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if music_view:
			_close_music()
		elif notification_center:
			_close_notifications()
		else:
			_open("Home")
		get_viewport().set_input_as_handled()
func _style(color: Color, border := Color.TRANSPARENT) -> StyleBoxFlat:
	var box := StyleBoxFlat.new()
	box.bg_color = color
	box.border_color = border
	box.set_border_width_all(1 if border.a > 0 else 0)
	box.set_corner_radius_all(0)
	box.content_margin_left = 12
	box.content_margin_right = 12
	box.content_margin_top = 8
	box.content_margin_bottom = 8
	return box

func _theme() -> Theme:
	var result := Theme.new()
	var font := SystemFont.new()
	font.font_names = PackedStringArray(["Arial", "Helvetica", "Liberation Sans"])
	result.default_font = font
	result.default_font_size = 16
	result.set_color("font_color", "Label", INK)
	result.set_color("font_color", "Button", BLUE)
	result.set_color("font_hover_color", "Button", INK)
	result.set_color("font_focus_color", "Button", BLUE)
	result.set_color("font_pressed_color", "Button", INK)
	result.set_stylebox("normal", "Button", _style(Color("f7f8fa"), RULE))
	result.set_stylebox("hover", "Button", _style(Color("e9eef7"), BLUE))
	result.set_stylebox("pressed", "Button", _style(Color("d8e3f4"), BLUE))
	var focus := _style(Color.TRANSPARENT, INK)
	focus.set_border_width_all(2)
	result.set_stylebox("focus", "Button", focus)
	result.set_stylebox("disabled", "Button", _style(PAPER, RULE))
	result.set_color("font_disabled_color", "Button", MUTED)
	result.set_constant("separation", "VBoxContainer", 8)
	result.set_constant("separation", "HBoxContainer", 8)
	result.set_color("font_color", "TextEdit", INK)
	result.set_color("font_color", "LineEdit", INK)
	result.set_color("font_placeholder_color", "LineEdit", MUTED)
	result.set_stylebox("normal", "TextEdit", _style(SURFACE, Color("a7afbd")))
	result.set_stylebox("focus", "TextEdit", _style(SURFACE, BLUE))
	var search_style := _style(SURFACE, Color("a7afbd"))
	search_style.set_corner_radius_all(16)
	result.set_stylebox("normal", "LineEdit", search_style)
	result.set_stylebox("focus", "LineEdit", _style(SURFACE, BLUE))
	return result

func _label(text: String, font_size := 16, color := INK) -> Label:
	var label := Label.new()
	label.text = text
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", color)
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	return label

func _button(text: String, action: Callable, parent: Node = null) -> Button:
	var button := Button.new()
	button.text = text
	button.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	button.custom_minimum_size.y = 36
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	button.pressed.connect(func() -> void: _play_sound("tap"))
	button.pressed.connect(action)
	(parent if parent != null else body).add_child(button)
	return button

func _card(title: String, copy: String, parent: Node = null, outgoing: Variant = null) -> VBoxContainer:
	var panel := PanelContainer.new()
	var card_style: StyleBox = _style(SURFACE, RULE)
	if outgoing != null:
		panel.set_script(ChatBubble)
		panel.outgoing = bool(outgoing)
		panel.name = "SentBubble" if outgoing else "ReceivedBubble"
		card_style = _style(Color("dce9fa"), Color("9cb2d0")) if outgoing else _style(Color.WHITE, Color("c2c8d1"))
	panel.add_theme_stylebox_override("panel", card_style)
	(parent if parent != null else body).add_child(panel)
	var stack := VBoxContainer.new()
	panel.add_child(stack)
	if title != "":
		stack.add_child(_label(title, 13, BLUE))
	if copy != "":
		stack.add_child(_label(copy))
	return stack

func _art(kind: String, parent: Node = null, height := 156.0) -> void:
	var artwork := Control.new()
	artwork.set_script(PixelArt)
	artwork.kind = kind
	artwork.custom_minimum_size.y = height
	artwork.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	(parent if parent != null else body).add_child(artwork)

func _remember() -> void:
	if is_instance_valid(music): music.remember()
	if not music_view and is_instance_valid(scroller) and saved_app != "":
		story.state.scroll[saved_app] = scroller.scroll_vertical

func _open(app: String) -> void:
	app = Story.APP_ALIASES.get(app, app)
	if app not in Story.APPS:
		return
	delivery_timer.stop()
	if draft_tween and draft_tween.is_valid(): draft_tween.kill()
	draft_typing = false
	profile_view = false
	feed_view = false
	friends_view = false
	requests_view = false
	friend_profile = ""
	friend_photos = false
	attachments_view = false
	comments_open = ""
	view_thread = ""
	inbox = false
	_remember()
	music_view = false
	var previous: String = story.state.app
	story.state.app = app
	notification_center = false
	story.mark_app_read(app)
	if app == "Calendar": story.mark_app_read("Notes")
	confirm_later = false
	confirm_restart = false
	status = ""
	_render()
	_autosave()
	if previous != app:
		_animate_open()

func _layout() -> void:
	if not is_instance_valid(frame): return
	var factor := maxf(0.05, minf(size.x / MOBILE_SIZE.x, size.y / MOBILE_SIZE.y))
	frame.size = MOBILE_SIZE
	frame.scale = Vector2.ONE * factor
	frame.position = (size - MOBILE_SIZE * factor) / 2

func _render(refocus := true) -> void:
	_sync_music()
	if transition and transition.is_valid(): transition.kill()
	if draft_tween and draft_tween.is_valid():
		draft_tween.kill()
		draft_typing = false
	for child: Node in ui.get_children():
		ui.remove_child(child)
		child.queue_free()
	ui.theme = _theme()
	frame = Control.new()
	frame.name = "SocialNetwork"
	ui.add_child(frame)
	screen = PanelContainer.new()
	screen.name = "MobileApp"
	screen.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var surface := _style(PAPER)
	surface.set_content_margin_all(0)
	screen.add_theme_stylebox_override("panel", surface)
	frame.add_child(screen)
	var column := VBoxContainer.new()
	column.add_theme_constant_override("separation", 0)
	screen.add_child(column)
	_status_bar(column)
	var margin := MarginContainer.new()
	margin.size_flags_vertical = Control.SIZE_EXPAND_FILL
	for edge: String in ["left", "right", "top", "bottom"]:
		margin.add_theme_constant_override("margin_" + edge, 10)
	column.add_child(margin)
	var layout := HBoxContainer.new()
	layout.add_theme_constant_override("separation", 20)
	margin.add_child(layout)
	var center := VBoxContainer.new()
	center.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	layout.add_child(center)
	var title := "Profile" if profile_view else "Requests" if requests_view else friend_profile if friend_profile != "" else "Friends" if friends_view else "News Feed" if feed_view else _section_name(story.state.app)
	if title != "Home" and not music_view:
		var crumb := HBoxContainer.new()
		center.add_child(crumb)
		var back := _button("‹ Home", _open.bind("Home"), crumb)
		back.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		back.autowrap_mode = TextServer.AUTOWRAP_OFF
		crumb.add_child(_label(title, 20, BLUE))
	if status != "": center.add_child(_label(status, 13, BLUE))
	scroller = ScrollContainer.new()
	scroller.name = "ContentScroll"
	scroller.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroller.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	scroller.follow_focus = true
	center.add_child(scroller)
	body = VBoxContainer.new()
	body.name = "Content"
	body.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroller.add_child(body)
	if music_view:
		_music_page()
	elif requests_view:
		_requests()
	elif friend_profile != "":
		_friend_profile()
	elif profile_view:
		_profile()
	elif feed_view:
		_feed()
	elif friends_view:
		_friends()
	else:
		match story.state.app:
			"Home": _home()
			"Messages": _conversation()
			"Photos": _gallery()
			"Calendar": _events()
			"Settings": _settings()
			"Notes": _events()
	if story.state.app == "Home" and not (profile_view or feed_view or friends_view or requests_view or music_view or friend_profile != ""):
		_home_footer(column)
	_layout()
	_refresh_overlay()
	saved_app = story.state.app
	_restore_scroll.call_deferred(story.state.app, 0 if music_view else int(story.state.scroll.get(story.state.app, 0)))
	if refocus: _focus_first.call_deferred()
	_sync_presentation.call_deferred()

func _section_name(app: String) -> String:
	return "Home" if app == "Home" else SECTION_NAMES.get(app, app)

func _open_profile() -> void:
	_open("Home")
	profile_view = true
	_render()

func _avatar(who: String, parent: Node) -> void:
	var avatar := Control.new()
	avatar.set_script(Avatar)
	avatar.who = who
	avatar.custom_minimum_size = Vector2(32, 32)
	avatar.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
	parent.add_child(avatar)

func _known_contacts() -> Array[String]:
	var contacts: Array[String] = []
	for thread: String in story.threads():
		if thread in ["Mizuki", "Natsumi", "Daichi", "Mizuki & Misaki"]:
			if thread not in contacts: contacts.append(thread)
	return contacts

func _open_contact(contact: String) -> void:
	_open("Messages")
	view_thread = contact
	_render()

func _focus_first() -> void:
	var buttons := frame.find_children("*", "Button", true, false)
	if not buttons.is_empty():
		buttons[0].grab_focus()

func _restore_scroll(app: String, value: int) -> void:
	if story.state.app == app and is_instance_valid(scroller):
		scroller.scroll_vertical = value

func _status_bar(column: VBoxContainer) -> void:
	var bar := PanelContainer.new()
	bar.name = "SiteHeader"
	var header_style := _style(BLUE, BLUE)
	header_style.content_margin_left = 12
	header_style.content_margin_right = 8
	header_style.content_margin_top = 3
	header_style.content_margin_bottom = 3
	bar.add_theme_stylebox_override("panel", header_style)
	column.add_child(bar)
	var row := HBoxContainer.new()
	bar.add_child(row)
	row.add_theme_constant_override("separation", 0)
	var logo := _button("Noir", _open.bind("Home"), row)
	logo.name = "SiteLogo"
	logo.add_theme_font_size_override("font_size", 31)
	logo.alignment = HORIZONTAL_ALIGNMENT_LEFT
	logo.custom_minimum_size.y = 52
	var wordmark_font := SystemFont.new()
	wordmark_font.font_names = PackedStringArray(["Arial", "Helvetica", "Liberation Sans"])
	wordmark_font.font_weight = 700
	logo.add_theme_font_override("font", wordmark_font)
	logo.autowrap_mode = TextServer.AUTOWRAP_OFF
	for state: String in ["font_color", "font_focus_color", "font_hover_color", "font_pressed_color"]: logo.add_theme_color_override(state, Color.WHITE)
	for state: String in ["normal", "hover", "pressed"]: logo.add_theme_stylebox_override(state, StyleBoxEmpty.new())
	logo.add_theme_stylebox_override("focus", _style(Color.TRANSPARENT, Color("98afd3")))
	var settings := _button("Settings", _open.bind("Settings"), row)
	settings.name = "SettingsLink"
	var music_link := _button("Music", _show_music, row)
	music_link.name = "MusicLink"
	for link: Button in [settings, music_link]:
		link.size_flags_horizontal = Control.SIZE_SHRINK_END
		link.custom_minimum_size = Vector2(80, 44)
		link.autowrap_mode = TextServer.AUTOWRAP_OFF
		for state: String in ["font_color", "font_focus_color", "font_hover_color", "font_pressed_color"]: link.add_theme_color_override(state, Color.WHITE)
		link.add_theme_stylebox_override("normal", _style(BLUE, Color("304d86")))
		link.add_theme_stylebox_override("hover", _style(Color("4969aa"), Color("304d86")))
		link.add_theme_stylebox_override("pressed", _style(Color("304d86"), Color("304d86")))

func _home_footer(column: VBoxContainer) -> void:
	var footer := _button("Notifications", _show_notifications, column)
	footer.name = "Notifications"
	footer.custom_minimum_size.y = 48
	footer.icon = load("res://assets/ui/notification_globe.svg")
	footer.add_theme_font_size_override("font_size", 19)
	for state: String in ["font_color", "font_focus_color", "font_hover_color", "font_pressed_color"]: footer.add_theme_color_override(state, Color.WHITE)
	footer.add_theme_stylebox_override("normal", _style(BLUE, BLUE))
	footer.add_theme_stylebox_override("hover", _style(Color("4969aa"), BLUE))
	footer.add_theme_stylebox_override("pressed", _style(Color("304d86"), BLUE))

func _animate_open() -> void:
	if reduce_motion: return
	screen.modulate.a = 0.8
	transition = create_tween()
	transition.tween_property(screen, "modulate:a", 1.0, 0.12)

func _show_notifications() -> void:
	_remember()
	notification_center = true
	delivery_timer.stop()
	_refresh_overlay()

func _close_notifications() -> void:
	notification_center = false
	_refresh_overlay()
	_sync_presentation.call_deferred()

func _refresh_overlay() -> void:
	if not is_instance_valid(frame): return
	_refresh_app_badges()
	var old := frame.get_node_or_null("NotificationOverlay")
	if old:
		frame.remove_child(old)
		old.queue_free()
	for button: Node in frame.find_children("*", "Button", true, false):
		button.focus_mode = Control.FOCUS_NONE if notification_center else Control.FOCUS_ALL
	if not notification_center: return
	var layer := Control.new()
	layer.name = "NotificationOverlay"
	layer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	layer.mouse_filter = Control.MOUSE_FILTER_STOP
	frame.add_child(layer)
	var overlay := PanelContainer.new()
	overlay.name = "NotificationCard"
	overlay.position = Vector2(12, 66)
	overlay.size = Vector2(frame.size.x - 24, frame.size.y - 90)
	overlay.add_theme_stylebox_override("panel", _style(SURFACE, RULE))
	layer.add_child(overlay)
	var stack := VBoxContainer.new()
	overlay.add_child(stack)
	stack.add_child(_label("Notifications", 20, BLUE))
	var done := _button("Done", _close_notifications, stack)
	done.grab_focus.call_deferred()
	var scroll := ScrollContainer.new()
	scroll.name = "NotificationScroll"
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	stack.add_child(scroll)
	var list := VBoxContainer.new()
	list.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.add_child(list)
	for i in range(story.state.notifications.size() - 1, -1, -1):
		var notice: Dictionary = story.state.notifications[i]
		if notice.get("kind") != "message": continue
		_button(("● " if not notice.read else "") + notice.thread + "\n" + story.text(notice.text), _open_contact.bind(notice.thread), list)
	if list.get_child_count() == 0: list.add_child(_label("No new messages."))
	_button("Mark all as read", _mark_notifications_read, stack)

func _mark_notifications_read() -> void:
	for app: String in Story.APPS:
		story.mark_app_read(app)
	_autosave()
	_refresh_overlay()

func _refresh_app_badges() -> void:
	for link: Node in frame.find_children("*", "Button", true, false):
		if link.has_meta("section"):
			var section: String = link.get_meta("section")
			var count: int = story.unread_count(section)
			link.text = _section_name(section) + ("  (%d)" % count if count > 0 else "")

func _play_sound(cue: String, pitch := 1.0) -> void:
	if sound_volume <= 0 or not sounds.has(cue):
		return
	sfx.stream = sounds[cue]
	sfx.pitch_scale = pitch
	sfx.volume_db = linear_to_db(sound_volume)
	sfx.play()

func _sound(cue: String) -> AudioStreamWAV:
	return InterfaceAudio.make(cue)

func _input(event: InputEvent) -> void:
	if not is_instance_valid(frame):
		return
	if event is InputEventScreenTouch:
		if event.pressed:
			_begin_gesture(event.position)
		else:
			_end_gesture(event.position)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			_begin_gesture(event.position)
		else:
			_end_gesture(event.position)
	elif event is InputEventScreenDrag or (event is InputEventMouseMotion and gesture_active):
		_drag_gesture(event.position)

func _begin_gesture(point: Vector2) -> void:
	gesture_start = frame.get_global_transform().affine_inverse() * point
	gesture_active = Rect2(Vector2.ZERO, frame.size).has_point(gesture_start)
	gesture_dragged = false
	var target := _gesture_scroller()
	gesture_scroll = target.scroll_vertical
	var hovered := get_viewport().gui_get_hovered_control()
	gesture_can_scroll = scroller.get_global_rect().has_point(point) and not (hovered is TextEdit or hovered is HSlider)

func _drag_gesture(point: Vector2) -> void:
	if not gesture_active:
		return
	var local := frame.get_global_transform().affine_inverse() * point
	var delta := local - gesture_start
	if delta.length() < 18:
		return
	gesture_dragged = true
	if absf(delta.y) > absf(delta.x) and gesture_can_scroll:
		_gesture_scroller().scroll_vertical = maxi(0, gesture_scroll - int(delta.y))
	get_viewport().set_input_as_handled()

func _end_gesture(point: Vector2) -> void:
	if not gesture_active:
		return
	gesture_active = false
	var delta := frame.get_global_transform().affine_inverse() * point - gesture_start
	if gesture_dragged:
		get_viewport().set_input_as_handled()
	if not gesture_dragged or delta.length() < 36:
		return
	get_viewport().set_input_as_handled()

func _gesture_scroller() -> ScrollContainer:
	if notification_center:
		var notification_scroll: Node = frame.find_child("NotificationScroll", true, false)
		if notification_scroll is ScrollContainer:
			return notification_scroll
	return scroller

func _home() -> void:
	var search := LineEdit.new()
	search.name = "FriendSearch"
	search.placeholder_text = "Search friends"
	search.custom_minimum_size.y = 36
	search.text_submitted.connect(_search_friends)
	body.add_child(search)
	body.add_child(_label("Asahi  ·  Tokyo, Japan", 13, MUTED))
	var grid := GridContainer.new()
	grid.name = "SectionGrid"
	grid.columns = 3
	grid.add_theme_constant_override("h_separation", 8)
	grid.add_theme_constant_override("v_separation", 19)
	body.add_child(grid)
	_menu_tile("News Feed", "Home", _show_feed, grid)
	_menu_tile("Profile", "Profile", _open_profile, grid)
	_menu_tile("Friends", "Friends", _show_friends, grid)
	_menu_tile("Messages", "Messages", _open.bind("Messages"), grid)
	_menu_tile("Events", "Calendar", _open.bind("Calendar"), grid)
	_menu_tile("Photos", "Photos", _open.bind("Photos"), grid)
	_menu_tile("Requests", "Requests", _show_requests, grid)
	var spacer := Control.new()
	spacer.custom_minimum_size.y = 22
	body.add_child(spacer)
	var shelf := PanelContainer.new()
	shelf.name = "PhotoShelf"
	shelf.add_theme_stylebox_override("panel", _style(Color("dde2eb"), Color("b8c1d0")))
	body.add_child(shelf)
	var photos := HBoxContainer.new()
	photos.add_theme_constant_override("separation", 7)
	shelf.add_child(photos)
	for kind: String in ["city", "desk", "city_morning"]:
		var photo := Button.new()
		photo.name = "PhotoPreview_" + kind
		photo.tooltip_text = "View my photos"
		photo.custom_minimum_size.y = 94
		photo.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		photo.add_theme_stylebox_override("normal", _style(Color.WHITE, Color("777f8d")))
		photos.add_child(photo)
		var art := Control.new()
		art.set_script(PixelArt)
		art.kind = kind
		art.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		art.offset_left = 3
		art.offset_top = 3
		art.offset_right = -3
		art.offset_bottom = -3
		photo.add_child(art)
		photo.pressed.connect(_open.bind("Photos"))
		photo.pressed.connect(_play_sound.bind("tap"))

func _search_friends(query: String) -> void:
	query = query.strip_edges().to_lower()
	if query.is_empty(): return
	for person: String in story.social().friends:
		if query in person.to_lower() or query in str(story.characters[person].get("name", person)).to_lower():
			_view_friend(person)
			return
	status = "No friends found for that name."
	_render()

func _menu_tile(label: String, icon_key: String, action: Callable, parent: Node) -> void:
	var tile := VBoxContainer.new()
	tile.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	parent.add_child(tile)
	var icon := Button.new()
	icon.set_script(AppIcon)
	icon.app = icon_key
	icon.badge_count = 0 if icon_key == "Calendar" else story.pending_requests().size() if icon_key == "Requests" else story.unread_count(icon_key) if icon_key in Story.APPS else 0
	icon.name = icon_key + "Tile"
	icon.custom_minimum_size = Vector2(72, 72)
	icon.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	icon.tooltip_text = label
	for state: String in ["normal", "hover", "pressed", "focus"]: icon.add_theme_stylebox_override(state, StyleBoxEmpty.new())
	icon.pressed.connect(action)
	icon.pressed.connect(_play_sound.bind("tap"))
	icon.focus_entered.connect(icon.queue_redraw)
	icon.focus_exited.connect(icon.queue_redraw)
	tile.add_child(icon)
	var caption := _label(label, 17, INK)
	caption.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	tile.add_child(caption)

func _show_feed() -> void:
	_open("Home")
	feed_view = true
	_render()

func _show_friends() -> void:
	_open("Home")
	friends_view = true
	_render()

func _friends() -> void:
	for person: String in story.social().friends:
		var card := _card(person, "Friends")
		_button("View " + person + "'s profile", _view_friend.bind(person), card)
	_button("Friend requests (%d)" % story.pending_requests().size(), _show_requests)

func _show_requests() -> void:
	_open("Home")
	requests_view = true
	_render()

func _requests() -> void:
	if story.pending_requests().is_empty(): body.add_child(_label("No new friend requests."))
	for person: String in story.pending_requests():
		var card := _card(person, "Sent you a friend request after your conversation.")
		_button("Accept " + person, _answer_request.bind(person, true), card)
		_button("Decline " + person, _answer_request.bind(person, false), card)
	body.add_child(_label("Messages don't require a friend request. You can reply when you're ready.", 13, MUTED))

func _answer_request(person: String, accept: bool) -> void:
	if story.answer_request(person, accept):
		_autosave()
		_render()

func _view_friend(person: String) -> void:
	if person not in story.social().friends: return
	_open("Home")
	friend_profile = person
	_render()

func _friend_profile() -> void:
	var person: Dictionary = story.characters[friend_profile]
	var entry: Array = [person.city, person.bio, person.public_photo]
	var card := _card(friend_profile, entry[0])
	_profile_details(person, card)
	_button("Profile" if friend_photos else "View photos", func() -> void: friend_photos = not friend_photos; _render(), card)
	if friend_photos:
		_card("PHOTOS / " + friend_profile.to_upper(), "Shared with friends. Private work attachments stay in Messages.")
		_art(entry[2])
		body.add_child(_label(person.photo_caption, 14, MUTED))
	else:
		_feed_post("friend_" + friend_profile, friend_profile, entry[1], entry[2], "Friends", "")
	if friend_profile in _known_contacts(): _button("Message " + friend_profile, _open_contact.bind(friend_profile))

func _feed() -> void:
	var heading := HBoxContainer.new()
	body.add_child(heading)
	heading.add_child(_label("News Feed", 22, BLUE))
	var date := _label(_story_date(), 12, MUTED)
	date.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	heading.add_child(date)
	_button("Post a status", _open_profile)
	_render_own_posts()
	_feed_post("feed_window", "Asahi", "Tokyo. Rain again. At least the view is doing something with it.", "city", "Only me", "Still haven't bought a plant for this window.")
	for id: String in _public_posts():
		var item: Array = _public_posts()[id]
		_feed_post(id, item[0], item[1], item[2], "Friends", "")
	body.add_child(_label("You're caught up. Private conversations stay in Messages.", 13, MUTED))

func _public_posts() -> Dictionary:
	var posts := {}
	for name: String in story.social().friends:
		var person: Dictionary = story.characters[name]
		posts["friend_" + name] = [name, person.bio, person.public_photo]
	return posts

func _render_own_posts() -> void:
	for i in range(story.social().posts.size() - 1, -1, -1):
		var post: Dictionary = story.social().posts[i]
		_feed_post("status_%d" % i, "Asahi", post.copy, "", "Friends / " + post.date, "")
	for id: String in story.social().shares:
		if _public_posts().has(id):
			var post: Array = _public_posts()[id]
			var card := _card("ASAHI SHARED / FRIENDS", post[0] + ": " + post[1])
			_art(post[2], card, 120)


func _feed_post(id: String, author: String, copy: String, art: String, audience: String, comment: String) -> void:
	var post := _card("", "")
	var header := HBoxContainer.new()
	post.add_child(header)
	_avatar(author, header)
	var byline := VBoxContainer.new()
	byline.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header.add_child(byline)
	byline.add_child(_label(author, 16, BLUE))
	byline.add_child(_label(audience + " / Saved update", 12, MUTED))
	post.add_child(_label(copy))
	if art != "": _art(art, post, 140)
	var actions := HBoxContainer.new()
	var action_strip := PanelContainer.new()
	action_strip.name = "FeedActionStrip"
	var strip_style := _style(Color("eceff5"))
	strip_style.set_content_margin_all(3)
	action_strip.add_theme_stylebox_override("panel", strip_style)
	post.add_child(action_strip)
	action_strip.add_child(actions)
	_like_button(id, actions)
	_button("Hide comment" if comments_open == id else "Comment", func() -> void: _remember(); comment_draft = ""; comments_open = "" if comments_open == id else id; _render(), actions)
	if _public_posts().has(id): _button("Shared" if id in story.social().shares else "Share", _share_post.bind(id), actions)
	for link: Button in actions.get_children():
		link.custom_minimum_size.y = 28
		link.add_theme_font_size_override("font_size", 14)
		link.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
		link.add_theme_stylebox_override("hover", _style(Color("dde4f0")))
		link.add_theme_stylebox_override("pressed", _style(Color("cbd7eb")))
	if comments_open == id:
		if comment != "": post.add_child(_label(comment, 14, MUTED))
		for message: String in story.social().comments.get(id, []): post.add_child(_label("Asahi: " + message, 16))
		var input := TextEdit.new()
		input.name = "CommentInput"
		input.placeholder_text = "Write a comment..."
		input.custom_minimum_size.y = 80
		input.text = comment_draft
		input.text_changed.connect(func() -> void: comment_draft = input.text)
		post.add_child(input)
		_button("Post comment", _post_comment.bind(id), post)

func _share_post(id: String) -> void:
	if not _public_posts().has(id) or id in story.social().shares: return
	story.social().shares.append(id)
	_autosave()
	_render()

func _post_comment(id: String) -> void:
	if story.add_comment(id, comment_draft):
		comment_draft = ""
		_autosave()
		_render()

func _profile() -> void:
	var profile := _card("MY PROFILE", "Tachibana Asahi\nasahi / Tokyo, Japan")
	_art("city", profile, 110)
	profile.add_child(_label(story.characters.Asahi.bio, 16))
	_profile_details(story.characters.Asahi, profile)
	_button("My photos", _open.bind("Photos"), profile)
	var composer := _card("POST STATUS / FRIENDS", "")
	var input := TextEdit.new()
	input.name = "StatusInput"
	input.placeholder_text = "What's on your mind?"
	input.custom_minimum_size.y = 110
	input.text = status_draft
	input.text_changed.connect(func() -> void: status_draft = input.text)
	composer.add_child(input)
	composer.add_child(_label("Up to 280 characters", 12, MUTED))
	_button("Post status", _post_status, composer)
	_render_own_posts()

func _profile_details(person: Dictionary, parent: Node) -> void:
	parent.add_child(_label("Birthday: " + person.birthday + " / " + person.zodiac, 14, MUTED))
	parent.add_child(_label("Interests: " + ", ".join(person.interests), 14, INK))
	parent.add_child(_label("Favorite food: " + person.favorites.food, 14, INK))
	parent.add_child(_label("Listening to: " + person.favorites.music, 14, INK))

func _post_status() -> void:
	if story.post_status(status_draft):
		status_draft = ""
		status = "Status posted to my profile and News Feed."
		_autosave()
	else:
		status = "Write a status between 1 and 280 characters."
	_render()

func _events() -> void:
	var journal: Dictionary = story.journal()
	var next := _card("STORY COMPLETE" if journal.complete else "CURRENT OBJECTIVE", journal.objective)
	next.add_child(_label("Chapter %d / " % int(journal.chapter) + journal.title, 14, MUTED))
	_button(("Read in " if journal.complete else "Continue in ") + _section_name(journal.app) + "  >", _open.bind(journal.app), next)
	if journal.draft_pending: next.add_child(_label("I have an unsent reply.", 14, BLUE))
	_card("MY PLANS", story.state.facts.get("commitment", "Nothing confirmed yet."))
	if story.state.facts.has("work"): _card("WORK", story.state.facts.work)
	var earlier := _card("COMPLETED", "")
	for entry: Dictionary in journal.completed: earlier.add_child(_label("✓ " + entry.title, 14, MUTED))

func _thread() -> String:
	if story.state.app != "Messages": return story.current().thread
	if view_thread != "": return view_thread
	if story.current().app == "Messages": return story.current().thread
	for i in range(story.state.log.size() - 1, -1, -1):
		if story.state.log[i].app == "Messages": return story.state.log[i].thread
	return "Mizuki"

func _conversation() -> void:
	if inbox:
		body.add_child(_label("Conversations", 22))
		for thread: String in story.threads():
			_button(thread, func() -> void: view_thread = thread; inbox = false; _render())
		if story.threads().is_empty(): body.add_child(_label("No conversations yet.", 14, MUTED))
		return
	else:
		body.add_child(_label(_thread(), 22))
		body.add_child(_label("Group chat" if _thread() in ["After Hours", "Hoshino Studio", "Mizuki & Misaki"] else "Direct message", 12, MUTED))
		_button("Conversations", func() -> void: inbox = true; delivery_timer.stop(); _render())
	if story.state.app == "Messages" and _thread() == "Mizuki" and (story.state.facts.get("desk_photo", false) or story.state.facts.get("postcard", false)):
		_button("Back to conversation" if attachments_view else "Shared attachments", func() -> void: attachments_view = not attachments_view; delivery_timer.stop(); _render())
		if attachments_view:
			_shared_attachments()
			return
	_render_thread()

func _shared_attachments() -> void:
	body.add_child(_label("PRIVATE / MIZUKI & ASAHI", 13, BLUE))
	if story.state.facts.get("desk_photo", false) and not story.state.facts.get("draft_withdrawn", false):
		var photo := _card("MIZUKI'S DESK", "Private work draft. Mizuki asked me not to publish it.")
		_art("desk", photo, 160)
	if story.state.facts.get("postcard", false):
		var photo := _card("TWO WINDOWS", "Our private postcard.")
		_art("city", photo, 140)
	for id: String in story.state.facts.get("photo_ids", []):
		var item: Dictionary = story.content.photos.get(id, {})
		if not item.is_empty():
			var photo := _card(item.title, item.copy)
			_art(item.kind, photo, 140)
	if story.state.facts.get("draft_withdrawn", false): _card("WORK DRAFT WITHDRAWN", "Mizuki removed her unfinished work from this conversation.")

func _speaker_name(speaker: String) -> String:
	return {"asahi": "Me", "work": "Studio team", "mossbyte": "Daichi"}.get(speaker, speaker.capitalize())

func _render_thread() -> void:
	for entry: Dictionary in story.visible_log(story.state.app, _thread()):
		var speaker: String = entry.speaker
		if speaker == "system":
			body.add_child(_label(story.text(entry.text), 12, MUTED))
		else:
			var row := HBoxContainer.new()
			row.name = "OutgoingMessage" if speaker == "asahi" else "IncomingMessage"
			body.add_child(row)
			var spacer := Control.new()
			spacer.custom_minimum_size.x = 36
			spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			if speaker == "asahi": row.add_child(spacer)
			else: _avatar(speaker, row)
			var card := _card(_speaker_name(speaker), story.text(entry.text), row, speaker == "asahi")
			var panel := card.get_parent() as PanelContainer
			panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			panel.size_flags_stretch_ratio = 5
			if speaker != "asahi": row.add_child(spacer)
			if entry.has("delivery"): card.add_child(_label(entry.delivery, 11, MUTED))
	if story.state.app == story.current().app and _thread() == story.current().thread:
		_story_controls()

func _can_present() -> bool:
	return not notification_center and not music_view and not suspended and not inbox and not attachments_view and friend_profile == "" and not profile_view and not requests_view and not feed_view and not friends_view and story.state.app == story.current().app and _thread() == story.current().thread and story.state.app == "Messages"

func _sync_presentation() -> void:
	if not _can_present() or not story.delivery_pending(): return
	if instant_messages or reduce_motion:
		story.reveal_all()
		_autosave()
		_render(false)
	elif delivery_timer.is_stopped():
		delivery_timer.start(_delivery_delay())

func _delivery_delay() -> float:
	# Receipts and saved notes are quick; another person's words take a moment.
	for entry: Dictionary in story.state.log:
		if entry.get("delivery") == "Sent": return 0.65
	var pending: Array = story.state.log.slice(int(story.state.shown_count))
	if pending.is_empty(): return 0.45
	var entry: Dictionary = pending[0]
	if entry.speaker in ["system", "asahi"]: return 0.35
	return clampf(0.9 + story.text(entry.text).length() * 0.045, 1.2, 5.0)

func _delivery_tick() -> void:
	if not _can_present(): return
	var follow := scroller.scroll_vertical >= scroller.get_v_scroll_bar().max_value - scroller.size.y - 32
	_remember()
	var previous_count: int = story.state.shown_count
	story.advance_delivery()
	if story.state.shown_count > previous_count:
		var delivered: Dictionary = story.state.log[previous_count]
		if delivered.speaker not in ["system", "asahi"]: _play_sound("received")
	story.mark_app_read("Messages")
	_autosave()
	_render(false)
	if follow: _scroll_bottom.call_deferred()

func _animate_dots() -> void:
	dots = (dots + 1) % 4
	if is_instance_valid(typing_label):
		typing_label.text = _typing_copy()

func _typing_copy() -> String:
	for entry: Dictionary in story.state.log:
		if entry.get("delivery") == "Sent": return "Waiting for read receipt"
	for entry: Dictionary in story.state.log.slice(int(story.state.shown_count)):
		if entry.speaker not in ["system", "asahi"]:
			return _speaker_name(entry.speaker) + " is typing" + ".".repeat(dots + 1)
	return "Updating conversation"

func _show_messages() -> void:
	delivery_timer.stop()
	story.reveal_all()
	_autosave()
	_render()
	_scroll_bottom.call_deferred()

func _type_draft() -> void:
	var label: Label = body.find_child("DraftText", true, false)
	if label == null: return
	label.visible_characters = 0
	draft_tween = create_tween()
	for index in range(label.text.length()):
		# Brief first keystroke, then uneven phone typing with word/punctuation rests.
		var character := label.text[index]
		var delay := 0.06 if index == 0 else _keystroke_delay(character, index)
		draft_tween.tween_interval(delay)
		draft_tween.tween_callback(_compose_chars.bind(index + 1, label))
	draft_tween.finished.connect(_finish_typing)

func _keystroke_delay(character: String, index: int) -> float:
	var delay := 0.11 + float((index * 37 + character.unicode_at(0)) % 81) / 1000.0
	if character == " ": delay += 0.07
	elif character in [",", ";", ":"]: delay += 0.28
	elif character in [".", "?", "!"]: delay += 0.48
	return delay

func _compose_chars(count: int, label: Label) -> void:
	if not is_instance_valid(label): return
	if count != label.visible_characters and count > 0:
		var character := label.text[count - 1]
		_play_sound("space" if character == " " else "typing", 0.97 + float(count % 5) * 0.015)
	label.visible_characters = count

func _finish_typing() -> void:
	if draft_tween and draft_tween.is_valid(): draft_tween.kill()
	draft_typing = false
	var label: Label = body.find_child("DraftText", true, false)
	if label: label.visible_characters = -1
	var send: Button = body.find_child("SendDraft", true, false)
	if send: send.disabled = false
	var finish: Button = body.find_child("FinishTyping", true, false)
	if finish: finish.hide()

func _story_controls() -> void:
	if story.delivery_pending():
		typing_label = _label(_typing_copy(), 13, MUTED)
		body.add_child(typing_label)
		_button("Show messages now", _show_messages)
		return
	if not story.choices().is_empty():
		body.add_child(_label("CHOOSE A DRAFT  /  Nothing sends until you say so", 11, BLUE))
		for choice: Dictionary in story.choices():
			_button(story.text(choice.text), _draft.bind(choice.id))
		if story.state.draft != "":
			for choice: Dictionary in story.choices():
				if choice.id == story.state.draft:
					var card := _card("UNSENT DRAFT", "")
					var draft_text := _label(story.text(choice.text))
					draft_text.name = "DraftText"
					card.add_child(draft_text)
					var send := _button("Send reply  >", _send, card)
					send.name = "SendDraft"
					send.disabled = draft_typing
					if draft_typing:
						var finish := _button("Finish typing", _finish_typing, card)
						finish.name = "FinishTyping"
					_button("Discard draft", _draft.bind(""), card)
	elif story.current().has("later"):
		if confirm_later:
			_card("ADVANCE STORY TIME?", "Optional browsing from this evening will be left behind. Delivered messages, photos and your notes remain. No real time has passed in the story while you read.")
			_button("Go to the next story day", _later)
			_button("Keep browsing", func() -> void: confirm_later = false; _render())
		else:
			_button("Later  /  Advance story time", func() -> void: confirm_later = true; _render())
	else:
		var ending: Dictionary = story.current().get("ending", {})
		_card("STORY COMPLETE", story.text(story.current().title))
		if not ending.is_empty(): body.add_child(_label(ending.category + " ending", 13, MUTED))
		_button("Review Events", _open.bind("Calendar"))

func _draft(id: String) -> void:
	if draft_tween and draft_tween.is_valid(): draft_tween.kill()
	draft_typing = id != "" and not reduce_motion and not instant_messages
	_remember()
	if id == "":
		story.state.draft = ""
	else:
		story.draft(id)
	_autosave()
	_render()
	if id != "":
		_scroll_bottom.call_deferred()
		if draft_typing: _type_draft.call_deferred()

func _send() -> void:
	if draft_typing: return
	if (await story.send()):
		view_thread = ""
		inbox = false
		_play_sound("sent")
		story.state.app = story.current().app
		story.mark_app_read(story.state.app)
		_autosave()
		_render()
		_scroll_bottom.call_deferred()

func _later() -> void:
	if (await story.later()):
		view_thread = ""
		inbox = false
		story.state.app = story.current().app
		story.mark_app_read(story.state.app)
		confirm_later = false
		_autosave()
		_render()
		_scroll_bottom.call_deferred()

func _scroll_bottom() -> void:
	scroller.scroll_vertical = int(scroller.get_v_scroll_bar().max_value)

func _autosave() -> void:
	_sync_music()
	music.remember()
	if not story.save_to("user://autosave.json"):
		status = story.last_error

func _like(id: String) -> void:
	_remember()
	story.toggle_like(id)
	_autosave()
	_render()

func _like_button(id: String, parent: Node, verb := "Like") -> void:
	_button(("Saved / " if id in story.state.likes else "") + verb, _like.bind(id), parent)

func _story_date() -> String:
	return story.current().timestamp + " / " + str(int(story.current().year))

func _gallery() -> void:
	var photo := _card("TOKYO WINDOW / MY PHOTO", "Rain against my apartment window.")
	_art("city", photo, 160)
	_like_button("tokyo_window", photo, "Favorite photo")
	photo = _card("MY WORKTABLE", "Before I get coffee on any of this.")
	_art("desk", photo, 160)
	photo = _card("SAME WINDOW, EARLIER", "Made it up before the alarm for once.")
	_art("city_morning", photo, 160)
	if story.state.facts.get("screenshot", false):
		photo = _card("MY LANTERN QUEST SCREENSHOT", "The first garden run with Mizuki.")
		_art("lantern", photo, 160)
	if story.state.facts.get("first_meeting", false):
		photo = _card("MY SAPPORO AFTERNOON", "Two cups, no landmark. I wanted to remember the afternoon.")
		_art("city", photo, 160)
	body.add_child(_label("Friends' photos are on their profiles. Private attachments stay in their conversations.", 13, MUTED))
	_button("Friends' photos", _show_friends)

func _settings() -> void:
	body.add_child(_label("Make yourself comfortable", 24))
	_card("MY ACCOUNT", "Tachibana Asahi\nasahi\nTokyo, Japan")
	_card("DISPLAY & READING", "A portrait social app with seven sections. Events holds my next objective; Messages holds private conversations. The story waits while I read.")
	_button("Instant messages: " + ("On" if instant_messages else "Off"), func() -> void: instant_messages = not instant_messages; _save_settings(); _render())
	_button("Reduce motion: " + ("On" if reduce_motion else "Off"), func() -> void: reduce_motion = not reduce_motion; _save_settings(); _render())
	body.add_child(_label("WINDOW RESOLUTION", 12, BLUE))
	for resolution: Vector2i in [Vector2i(1280, 720), Vector2i(1280, 900), Vector2i(1920, 1080), Vector2i(2560, 1440), Vector2i(480, 1040)]:
		_button("%d × %d" % [resolution.x, resolution.y], _set_resolution.bind(resolution))
	body.add_child(_label("NOTIFICATIONS & INTERFACE SOUNDS", 12, BLUE))
	var sound_slider := HSlider.new()
	sound_slider.min_value = 0
	sound_slider.max_value = 1
	sound_slider.step = 0.05
	sound_slider.value = sound_volume
	sound_slider.custom_minimum_size.y = 48
	sound_slider.value_changed.connect(func(value: float) -> void: sound_volume = value; _save_settings())
	body.add_child(sound_slider)
	_button("Preview notification sound", _play_sound.bind("received"))
	_button("Open notifications", _show_notifications)
	_button("Save story / manual slot", func() -> void: _remember(); status = "Manual save written." if story.save_to("user://manual.json") else story.last_error; _render())
	_button("Load manual save", func() -> void: _load_game("user://manual.json"))
	_button("Continue autosave", func() -> void: _load_game("user://autosave.json"))
	if confirm_restart:
		_card("START OVER?", "This replaces the current story and autosave. Your manual save is kept.")
		_button("Start a new story", _restart)
		_button("Keep this story", func() -> void: confirm_restart = false; _render())
	else:
		_button("Start a new story...", func() -> void: confirm_restart = true; _render())
	_card("ABOUT THIS BUILD", "Godot 4.7.2 / Complete story first draft\nSix acts, three activity paths, eight endings, a private social network and temporary pixel illustrations. Final art, reader testing, mobile exports and release accessibility work are still ahead.\n\nThemes: loneliness, distance and relationships. All principal characters are adults.")

func _restart() -> void:
	delivery_timer.stop()
	view_thread = ""
	inbox = false
	(await story.reset())
	music.sync(story, true)
	known_songs = music.available().map(func(entry: Dictionary) -> String: return entry.id)
	confirm_restart = false
	saved_app = ""
	status = "A new evening."
	_autosave()
	_render()

func _load_game(path: String) -> void:
	if (await story.load_from(path)):
		music.sync(story, true)
		known_songs = music.available().map(func(entry: Dictionary) -> String: return entry.id)
		status = story.last_error if story.last_error != "" else "Save restored."
		saved_app = ""
	else:
		status = story.last_error
	_render()

func _save_settings() -> void:
	var settings := ConfigFile.new()
	settings.set_value("audio", "interface_volume", sound_volume)
	settings.set_value("audio", "music_volume", music.volume)
	settings.set_value("display", "reduce_motion", reduce_motion)
	settings.set_value("reading", "instant_messages", instant_messages)
	settings.save("user://settings.cfg")

func _load_settings() -> void:
	var settings := ConfigFile.new()
	if settings.load("user://settings.cfg") == OK:
		sound_volume = clampf(float(settings.get_value("audio", "interface_volume", 0.55)), 0.0, 1.0)
		music.set_volume(float(settings.get_value("audio", "music_volume", 0.65)))
		reduce_motion = bool(settings.get_value("display", "reduce_motion", false))
		instant_messages = bool(settings.get_value("reading", "instant_messages", false))

func _set_resolution(resolution: Vector2i) -> void:
	get_window().size = resolution
	_layout()
	_save_settings()

func _sync_music() -> void:
	if not is_instance_valid(music): return
	music.sync(story)
	var songs: Array = music.available().map(func(entry: Dictionary) -> String: return entry.id)
	if songs.any(func(id: String) -> bool: return id not in known_songs):
		status = "New song added to Music."
	known_songs = songs

func _music_changed() -> void:
	_autosave()
	_render(false)

func _show_music() -> void:
	_remember()
	delivery_timer.stop()
	if draft_tween and draft_tween.is_valid(): draft_tween.kill()
	draft_typing = false
	notification_center = false
	music_view = true
	_render()

func _close_music() -> void:
	music_view = false
	_render()

func _music_page() -> void:
	_button("Back to story", _close_music)
	var selected: Dictionary = music.track(music.options().song)
	_card("MY MUSIC", selected.title + " / " + str(music.options().variant).to_upper())
	var controls := HBoxContainer.new()
	body.add_child(controls)
	_button("Pause" if music.options().playing else "Play", music.toggle, controls).name = "MusicPlayPause"
	_button("Next", music.next, controls).name = "MusicNext"
	_button("Follow story: " + ("On" if music.options().automatic else "Off"), music.automatic).name = "MusicAutomatic"
	body.add_child(_label("Music volume", 13, MUTED))
	var slider := HSlider.new()
	slider.name = "MusicVolume"
	slider.min_value = 0
	slider.max_value = 1
	slider.step = 0.05
	slider.value = music.volume
	slider.custom_minimum_size.y = 48
	slider.value_changed.connect(func(value: float) -> void: music.set_volume(value); _save_settings())
	body.add_child(slider)
	var versions := HBoxContainer.new()
	body.add_child(versions)
	for version: String in ["a", "b"]:
		_button("Version " + version.to_upper(), music.select.bind(selected.id, version), versions).name = "MusicVersion" + version.to_upper()
	if music.error != "": body.add_child(_label(music.error, 16, MUTED))
	body.add_child(_label("IN MY LIBRARY", 13, BLUE))
	for entry: Dictionary in music.available():
		var label: String = entry.title + (" / vocals" if entry.vocals else "")
		_button(label, music.select.bind(entry.id, music.options().variant)).name = "Track_" + entry.id
	body.add_child(_label("More songs arrive as the story unfolds. Choose a song to listen manually; Follow story selects instrumentals. Both versions unlock together.", 13, MUTED))

func _panel_surface(panel: PanelContainer, margin: int) -> void:
	var style := _style(SURFACE, RULE)
	style.set_content_margin_all(margin)
	panel.add_theme_stylebox_override("panel", style)
