extends Control

const Story := preload("res://scripts/story.gd")
const AppIcon := preload("res://scripts/app_icon.gd")
const PixelArt := preload("res://scripts/pixel_art.gd")
const INK := Color("293f40")
const MUTED := Color("77817c")
const CORAL := Color("285552")
const SURFACE := Color("fffdf8")
const PAPER := Color("f0eee7")
const RULE := Color("d0d8ce")
const SECTION_NAMES := {"Home": "News Feed", "Calendar": "Events"}
var profile_view := false
var feed_view := false
var friends_view := false
var comments_open := ""
var story := Story.new()
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
var banner_id := ""
var banner_timer: Timer
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

func _ready() -> void:
	get_tree().auto_accept_quit = false
	RenderingServer.set_default_clear_color(PAPER)
	sfx = AudioStreamPlayer.new()
	sfx.name = "InterfaceSounds"
	sfx.max_polyphony = 4
	add_child(sfx)
	for cue: String in ["tap", "sent", "received"]:
		sounds[cue] = _sound(cue)
	banner_timer = Timer.new()
	banner_timer.one_shot = true
	banner_timer.wait_time = 5
	banner_timer.timeout.connect(func() -> void: banner_id = ""; _refresh_overlay())
	add_child(banner_timer)
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
	story.load_from("user://autosave.json")
	status = ""
	ui = Control.new()
	ui.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	ui.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(ui)
	resized.connect(_layout)
	_render()
	if not story.state.notifications.is_empty():
		var latest: Dictionary = story.state.notifications.back()
		if not latest.read:
			_announce.call_deferred()

func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_RESUMED and is_instance_valid(delivery_timer):
		suspended = false
		dots_timer.start()
		if draft_tween and draft_tween.is_valid(): draft_tween.play()
		_sync_presentation.call_deferred()
	if what in [NOTIFICATION_APPLICATION_PAUSED, NOTIFICATION_WM_CLOSE_REQUEST] and is_instance_valid(ui):
		suspended = true
		delivery_timer.stop()
		dots_timer.stop()
		if draft_tween and draft_tween.is_valid(): draft_tween.pause()
		_remember()
		story.save_to("user://autosave.json")
		if what == NOTIFICATION_WM_CLOSE_REQUEST:
			get_tree().quit()

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if notification_center:
			_close_notifications()
		else:
			_open("Home")
		get_viewport().set_input_as_handled()
func _style(color: Color, border := Color.TRANSPARENT) -> StyleBoxFlat:
	var box := StyleBoxFlat.new()
	box.bg_color = color
	box.border_color = border
	box.set_border_width_all(1 if border.a > 0 else 0)
	box.set_corner_radius_all(2)
	box.content_margin_left = 12
	box.content_margin_right = 12
	box.content_margin_top = 8
	box.content_margin_bottom = 8
	return box

func _theme() -> Theme:
	var result := Theme.new()
	result.default_font_size = 16
	result.set_color("font_color", "Label", INK)
	result.set_color("font_color", "Button", CORAL)
	result.set_color("font_hover_color", "Button", INK)
	result.set_color("font_focus_color", "Button", CORAL)
	result.set_stylebox("normal", "Button", _style(SURFACE, RULE))
	result.set_stylebox("hover", "Button", _style(Color("e5eee6"), CORAL))
	result.set_stylebox("pressed", "Button", _style(Color("d4e2d8"), CORAL))
	var focus := _style(Color.TRANSPARENT, INK)
	focus.set_border_width_all(2)
	result.set_stylebox("focus", "Button", focus)
	result.set_stylebox("disabled", "Button", _style(PAPER, RULE))
	result.set_color("font_disabled_color", "Button", MUTED)
	result.set_constant("separation", "VBoxContainer", 10)
	result.set_constant("separation", "HBoxContainer", 10)
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

