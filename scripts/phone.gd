extends Control

const Story := preload("res://scripts/story.gd")
const PixelArt := preload("res://scripts/pixel_art.gd")
const AppIcon := preload("res://scripts/app_icon.gd")
const PaperShader := preload("res://shaders/paper.gdshader")
const PHONE_SIZE := Vector2(414, 896)
const INK := Color("26354a")
const MUTED := Color("68675f")
const CORAL := Color("a64e43")
const SURFACE := Color("fff8e9")
const PAPER := Color("f1e5ce")
const RULE := Color("cfbea0")
const TRACKS := ["Window seat", "Two small lanterns", "After the rain", "A little closer"]
const APP_MARKS := ["", "...", "+", "o", "~", ">", "II", "=", "#", "[]", "31"]
var story := Story.new()
var ui: Control
var frame: Control
var screen: PanelContainer
var body: VBoxContainer
var scroller: ScrollContainer
var player: AudioStreamPlayer
var volume := 0.35
var status := ""
var confirm_restart := false
var confirm_later := false
var clip_index := 0
var clip_frame := 0
var saved_app := ""
var home_page := 0
var notification_center := false
var banner_id := ""
var banner_timer: Timer
var sfx: AudioStreamPlayer
var sound_volume := 0.55
var reduce_motion := false
var reduce_transparency := false
var transition: Tween
var gesture_start := Vector2.ZERO
var gesture_active := false
var gesture_dragged := false
var gesture_scroll := 0
var gesture_can_scroll := false
var sounds: Dictionary = {}

func _ready() -> void:
	get_tree().auto_accept_quit = false
	RenderingServer.set_default_clear_color(Color("10151c"))
	player = AudioStreamPlayer.new()
	player.name = "Music"
	add_child(player)
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
	_load_settings()
	story.load_from("user://autosave.json")
	status = ""
	ui = Control.new()
	ui.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	ui.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(ui)
	resized.connect(_layout)
	_render()
	_sync_music()
	if not story.state.notifications.is_empty():
		var latest: Dictionary = story.state.notifications.back()
		if not latest.read:
			_announce.call_deferred()

func _notification(what: int) -> void:
	if what in [NOTIFICATION_APPLICATION_PAUSED, NOTIFICATION_WM_CLOSE_REQUEST] and is_instance_valid(ui):
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
	elif story.state.app == "Home" and event.is_action_pressed("ui_right"):
		_change_page(1)
	elif story.state.app == "Home" and event.is_action_pressed("ui_left"):
		_change_page(-1)

func _style(color: Color, border := Color.TRANSPARENT) -> StyleBoxFlat:
	var box := StyleBoxFlat.new()
	box.bg_color = color
	box.border_color = border
	box.set_border_width_all(1 if border.a > 0 else 0)
	box.set_corner_radius_all(5)
	box.content_margin_left = 16
	box.content_margin_right = 16
	box.content_margin_top = 12
	box.content_margin_bottom = 12
	return box

func _theme() -> Theme:
	var result := Theme.new()
	result.default_font_size = 16
	result.set_color("font_color", "Label", INK)
	result.set_color("font_color", "Button", CORAL)
	result.set_color("font_hover_color", "Button", INK)
	result.set_color("font_focus_color", "Button", CORAL)
	result.set_stylebox("normal", "Button", _style(SURFACE, RULE))
	result.set_stylebox("hover", "Button", _style(Color("f4dfc4"), CORAL))
	result.set_stylebox("pressed", "Button", _style(Color("e9c7ad"), CORAL))
	var focus := _style(Color.TRANSPARENT, INK)
	focus.set_border_width_all(2)
	result.set_stylebox("focus", "Button", focus)
	result.set_stylebox("disabled", "Button", _style(PAPER, RULE))
	result.set_color("font_disabled_color", "Button", MUTED)
	result.set_constant("separation", "VBoxContainer", 12)
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
	button.custom_minimum_size.y = 48
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	button.pressed.connect(func() -> void: _play_sound("tap"))
	button.pressed.connect(action)
	(parent if parent != null else body).add_child(button)
	return button

func _card(title: String, copy: String, parent: Node = null) -> VBoxContainer:
	var panel := PanelContainer.new()
	var card_style := _style(SURFACE, RULE)
	card_style.shadow_color = Color(0.15, 0.17, 0.20, 0.08)
	card_style.shadow_size = 2
	card_style.shadow_offset = Vector2(0, 2)
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
	if not is_instance_valid(frame):
		return
	var factor := maxf(0.05, minf(size.x / PHONE_SIZE.x, size.y / PHONE_SIZE.y))
	frame.size = PHONE_SIZE
	frame.scale = Vector2.ONE * factor
	frame.position = (size - PHONE_SIZE * factor) / 2

func _render() -> void:
	if transition and transition.is_valid():
		transition.kill()
	for child: Node in ui.get_children():
		ui.remove_child(child)
		child.queue_free()
	ui.theme = _theme()
	frame = Control.new()
	frame.name = "Device"
	ui.add_child(frame)
	var bezel := Panel.new()
	bezel.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var shell := _style(INK, Color("a8a391"))
	shell.set_border_width_all(2)
	shell.set_corner_radius_all(24)
	bezel.add_theme_stylebox_override("panel", shell)
	bezel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	frame.add_child(bezel)
	screen = PanelContainer.new()
	screen.name = "Screen"
	screen.position = Vector2(10, 10)
	screen.size = PHONE_SIZE - Vector2(20, 20)
	screen.clip_contents = true
	var surface := _style(PAPER)
	surface.set_corner_radius_all(16)
	surface.set_content_margin_all(0)
	screen.add_theme_stylebox_override("panel", surface)
	frame.add_child(screen)
	if story.state.app == "Home":
		var wallpaper := TextureRect.new()
		wallpaper.texture = load("res://assets/ui/wallpaper.svg")
		var wallpaper_material := ShaderMaterial.new()
		wallpaper_material.shader = preload("res://shaders/rounded_wallpaper.gdshader")
		wallpaper.material = wallpaper_material
		wallpaper.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		wallpaper.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		wallpaper.mouse_filter = Control.MOUSE_FILTER_IGNORE
		screen.add_child(wallpaper)
	var margins := MarginContainer.new()
	for edge: String in ["left", "right"]:
		margins.add_theme_constant_override("margin_" + edge, 16)
	margins.add_theme_constant_override("margin_top", 8)
	margins.add_theme_constant_override("margin_bottom", 8)
	screen.add_child(margins)
	var column := VBoxContainer.new()
	column.name = "ScreenColumn"
	margins.add_child(column)
	_status_bar(column)
	if story.state.app != "Home":
		var header := HBoxContainer.new()
		var navigation := PanelContainer.new()
		column.add_child(navigation)
		_paper_surface(navigation, 4)
		navigation.add_child(header)
		var back := _button("‹ Home", func() -> void: _open("Home"), header)
		back.autowrap_mode = TextServer.AUTOWRAP_OFF
		back.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		back.custom_minimum_size.x = 48
		header.add_child(_label(story.state.app, 22))
	if status != "":
		column.add_child(_label(status, 13, CORAL))
	scroller = ScrollContainer.new()
	scroller.name = "ContentScroll"
	scroller.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroller.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	scroller.follow_focus = true
	column.add_child(scroller)
	body = VBoxContainer.new()
	body.name = "Content"
	body.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroller.add_child(body)
	match story.state.app:
		"Home": _home()
		"Messages", "Lantern Quest": _conversation()
		"Moments": _moments()
		"Resonance": _resonance()
		"Vista", "Loop": _videos()
		"Bookmark": _books()
		"Desk": _desk()
		"Gallery": _gallery()
		"Calendar": _calendar()
		"Settings": _settings()
		"Notes": _notes()
	if story.state.track >= 0:
		var music_glass := PanelContainer.new()
		column.add_child(music_glass)
		_paper_surface(music_glass, 3)
		var music_button := _button(("Pause  /  " if player.playing else "Play  /  ") + TRACKS[int(story.state.track)], _toggle_music, music_glass)
		music_button.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
	var dock := VBoxContainer.new()
	dock.name = "Dock"
	column.add_child(dock)
	if story.state.app == "Home":
		_home_dock(dock)
	var home := _button("", _open.bind("Home"), dock)
	home.name = "HomeIndicator"
	home.tooltip_text = "Home / swipe up from the bottom"
	home.custom_minimum_size.y = 26
	for state_name: String in ["normal", "hover", "pressed"]:
		home.add_theme_stylebox_override(state_name, StyleBoxEmpty.new())
	var pill := Panel.new()
	pill.mouse_filter = Control.MOUSE_FILTER_IGNORE
	pill.position = Vector2(116, 13)
	pill.size = Vector2(130, 4)
	pill.add_theme_stylebox_override("panel", _style(SURFACE if story.state.app == "Home" else INK))
	home.add_child(pill)
	_refresh_overlay()
	_layout.call_deferred()
	saved_app = story.state.app
	_restore_scroll.call_deferred(story.state.app, int(story.state.scroll.get(story.state.app, 0)))
	_focus_first.call_deferred()