func _card(title: String, copy: String, parent: Node = null) -> VBoxContainer:
	var panel := PanelContainer.new()
	var card_style := _style(SURFACE, RULE)
	panel.add_theme_stylebox_override("panel", card_style)
	(parent if parent != null else body).add_child(panel)
	var stack := VBoxContainer.new()
	panel.add_child(stack)
	if title != "":
		stack.add_child(_label(title, 13, CORAL))
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
	if is_instance_valid(scroller) and saved_app != "":
		story.state.scroll[saved_app] = scroller.scroll_vertical

func _open(app: String) -> void:
	if app not in Story.APPS:
		return
	delivery_timer.stop()
	if draft_tween and draft_tween.is_valid(): draft_tween.kill()
	draft_typing = false
	profile_view = false
	feed_view = false
	friends_view = false
	view_thread = ""
	inbox = false
	_remember()
	var previous: String = story.state.app
	story.state.app = app
	notification_center = false
	banner_id = ""
	banner_timer.stop()
	story.mark_app_read(app)
	confirm_later = false
	confirm_restart = false
	status = ""
	_render()
	_autosave()
	if previous != app:
		_animate_open()

func _layout() -> void:
	if not is_instance_valid(frame): return
	frame.scale = Vector2.ONE
	frame.position = Vector2.ZERO
	# Rebuild only when crossing a responsive column threshold.
	var columns := 3 if size.x >= 1060 else 2 if size.x >= 720 else 1
	if int(frame.get_meta("columns", columns)) != columns:
		_remember()
		_render.call_deferred(false)

func _render(refocus := true) -> void:
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
	frame.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var columns := 3 if size.x >= 1060 else 2 if size.x >= 720 else 1
	frame.set_meta("columns", columns)
	ui.add_child(frame)
	screen = PanelContainer.new()
	screen.name = "Website"
	screen.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var surface := _style(PAPER)
	surface.set_content_margin_all(0)
	screen.add_theme_stylebox_override("panel", surface)
	frame.add_child(screen)
	var column := VBoxContainer.new()
	column.add_theme_constant_override("separation", 0)
	screen.add_child(column)
	_status_bar(column)
	if columns == 1:
		var tabs_scroll := ScrollContainer.new()
		tabs_scroll.custom_minimum_size.y = 44
		tabs_scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
		column.add_child(tabs_scroll)
		var tabs := HBoxContainer.new()
		tabs_scroll.add_child(tabs)
		for app: String in ["Home", "Messages", "Games", "Work", "Photos", "Calendar", "Notes", "Settings"]:
			_section_link(app, tabs)
	var margin := MarginContainer.new()
	margin.size_flags_vertical = Control.SIZE_EXPAND_FILL
	for edge: String in ["left", "right", "top", "bottom"]:
		margin.add_theme_constant_override("margin_" + edge, 20 if columns > 1 else 8)
	column.add_child(margin)
	var layout := HBoxContainer.new()
	layout.add_theme_constant_override("separation", 20)
	margin.add_child(layout)
	if columns > 1: _sidebar(layout)
	var center := VBoxContainer.new()
	center.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	layout.add_child(center)
	if story.state.app != "Home" or profile_view or feed_view or friends_view:
		center.add_child(_label("My Profile" if profile_view else "Friends" if friends_view else "News Feed" if feed_view else _section_name(story.state.app), 20, CORAL))
	if status != "": center.add_child(_label(status, 13, CORAL))
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
	if profile_view:
		_profile()
	elif feed_view:
		_feed()
	elif friends_view:
		_friends()
	else:
		match story.state.app:
			"Home": _home()
			"Messages", "Games": _conversation()
			"Work": _desk()
			"Photos": _gallery()
			"Calendar": _calendar()
			"Settings": _settings()
			"Notes": _notes()
	if columns == 3: _contacts(layout)
	_refresh_overlay()
	_layout.call_deferred()
	saved_app = story.state.app
	_restore_scroll.call_deferred(story.state.app, int(story.state.scroll.get(story.state.app, 0)))
	if refocus: _focus_first.call_deferred()
	_sync_presentation.call_deferred()