func _focus_first() -> void:
	var buttons := frame.find_children("*", "Button", true, false)
	if not buttons.is_empty():
		buttons[0].grab_focus()

func _restore_scroll(app: String, value: int) -> void:
	if story.state.app == app and is_instance_valid(scroller):
		scroller.scroll_vertical = value

func _status_bar(column: VBoxContainer) -> void:
	var bar := Control.new()
	bar.custom_minimum_size.y = 46
	column.add_child(bar)
	var time := _label(_story_date().right(5), 16, INK)
	time.add_theme_font_size_override("font_size", 16)
	time.position = Vector2(12, 9)
	time.size = Vector2(70, 24)
	bar.add_child(time)
	var signal_name := _label("JPN", 11, MUTED)
	signal_name.position = Vector2(126, 13)
	signal_name.size = Vector2(116, 24)
	signal_name.autowrap_mode = TextServer.AUTOWRAP_OFF
	signal_name.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	signal_name.add_theme_font_size_override("font_size", 11)
	bar.add_child(signal_name)
	var notifications := _button("•••  82%", _show_notifications, bar)
	notifications.name = "Notifications"
	notifications.tooltip_text = "Notification Center / swipe down from the top"
	notifications.position = Vector2(254, 0)
	notifications.size = Vector2(104, 42)
	notifications.custom_minimum_size.y = 42
	notifications.add_theme_font_size_override("font_size", 14)
	notifications.add_theme_color_override("font_color", INK)
	notifications.add_theme_stylebox_override("normal", StyleBoxEmpty.new())

func _app_tile(app: String, parent: Node, with_label := true) -> void:
	var tile := VBoxContainer.new()
	tile.custom_minimum_size.x = 82
	tile.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	tile.add_theme_constant_override("separation", 3)
	parent.add_child(tile)
	var icon := Button.new()
	icon.set_script(AppIcon)
	icon.app = app
	icon.name = app.replace(" ", "") + "Icon"
	icon.tooltip_text = "Open " + app
	icon.custom_minimum_size = Vector2(72, 72)
	icon.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	icon.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	icon.badge_count = story.unread_count(app)
	if icon.badge_count > 0:
		icon.tooltip_text += " / %d new updates" % icon.badge_count
	for state_name: String in ["normal", "hover", "pressed", "focus"]:
		icon.add_theme_stylebox_override(state_name, StyleBoxEmpty.new())
	icon.focus_entered.connect(icon.queue_redraw)
	icon.focus_exited.connect(icon.queue_redraw)
	icon.pressed.connect(_open.bind(app))
	icon.pressed.connect(_play_sound.bind("tap"))
	tile.add_child(icon)
	if with_label:
		var label := _label(app, 11, INK)
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		tile.add_child(label)

func _home_dock(parent: Node) -> void:
	var glass := PanelContainer.new()
	parent.add_child(glass)
	_paper_surface(glass, 6)
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 4)
	glass.add_child(row)
	for app: String in ["Messages", "Notes", "Calendar", "Settings"]:
		_app_tile(app, row, false)

func _set_page(page: int) -> void:
	_remember()
	home_page = clampi(page, 0, 1)
	story.state.scroll.Home = 0
	_render()
	_animate_open()