func _section_name(app: String) -> String:
	return "Home" if app == "Home" else SECTION_NAMES.get(app, app)

func _section_link(app: String, parent: Node) -> Button:
	var count: int = story.unread_count(app)
	var button := _button(_section_name(app) + ("  (%d)" % count if count > 0 else ""), _open.bind(app), parent)
	button.name = app + "Link"
	button.autowrap_mode = TextServer.AUTOWRAP_OFF
	button.alignment = HORIZONTAL_ALIGNMENT_LEFT
	button.set_meta("section", app)
	if story.state.app == app and not profile_view:
		button.add_theme_stylebox_override("normal", _style(Color("dce9df"), RULE))
	return button

func _sidebar(parent: Node) -> void:
	var side := VBoxContainer.new()
	side.name = "Navigation"
	side.custom_minimum_size.x = 176
	parent.add_child(side)
	var me := HBoxContainer.new()
	side.add_child(me)
	_avatar("asahi", me)
	var account := VBoxContainer.new()
	account.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	me.add_child(account)
	account.add_child(_label("Asahi", 16, CORAL))
	var profile := _button("My Profile", _open_profile, account)
	profile.name = "ProfileLink"
	profile.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
	for app: String in ["Home", "Messages", "Games", "Work", "Photos", "Calendar", "Notes", "Settings"]:
		_section_link(app, side)
	side.add_child(_label("THE NEXT HELLO", 12, MUTED))
	side.add_child(_label(_story_date(), 12, MUTED))

func _open_profile() -> void:
	_open("Home")
	profile_view = true
	_render()

func _avatar(who: String, parent: Node) -> void:
	var avatar := PanelContainer.new()
	avatar.custom_minimum_size = Vector2(32, 32)
	avatar.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
	var colors := {"asahi": "647b93", "mizuki": "987b92", "natsumi": "ad8862", "mossbyte": "718a73", "daichi": "718a73", "misaki": "8e789f"}
	var style := _style(Color(colors.get(who.to_lower(), "7e899c")))
	style.set_content_margin_all(4)
	avatar.add_theme_stylebox_override("panel", style)
	parent.add_child(avatar)
	var initial := _label(who.left(1).to_upper(), 16, Color.WHITE)
	initial.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	avatar.add_child(initial)

func _contacts(parent: Node) -> void:
	var side := VBoxContainer.new()
	side.name = "ChatSidebar"
	side.custom_minimum_size.x = 190
	parent.add_child(side)
	side.add_child(_label("Chat", 16, CORAL))
	for contact: String in _known_contacts():
		var row := HBoxContainer.new()
		side.add_child(row)
		_avatar(contact, row)
		_button(contact, _open_contact.bind(contact), row)
	if _known_contacts().is_empty(): side.add_child(_label("No conversations yet.", 13, MUTED))
	side.add_child(_label("Private conversations", 12, MUTED))
	side.add_child(_label("Read receipts show a message was opened. Replies can wait.", 13, MUTED))

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
	var header_style := _style(CORAL, Color("193b39"))
	header_style.set_content_margin_all(8)
	header_style.border_width_bottom = 3
	header_style.border_color = Color("b77b67")
	bar.add_theme_stylebox_override("panel", header_style)
	column.add_child(bar)
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 16)
	bar.add_child(row)
	var logo := _button("hello", _open.bind("Home"), row)
	logo.name = "SiteLogo"
	logo.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
	logo.custom_minimum_size.x = 100
	logo.autowrap_mode = TextServer.AUTOWRAP_OFF
	logo.add_theme_font_size_override("font_size", 26)
	for state: String in ["font_color", "font_focus_color", "font_hover_color", "font_pressed_color"]:
		logo.add_theme_color_override(state, Color("fff8e9"))
	logo.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
	var spacer := Control.new()
	spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(spacer)
	var notices := _button("Notifications", _show_notifications, row)
	notices.name = "Notifications"
	notices.size_flags_horizontal = Control.SIZE_SHRINK_END
	notices.autowrap_mode = TextServer.AUTOWRAP_OFF
	var me := _button("Asahi" if size.x >= 720 else "Me", _open_profile, row)
	me.size_flags_horizontal = Control.SIZE_SHRINK_END
	me.autowrap_mode = TextServer.AUTOWRAP_OFF
	me.custom_minimum_size.x = 60