func _change_page(direction: int) -> void:
	_set_page(home_page + direction)

func _animate_open() -> void:
	if reduce_motion:
		return
	screen.pivot_offset = screen.size / 2
	screen.scale = Vector2.ONE * 0.975
	screen.modulate.a = 0.5
	transition = create_tween().set_parallel(true)
	transition.tween_property(screen, "scale", Vector2.ONE, 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	transition.tween_property(screen, "modulate:a", 1.0, 0.16)

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
	overlay.position = Vector2(20, 66)
	overlay.size = Vector2(374, 0)
	var glass := _style(Color("f1f2f6") if notification_center else Color("ececf2"))
	glass.set_corner_radius_all(24)
	overlay.add_theme_stylebox_override("panel", glass)
	layer.add_child(overlay)
	_paper_surface(overlay, 16)
	var stack := VBoxContainer.new()
	overlay.add_child(stack)
	if notification_center:
		overlay.size.y = 746
		stack.add_child(_label("Notification Center", 24))
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
			_button(("● " if not notification.read else "") + notification.app + "\n" + story.text(notification.text), _open.bind(notification.app), list)
		_button("Mark all as read", _mark_notifications_read, stack)
		return
	for notification: Dictionary in story.state.notifications:
		if notification.id == banner_id:
			stack.add_child(_label(notification.app + "  •  now", 12, MUTED))
			_button(story.text(notification.text), _open.bind(notification.app), stack)
			_button("Dismiss", func() -> void: banner_id = ""; _refresh_overlay(), stack)

func _mark_notifications_read() -> void:
	for app: String in Story.APPS:
		story.mark_app_read(app)
	_autosave()
	_refresh_overlay()

func _refresh_app_badges() -> void:
	for icon: Node in frame.find_children("*", "Button", true, false):
		if icon.get_script() == AppIcon:
			icon.badge_count = story.unread_count(icon.app)
			icon.tooltip_text = "Open " + icon.app + (" / %d new updates" % icon.badge_count if icon.badge_count > 0 else "")
			icon.queue_redraw()

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
	gesture_active = Rect2(Vector2.ZERO, PHONE_SIZE).has_point(gesture_start)
	gesture_dragged = false
	var target := _gesture_scroller()
	gesture_scroll = target.scroll_vertical
	var hovered := get_viewport().gui_get_hovered_control()
	gesture_can_scroll = gesture_start.y > 140 and gesture_start.y < 780 and not (hovered is TextEdit or hovered is HSlider)

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
	if gesture_start.y < 90 and delta.y > 60:
		_show_notifications()
	elif gesture_start.y > 790 and delta.y < -60:
		_open("Home")
	elif notification_center and gesture_start.y < 140 and delta.y < -70:
		_close_notifications()
	elif not notification_center and absf(delta.x) > absf(delta.y) * 1.3:
		if story.state.app == "Home":
			_change_page(1 if delta.x < 0 else -1)
		elif gesture_start.x < 44 and delta.x > 70:
			_open("Home")
	get_viewport().set_input_as_handled()

func _gesture_scroller() -> ScrollContainer:
	if notification_center:
		var notification_scroll: Node = frame.find_child("NotificationScroll", true, false)
		if notification_scroll is ScrollContainer:
			return notification_scroll
	return scroller

func _home() -> void:
	var greeting := _label(_story_date().substr(0, 11), 15, INK)
	greeting.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	body.add_child(greeting)
	var clock := _label(_story_date().right(5), 54, INK)
	clock.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	body.add_child(clock)
	var caption := _label("Tokyo", 13, MUTED)
	caption.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	body.add_child(caption)
	var grid := GridContainer.new()
	grid.columns = 4
	grid.add_theme_constant_override("h_separation", 8)
	grid.add_theme_constant_override("v_separation", 18)
	body.add_child(grid)
	var apps: Array = ["Notes", "Messages", "Lantern Quest", "Moments", "Resonance", "Vista", "Loop", "Bookmark"] if home_page == 0 else ["Desk", "Gallery", "Calendar", "Settings"]
	for app: String in apps:
		_app_tile(app, grid)
	var pages := HBoxContainer.new()
	pages.alignment = BoxContainer.ALIGNMENT_CENTER
	body.add_child(pages)
	for i in range(2):
		var dot := _button("●" if home_page == i else "○", _set_page.bind(i), pages)
		dot.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		dot.custom_minimum_size.x = 48
		dot.tooltip_text = "Home page %d" % (i + 1)
		dot.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
		dot.add_theme_color_override("font_color", INK)

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
		body.add_child(_label("End of the playable opening", 13, MUTED))

func _conversation() -> void:
	var is_game: bool = story.state.app == "Lantern Quest"
	if is_game:
		_art("lantern")
		body.add_child(_label("THE RUINED GARDEN  /  Guild party", 12, CORAL))
	else:
		body.add_child(_label("Mizuki", 22))
		body.add_child(_label("mizuki  /  Direct messages", 12, MUTED))
	for entry: Dictionary in story.state.log:
		# The shared history stays readable in both contexts; game messages retain speakers.
		var speaker: String = entry.speaker
		if speaker == "system":
			body.add_child(_label(story.text(entry.text), 12, MUTED))
		else:
			var card := _card("Me" if speaker == "asahi" else speaker, story.text(entry.text))
			var bubble := _style(Color("ecd0b9") if speaker == "asahi" else SURFACE, RULE)
			bubble.set_corner_radius_all(5)
			bubble.border_width_right = 4 if speaker == "asahi" else 1
			bubble.border_width_left = 1 if speaker == "asahi" else 4
			(card.get_parent() as PanelContainer).add_theme_stylebox_override("panel", bubble)
	if story.current().app != story.state.app:
		_button("Continue in " + story.current().app + "  >", _open.bind(story.current().app))
	else:
		_story_controls()

func _story_controls() -> void:
	if not story.choices().is_empty():
		body.add_child(_label("CHOOSE A DRAFT  /  Nothing sends until you say so", 11, CORAL))
		for choice: Dictionary in story.choices():
			_button(story.text(choice.text), _draft.bind(choice.id))
		if story.state.draft != "":
			for choice: Dictionary in story.choices():
				if choice.id == story.state.draft:
					var card := _card("UNSENT DRAFT", story.text(choice.text))
					_button("Send reply  >", _send, card)
					_button("Discard draft", _draft.bind(""), card)
	elif story.current().has("later"):
		if confirm_later:
			_card("ADVANCE STORY TIME?", "Optional browsing from this evening will be left behind. Delivered messages, photos and your notes remain. No real time has passed in the story while you read.")
			_button("Go to the next story day", _later)
			_button("Keep browsing", func() -> void: confirm_later = false; _render())
		else:
			_button("Later  /  Advance story time", func() -> void: confirm_later = true; _render())
	else:
		_card("END OF THIS OPENING", "Your story is saved. This is the first playable milestone, not a full ending. Try another invitation through Settings > Start a new opening.")
		_button("Review your Calendar", _open.bind("Calendar"))

func _draft(id: String) -> void:
	_remember()
	if id == "":
		story.state.draft = ""
	else:
		story.draft(id)
	_autosave()
	_render()
	if id != "":
		_scroll_bottom.call_deferred()

func _send() -> void:
	if story.send():
		_play_sound("sent")
		story.state.app = story.current().app
		story.mark_app_read(story.state.app)
		_autosave()
		_render()
		_scroll_bottom.call_deferred()
		get_tree().create_timer(0.22).timeout.connect(_announce)

func _later() -> void:
	if story.later():
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

func _moments() -> void:
	body.add_child(_label("Small things, lately", 24))
	var post := _card("NATSUMI  /  Tokyo", "Test prints for the showcase. The printer has eaten more lunch money than I have.")
	_art("desk", post)
	_like_button("natsumi_print", post)
	_button("Read Natsumi's note", func() -> void: status = "Natsumi: Save me a Saturday next month? I'll send the date when the venue confirms."; _render(), post)
	post = _card("DAICHI  /  Lantern guild", "New players welcome. Knowing what you're doing is optional. Waiting for each other isn't.")
	_art("lantern", post)
	_like_button("guild_post", post)
	_button("Open guild party", _open.bind("Lantern Quest"), post)
	post = _card("MIZUKI  /  Sapporo", "Rain on the window. Nothing exciting. Quite like it that way.")
	_art("city", post)
	_like_button("yui_rain", post)
	body.add_child(_label("You're caught up. New posts arrive with story days.", 13, MUTED))

func _resonance() -> void:
	_art("city")
	body.add_child(_label("A place to press play", 25))
	body.add_child(_label("Four original instrumental sketches. Music keeps playing while you browse.", 14, MUTED))
	for i in TRACKS.size():
		var card := _card("0%d  /  HOME RECORDINGS" % (i + 1), TRACKS[i])
		_button("Play" if story.state.track != i or not player.playing else "Playing / Pause", _play_track.bind(i), card)
		_like_button("track_" + str(i), card, "Add to favorites")

func _play_track(index: int) -> void:
	if story.state.track == index and player.playing:
		player.stop()
		story.state.music_playing = false
	else:
		story.state.track = index
		story.state.music_playing = true
		_sync_music()
	_autosave()
	_render()

func _toggle_music() -> void:
	if player.playing:
		player.stop()
		story.state.music_playing = false
	else:
		story.state.music_playing = true
		_sync_music()
	_autosave()
	_render()

func _sync_music() -> void:
	player.stop()
	if story.state.track < 0 or not story.state.music_playing:
		return
	player.stream = _music(int(story.state.track))
	player.volume_db = linear_to_db(maxf(volume, 0.001))
	player.stream_paused = volume == 0
	player.play()

func _story_date() -> String:
	if story.state.node == "lives_call":
		return "SUN  25 OCT     15:00"
	if story.state.node == "lives_reschedule":
		return "MON  26 OCT     19:30"
	return ["", "FRI  23 OCT     23:08", "SAT  24 OCT     16:42", "TUE  27 OCT     20:16"][int(story.current().day)]

func _music(index: int) -> AudioStreamWAV:
	var rate := 22050
	var seconds := 8
	var samples := PackedByteArray()
	samples.resize(rate * seconds * 2)
	var progressions := [[60, 64, 67, 71, 57, 64, 67, 69], [62, 65, 69, 72, 59, 65, 69, 74], [57, 60, 64, 67, 53, 60, 64, 65], [65, 69, 72, 76, 60, 67, 72, 74]]
	for i in rate * seconds:
		var t := float(i) / rate
		var beat := int(t * 2)
		var note: int = progressions[index][beat % 8]
		var freq := 440.0 * pow(2.0, (note - 69.0) / 12.0)
		var phase := fmod(t, 0.5)
		var envelope := minf(phase / 0.015, 1.0) * exp(-phase * 7.0)
		var value := (sin(TAU * freq * t) + 0.2 * sin(TAU * freq * 2 * t)) * envelope * 0.13
		# Fade the seam so the short looping sketch stays gentle.
		value *= minf(t / 0.03, 1.0) * minf((seconds - t) / 0.03, 1.0)
		samples.encode_s16(i * 2, int(value * 32767))
	var wav := AudioStreamWAV.new()
	wav.format = AudioStreamWAV.FORMAT_16_BITS
	wav.mix_rate = rate
	wav.data = samples
	wav.loop_mode = AudioStreamWAV.LOOP_FORWARD
	wav.loop_end = rate * seconds
	return wav

func _videos() -> void:
	var titles := ["An ordinary afternoon in Sapporo", "Drawing windows without a ruler", "The garden's safest route", "Rain at the last train", "A shelf with too many screws", "Making a postcard from two cities"]
	var captions := [
		["A tram passes a rainy street.", "A bakery window glows. Someone folds an umbrella.", "Caption: Leave room in the day to get a little lost."],
		["An illustrator makes three crooked lines.", "She draws the frame around them. The window takes shape.", "Caption: Start with what you see. Fix the ruler later."],
		["Two lanterns wait at the broken bridge.", "A third player lights the stones below.", "Caption: Nobody left behind."],
		["Rain gathers under the station roof.", "A late train pulls away from the platform.", "Caption: A normal night, worth remembering."],
		["Two sisters lay out parts for a shelf.", "One holds the instructions upside down.", "Caption: There are always two extra screws. Probably."],
		["Two window photos sit side by side.", "A pencil follows the skyline from one into the other.", "Caption: Different views. A shared piece of paper."]]
	var card := _card("%s  /  %d OF 6" % [story.state.app.to_upper(), clip_index + 1], titles[clip_index])
	_art(["city", "desk", "lantern"][clip_index % 3], card, 180)
	card.add_child(_label(captions[clip_index][clip_frame], 18))
	card.add_child(_label("Original captioned storyboard  /  frame %d of 3" % (clip_frame + 1), 12, MUTED))
	_button("Next frame" if clip_frame < 2 else "Replay storyboard", func() -> void: clip_frame = (clip_frame + 1) % 3; _render(), card)
	_like_button("video_" + str(clip_index), card, "Save video")
	_button("Next video" if clip_index < 5 else "Back to the first video", func() -> void: clip_index = (clip_index + 1) % 6; clip_frame = 0; _render())
	_button("Open related Gallery", _open.bind("Gallery"))
	body.add_child(_label("Finite preview library. Storyboards are temporary media; no external streaming.", 13, MUTED))

func _books() -> void:
	body.add_child(_label("My bookshelf", 25))
	var excerpts := [
		["The Last Light on the Platform", "The train had gone, but the platform was still warm from everyone who had waited. She stayed another minute. There was no reason to hurry an empty evening."],
		["Instructions for an Ordinary Day", "Buy the bread you like. Answer one letter. Open the window, even if only for a moment. The world will not become manageable all at once."],
		["Rooms We Have Never Seen", "He knew the sound her kettle made before he knew the color of her front door. It seemed an odd order in which to learn a person. It was the order they had."]]
	for i in excerpts.size():
		var card := _card(excerpts[i][0], excerpts[i][1])
		_like_button("book_" + str(i), card, "Mark passage")
	body.add_child(_label("MY READING NOTE", 12, CORAL))
	var note := TextEdit.new()
	note.placeholder_text = "Keep a thought for later..."
	note.text = story.state.notes
	note.custom_minimum_size.y = 120
	note.wrap_mode = TextEdit.LINE_WRAPPING_BOUNDARY
	note.text_changed.connect(func() -> void: story.state.notes = note.text)
	body.add_child(note)
	_button("Save note", func() -> void: _autosave(); status = "Note saved." if story.last_error == "" else story.last_error; _render())
	_button("Return to your conversation", _open.bind("Messages"))

func _desk() -> void:
	_card("HOSHINO STUDIO / TEAM", "Handoff checklist\n• Check the exported layouts\n• Leave clear notes for Monday\n• Close the laptop at a sensible hour")
	if story.current().app == "Desk":
		for entry: Dictionary in story.current().lines:
			_card(entry.speaker, story.text(entry.text))
		_story_controls()
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
	if story.state.facts.get("desk_photo", false):
		photo = _card("MIZUKI'S DESK  /  Private. Do not publish.", "A mug full of pens, an unfinished illustration on a laptop, and rain against the window. Mizuki asked to keep this between you.")
		_art("desk", photo)
		_button("Return to Mizuki's message", _open.bind("Messages"), photo)
	if story.state.facts.get("postcard", false):
		photo = _card("TWO WINDOWS  /  Private shared collection", "Your Tokyo skyline beside Mizuki's line drawing. Made in quiet company. Sharing permission stays private.")
		_art("city", photo)
		_art("desk", photo)
	body.add_child(_label("Descriptions are part of every image. No detail hunt is required.", 12, MUTED))

func _calendar() -> void:
	body.add_child(_label("Room for what matters", 25))
	_card("OCTOBER  /  STORY TIME", "23 FRI  •  A party invitation\n24 SAT  •  The next shared activity\n27 TUE  •  A follow-up")
	_card("MY PLANS", story.state.facts.get("commitment", "Nothing confirmed yet."))
	if story.state.facts.has("work"):
		_card("DESK", story.state.facts.work)
	if story.state.facts.has("memory"):
		_card("A MEMORY TO KEEP", story.state.facts.memory)
	if story.current().app == "Calendar":
		for entry: Dictionary in story.current().lines:
			_card(entry.speaker, story.text(entry.text))
		_story_controls()
	else:
		_button("Continue your story  >", _open.bind(story.current().app))
	body.add_child(_label("Only a labeled story transition advances time. Reading slowly never breaks a promise.", 13, MUTED))

func _settings() -> void:
	body.add_child(_label("Make yourself comfortable", 24))
	_card("MY ACCOUNT", "Tachibana Asahi\nasahi\nTokyo, Japan")
	_card("DISPLAY & READING", "The phone always keeps its 414:896 proportions. Window resolution changes its scale, never its shape. Swipe or drag to navigate; buttons remain available.")
	_button("Reduce motion: " + ("On" if reduce_motion else "Off"), func() -> void: reduce_motion = not reduce_motion; _save_settings(); _render())
	_button("Simplify paper texture: " + ("On" if reduce_transparency else "Off"), func() -> void: reduce_transparency = not reduce_transparency; _save_settings(); _render())
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
	_button("Open Notification Center", _show_notifications)
	body.add_child(_label("MUSIC VOLUME", 12, CORAL))
	var slider := HSlider.new()
	slider.min_value = 0
	slider.max_value = 1
	slider.step = 0.05
	slider.value = volume
	slider.custom_minimum_size.y = 48
	slider.value_changed.connect(func(value: float) -> void: volume = value; player.volume_db = linear_to_db(maxf(value, 0.001)); player.stream_paused = value == 0; _save_settings())
	body.add_child(slider)
	_button("Save opening / manual slot", func() -> void: _remember(); status = "Manual save written." if story.save_to("user://manual.json") else story.last_error; _render())
	_button("Load manual save", func() -> void: _load_game("user://manual.json"))
	_button("Continue autosave", func() -> void: _load_game("user://autosave.json"))
	if confirm_restart:
		_card("START OVER?", "This replaces the current opening and autosave. Your manual save is kept.")
		_button("Start a new opening", _restart)
		_button("Keep this story", func() -> void: confirm_restart = false; _render())
	else:
		_button("Start a new opening...", func() -> void: confirm_restart = true; _render())
	_card("ABOUT THIS BUILD", "Godot 4.7.2 / Opening prototype\nThree activity paths, ten app surfaces, temporary pixel illustrations and original music sketches. Full chapters, endings, mobile exports and release accessibility work are still ahead.\n\nThemes: loneliness, distance and relationships. All principal characters are adults.")

func _restart() -> void:
	story.reset()
	player.stop()
	confirm_restart = false
	saved_app = ""
	status = "A new evening."
	_autosave()
	_render()

func _load_game(path: String) -> void:
	if story.load_from(path):
		status = story.last_error if story.last_error != "" else "Save restored."
		saved_app = ""
		_sync_music()
	else:
		status = story.last_error
	_render()

func _save_settings() -> void:
	var settings := ConfigFile.new()
	settings.set_value("audio", "volume", volume)
	settings.set_value("audio", "interface_volume", sound_volume)
	settings.set_value("display", "reduce_motion", reduce_motion)
	settings.set_value("display", "reduce_transparency", reduce_transparency)
	settings.save("user://settings.cfg")

func _load_settings() -> void:
	var settings := ConfigFile.new()
	if settings.load("user://settings.cfg") == OK:
		volume = clampf(float(settings.get_value("audio", "volume", 0.35)), 0.0, 1.0)
		sound_volume = clampf(float(settings.get_value("audio", "interface_volume", 0.55)), 0.0, 1.0)
		reduce_motion = bool(settings.get_value("display", "reduce_motion", false))
		reduce_transparency = bool(settings.get_value("display", "reduce_transparency", false))

func _set_resolution(resolution: Vector2i) -> void:
	get_window().size = resolution
	_layout()
	_save_settings()

func _paper_surface(panel: PanelContainer, margin: int) -> void:
	var style := _style(SURFACE, RULE)
	style.set_content_margin_all(margin)
	panel.add_theme_stylebox_override("panel", style)
	if reduce_transparency:
		return
	var material := ShaderMaterial.new()
	material.shader = PaperShader
	panel.material = material