func _animate_open() -> void:
	if reduce_motion: return
	screen.modulate.a = 0.8
	transition = create_tween()
	transition.tween_property(screen, "modulate:a", 1.0, 0.12)

func _show_notifications() -> void:
	_remember()
	notification_center = true
	banner_id = ""
	banner_timer.stop()
	_refresh_overlay()

func _close_notifications() -> void:
	notification_center = false
	_refresh_overlay()

func _announce() -> void:
	if story.state.notifications.is_empty():
		return
	banner_id = story.state.notifications.back().id
	_play_sound("received")
	_refresh_overlay()
	banner_timer.start()
	_autosave()

func _refresh_overlay() -> void:
	if not is_instance_valid(frame):
		return
	_refresh_app_badges()
	var old := frame.get_node_or_null("NotificationOverlay")
	if old:
		frame.remove_child(old)
		old.queue_free()
	for button: Node in frame.find_children("*", "Button", true, false):
		button.focus_mode = Control.FOCUS_NONE if notification_center else Control.FOCUS_ALL
	if not notification_center and banner_id == "":
		return
	var layer := Control.new()
	layer.name = "NotificationOverlay"
	layer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	layer.mouse_filter = Control.MOUSE_FILTER_STOP if notification_center else Control.MOUSE_FILTER_IGNORE
	frame.add_child(layer)
	var overlay := PanelContainer.new()
	overlay.name = "NotificationCard"
	overlay.position = Vector2(maxf(8, frame.size.x - minf(380, frame.size.x - 16) - 16), 62)
	overlay.size = Vector2(minf(380, frame.size.x - 24), 0)
	var glass := _style(SURFACE)
	glass.set_corner_radius_all(4)
	overlay.add_theme_stylebox_override("panel", glass)
	layer.add_child(overlay)
	_panel_surface(overlay, 16)
	var stack := VBoxContainer.new()
	overlay.add_child(stack)
	if notification_center:
		overlay.size.y = maxf(180, frame.size.y - 90)
		stack.add_child(_label("Notifications", 20, CORAL))
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
			var notification: Dictionary = story.state.notifications[i]
			_button(("● " if not notification.read else "") + _section_name(notification.app) + "\n" + story.text(notification.text), _open.bind(notification.app), list)
		_button("Mark all as read", _mark_notifications_read, stack)
		return
	for notification: Dictionary in story.state.notifications:
		if notification.id == banner_id:
			stack.add_child(_label(_section_name(notification.app) + "  /  new update", 12, MUTED))
			_button(story.text(notification.text), _open.bind(notification.app), stack)
			_button("Dismiss", func() -> void: banner_id = ""; _refresh_overlay(), stack)

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

func _play_sound(cue: String) -> void:
	if sound_volume <= 0 or not sounds.has(cue):
		return
	sfx.stream = sounds[cue]
	sfx.volume_db = linear_to_db(sound_volume)
	sfx.play()

func _sound(cue: String) -> AudioStreamWAV:
	var duration := 0.045 if cue == "tap" else 0.3
	var samples := PackedByteArray()
	var rate := 22050
	var count := int(rate * duration)
	samples.resize(count * 2)
	for i in count:
		var t := float(i) / rate
		var frequency := 680.0 if cue == "tap" else (880.0 if cue == "sent" else 1046.5)
		if cue == "received" and t > 0.13:
			frequency = 1318.5
		var envelope := minf(t / 0.005, 1) * exp(-t * (80 if cue == "tap" else 13)) * minf((duration - t) / 0.01, 1)
		var sample := sin(TAU * frequency * t) * envelope * 0.16
		samples.encode_s16(i * 2, int(sample * 32767))
	var wav := AudioStreamWAV.new()
	wav.format = AudioStreamWAV.FORMAT_16_BITS
	wav.mix_rate = rate
	wav.data = samples
	return wav

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
	body.add_child(_label("Welcome back, Asahi", 22, CORAL))
	_button("Continue in " + _section_name(story.current().app) + "  /  " + story.text(story.current().title), _open.bind(story.current().app))
	var menu := _card("", "")
	var grid := GridContainer.new()
	grid.name = "SectionGrid"
	grid.columns = 3
	grid.add_theme_constant_override("h_separation", 10)
	grid.add_theme_constant_override("v_separation", 14)
	menu.add_child(grid)
	_menu_tile("News Feed", "Home", _show_feed, grid)
	_menu_tile("Profile", "Profile", _open_profile, grid)
	_menu_tile("Friends", "Friends", _show_friends, grid)
	for section: String in ["Photos", "Calendar", "Messages", "Games", "Work", "Notes"]:
		_menu_tile(_section_name(section), section, _open.bind(section), grid)
	var shelf := _card("MY PHOTO SHELF / PRIVATE", "")
	var thumbnails := HBoxContainer.new()
	shelf.add_child(thumbnails)
	_art("city", thumbnails, 110)
	if story.state.facts.get("screenshot", false): _art("lantern", thumbnails, 110)
	if story.state.facts.get("first_meeting", false): _art("city", thumbnails, 110)
	_button("Open Photos", _open.bind("Photos"), shelf)
	var footer := HBoxContainer.new()
	body.add_child(footer)
	_button("Notifications", _show_notifications, footer)
	_button("Settings", _open.bind("Settings"), footer)

func _menu_tile(label: String, icon_key: String, action: Callable, parent: Node) -> void:
	var tile := VBoxContainer.new()
	tile.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	parent.add_child(tile)
	var icon := Button.new()
	icon.set_script(AppIcon)
	icon.app = icon_key
	icon.badge_count = story.unread_count(icon_key) if icon_key in Story.APPS else 0
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
	var caption := _label(label, 14, INK)
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
	body.add_child(_label("People I've met", 20, CORAL))
	if _known_contacts().is_empty():
		body.add_child(_label("New conversations will appear here after we meet."))
	for contact: String in _known_contacts():
		var card := _card(contact, "Private conversation")
		_button("Message " + contact, _open_contact.bind(contact), card)
	body.add_child(_label("Lantern Quest matches players at random. My contacts don't introduce me to Mizuki.", 13, MUTED))

func _feed() -> void:
	var heading := HBoxContainer.new()
	body.add_child(heading)
	heading.add_child(_label("News Feed", 22, CORAL))
	var date := _label(_story_date(), 12, MUTED)
	date.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	heading.add_child(date)
	var current := _card("PICK UP WHERE I LEFT OFF", story.text(story.current().title))
	_button("Continue in " + _section_name(story.current().app) + "  >", _open.bind(story.current().app), current)
	var composer := _card("ASAHI", "A little space for the things worth keeping.")
	_button("Write a private note", _open.bind("Notes"), composer)
	_feed_post("feed_window", "Asahi", "Tokyo. Rain again. At least the view is doing something with it.", "city", "Only me", "Still haven't bought a plant for this window.")
	if "natsumi_invite" in story.state.consumed:
		_feed_post("feed_prints", "Natsumi", "Finally getting these prints onto a wall. Still taking suggestions for how to hang anything straight.", "desk", "Friends", "Asahi: I can offer a book and very little expertise.")
	if "guild_plan" in story.state.consumed:
		_feed_post("feed_garden", "Daichi", "Small garden party. New players welcome. We wait at the bridge.", "lantern", "Lantern Quest community", "Route notes are in Games. No one needs to rush.")
	body.add_child(_label("You're caught up. Private conversations stay in Messages.", 13, MUTED))

func _feed_post(id: String, author: String, copy: String, art: String, audience: String, comment: String) -> void:
	var post := _card("", "")
	var header := HBoxContainer.new()
	post.add_child(header)
	_avatar(author, header)
	var byline := VBoxContainer.new()
	byline.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header.add_child(byline)
	byline.add_child(_label(author, 16, CORAL))
	byline.add_child(_label(audience + " / Saved update", 12, MUTED))
	post.add_child(_label(copy))
	_art(art, post, 160)
	var actions := HBoxContainer.new()
	post.add_child(actions)
	_like_button(id, actions)
	_button("Hide comment" if comments_open == id else "Comment", func() -> void: _remember(); comments_open = "" if comments_open == id else id; _render(), actions)
	if comments_open == id: post.add_child(_label(comment, 14, MUTED))

func _profile() -> void:
	var profile := _card("MY PROFILE", "Tachibana Asahi\nasahi / Tokyo, Japan")
	_art("city", profile, 150)
	profile.add_child(_label("Usually here after work. Occasionally lost in Lantern Quest.", 16))
	_button("My photos", _open.bind("Photos"), profile)
	_button("My notes", _open.bind("Notes"), profile)
	_card("PRIVATE / MY NEXT PLAN", story.state.facts.get("commitment", "Nothing confirmed yet."))
	body.add_child(_label("My conversations", 18, CORAL))
	for contact: String in _known_contacts(): _button(contact, _open_contact.bind(contact))

func _notes() -> void:
	var journal: Dictionary = story.journal()
	body.add_child(_label("MY NOTES", 11, CORAL))
	body.add_child(_label("Small things to remember", 26))
	body.add_child(_label("Things I don't want to forget.", 14, MUTED))
	_card("CHAPTER %d" % int(journal.chapter), journal.title)
	var objective := _card("FOR LATER" if journal.complete else "NEXT", journal.objective)
	var bookmark := _style(SURFACE, RULE)
	bookmark.border_width_left = 4
	bookmark.border_color = CORAL
	(objective.get_parent() as PanelContainer).add_theme_stylebox_override("panel", bookmark)
	if journal.draft_pending:
		objective.add_child(_label("I still have a reply in drafts.", 14, CORAL))
	_button(("Read in " if journal.complete else "Continue in ") + journal.app + "  >", _open.bind(journal.app), objective)
	if not journal.completed.is_empty():
		body.add_child(_label("Earlier", 20))
		for entry: Dictionary in journal.completed:
			_card("✓ CHAPTER %d" % int(entry.chapter), entry.title)
	if journal.complete:
		body.add_child(_label("Story complete", 13, MUTED))

func _thread() -> String:
	if story.state.app == "Games": return "Lantern Quest"
	if story.state.app == "Work": return "Hoshino Studio"
	if story.state.app != "Messages": return story.current().thread
	if view_thread != "": return view_thread
	if story.current().app == "Messages": return story.current().thread
	for i in range(story.state.log.size() - 1, -1, -1):
		if story.state.log[i].app == "Messages": return story.state.log[i].thread
	return "Mizuki"

func _conversation() -> void:
	if story.state.app == "Games":
		_art("lantern")
		body.add_child(_label("LANTERN QUEST", 12, CORAL))
	elif inbox:
		body.add_child(_label("Conversations", 22))
		for thread: String in story.threads():
			_button(thread, func() -> void: view_thread = thread; inbox = false; _render())
		if story.threads().is_empty(): body.add_child(_label("No conversations yet.", 14, MUTED))
		return
	else:
		body.add_child(_label(_thread(), 22))
		_button("Conversations", func() -> void: inbox = true; delivery_timer.stop(); _render())
	_render_thread()

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
			var card := _card("Me" if speaker == "asahi" else speaker.capitalize(), story.text(entry.text), row)
			var panel := card.get_parent() as PanelContainer
			panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			panel.size_flags_stretch_ratio = 5
			var bubble := _style(Color("dce9df") if speaker == "asahi" else SURFACE, RULE)
			bubble.set_corner_radius_all(8)
			bubble.corner_radius_top_right = 1 if speaker == "asahi" else 8
			bubble.corner_radius_top_left = 8 if speaker == "asahi" else 1
			panel.add_theme_stylebox_override("panel", bubble)
			if speaker != "asahi": row.add_child(spacer)
			if entry.has("delivery"): card.add_child(_label(entry.delivery, 11, MUTED))
	if story.state.app != story.current().app or _thread() != story.current().thread:
		_button("Continue in " + _section_name(story.current().app) + "  >", _open.bind(story.current().app))
	else:
		_story_controls()

func _can_present() -> bool:
	return not suspended and not inbox and story.state.app == story.current().app and _thread() == story.current().thread and story.state.app in ["Messages", "Games", "Work", "Calendar"]

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
	return clampf(0.55 + story.text(entry.text).length() * 0.012, 0.65, 1.8)

func _delivery_tick() -> void:
	if not _can_present(): return
	var follow := scroller.scroll_vertical >= scroller.get_v_scroll_bar().max_value - scroller.size.y - 32
	_remember()
	story.advance_delivery()
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
			return entry.speaker.capitalize() + " is typing" + ".".repeat(dots + 1)
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
	# Type in short bursts, hesitating at clause boundaries. The selected wording
	# remains intact; presentation must never substitute a different decision.
	var start := 0
	for index: int in range(label.text.length()):
		var character := label.text[index]
		var boundary := character in [",", ".", "?", "!", ";"]
		if boundary or index == label.text.length() - 1:
			var end := index + 1
			draft_tween.tween_property(label, "visible_characters", end, maxf(0.06, (end - start) * 0.022))
			if boundary and end < label.text.length(): draft_tween.tween_interval(0.22)
			start = end
	draft_tween.finished.connect(_finish_typing)

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
		body.add_child(_label("CHOOSE A DRAFT  /  Nothing sends until you say so", 11, CORAL))
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
		_button("Review your Calendar", _open.bind("Calendar"))

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
	if story.send():
		view_thread = ""
		inbox = false
		_play_sound("sent")
		story.state.app = story.current().app
		story.mark_app_read(story.state.app)
		_autosave()
		_render()
		_scroll_bottom.call_deferred()
		get_tree().create_timer(0.22).timeout.connect(_announce)

func _later() -> void:
	if story.later():
		view_thread = ""
		inbox = false
		story.state.app = story.current().app
		story.mark_app_read(story.state.app)
		confirm_later = false
		_autosave()
		_render()
		_scroll_bottom.call_deferred()
		_announce()

func _scroll_bottom() -> void:
	scroller.scroll_vertical = int(scroller.get_v_scroll_bar().max_value)

func _autosave() -> void:
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
	return story.current().timestamp

func _desk() -> void:
	_card("HOSHINO STUDIO / TEAM", "Handoff checklist\n• Check the exported layouts\n• Leave clear notes for Monday\n• Close the laptop at a sensible hour")
	if story.current().app == "Work":
		_render_thread()
	else:
		_card("YOUR AVAILABILITY", story.state.facts.get("work", "Friday handoff check or Sunday review. A work decision becomes playable if you choose an everyday-life call with Mizuki."))
		_like_button("work_checklist", body, "Pin checklist")
		_button("See commitments in Calendar", _open.bind("Calendar"))

func _gallery() -> void:
	var photo := _card("TOKYO WINDOW  /  Your photo", "Rain against your apartment window; warm squares of light in the building across the street.")
	_art("city", photo)
	_like_button("tokyo_window", photo, "Favorite photo")
	if story.state.facts.get("screenshot", false):
		photo = _card("THE FIRST PARTY  /  Shared memory", "Two small lanterns in a ruined garden. Saved after your first session with mizuki.")
		_art("lantern", photo)
	if story.state.facts.get("desk_photo", false) and not story.state.facts.get("draft_withdrawn", false):
		photo = _card("MIZUKI'S DESK  /  Private. Do not publish.", "A mug full of pens, an unfinished illustration on a laptop, and rain against the window. Mizuki asked to keep this between you.")
		_art("desk", photo)
		_button("Return to Mizuki's message", _open.bind("Messages"), photo)
	if story.state.facts.get("postcard", false):
		photo = _card("TWO WINDOWS  /  Private shared collection", "Your Tokyo skyline beside Mizuki's line drawing. Made in quiet company. Sharing permission stays private.")
		_art("city", photo)
		_art("desk", photo)
	if story.state.facts.get("draft_withdrawn", false):
		_card("WITHDRAWN WORK DRAFT", "Mizuki removed this image from the shared collection. The private postcard remains available.")
	for photo_id: String in story.state.facts.get("photo_ids", []):
		var item: Dictionary = story.content.photos.get(photo_id, {})
		if not item.is_empty():
			photo = _card(item.title, item.copy)
			_art(item.kind, photo)
	body.add_child(_label("Descriptions are part of every image. No detail hunt is required.", 12, MUTED))

func _calendar() -> void:
	body.add_child(_label("Room for what matters", 25))
	_card("TODAY", _story_date())
	_card("MY PLANS", story.state.facts.get("commitment", "Nothing confirmed yet."))
	if story.state.facts.has("work"):
		_card("WORK", story.state.facts.work)
	if story.state.facts.has("memory"):
		_card("A MEMORY TO KEEP", story.state.facts.memory)
	if story.current().app == "Calendar":
		_render_thread()
	else:
		_button("Continue your story  >", _open.bind(story.current().app))
	body.add_child(_label("Only a labeled story transition advances time. Reading slowly never breaks a promise.", 13, MUTED))

func _settings() -> void:
	body.add_child(_label("Make yourself comfortable", 24))
	_card("MY ACCOUNT", "Tachibana Asahi\nasahi\nTokyo, Japan")
	_card("DISPLAY & READING", "The site adapts to your window. Use the section links to browse and the chat list for private conversations. Your story waits while you read.")
	_button("Instant messages: " + ("On" if instant_messages else "Off"), func() -> void: instant_messages = not instant_messages; _save_settings(); _render())
	_button("Reduce motion: " + ("On" if reduce_motion else "Off"), func() -> void: reduce_motion = not reduce_motion; _save_settings(); _render())
	body.add_child(_label("WINDOW RESOLUTION", 12, CORAL))
	for resolution: Vector2i in [Vector2i(1280, 720), Vector2i(1280, 900), Vector2i(1920, 1080), Vector2i(2560, 1440), Vector2i(480, 1040)]:
		_button("%d × %d" % [resolution.x, resolution.y], _set_resolution.bind(resolution))
	body.add_child(_label("NOTIFICATIONS & INTERFACE SOUNDS", 12, CORAL))
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
	story.reset()
	confirm_restart = false
	saved_app = ""
	status = "A new evening."
	_autosave()
	_render()

func _load_game(path: String) -> void:
	if story.load_from(path):
		status = story.last_error if story.last_error != "" else "Save restored."
		saved_app = ""
	else:
		status = story.last_error
	_render()

func _save_settings() -> void:
	var settings := ConfigFile.new()
	settings.set_value("audio", "interface_volume", sound_volume)
	settings.set_value("display", "reduce_motion", reduce_motion)
	settings.set_value("reading", "instant_messages", instant_messages)
	settings.save("user://settings.cfg")

func _load_settings() -> void:
	var settings := ConfigFile.new()
	if settings.load("user://settings.cfg") == OK:
		sound_volume = clampf(float(settings.get_value("audio", "interface_volume", 0.55)), 0.0, 1.0)
		reduce_motion = bool(settings.get_value("display", "reduce_motion", false))
		instant_messages = bool(settings.get_value("reading", "instant_messages", false))

func _set_resolution(resolution: Vector2i) -> void:
	get_window().size = resolution
	_layout()
	_save_settings()

func _panel_surface(panel: PanelContainer, margin: int) -> void:
	var style := _style(SURFACE, RULE)
	style.set_content_margin_all(margin)
	panel.add_theme_stylebox_override("panel", style)
