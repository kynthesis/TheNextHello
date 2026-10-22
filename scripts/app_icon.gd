extends Button
## Recreated early Facebook mobile pictograms, drawn at a fixed 72 px canvas.
var app := "Messages"
var badge_count := 0

func _ready() -> void:
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

func _draw() -> void:
	match app:
		"Home": _newspaper()
		"Profile": _person(Vector2(17, 6), Color("8eacd3"))
		"Friends":
			_person(Vector2(5, 11), Color("d2d6dd"), 0.82)
			_person(Vector2(29, 8), Color("8ba9d3"), 0.88)
		"Requests":
			_person(Vector2(13, 6), Color("819fcd"))
			_cross(Vector2(42, 43))
		"Messages":
			_speech(Rect2(7, 27, 40, 28), Color("c88ca7"), false)
			_speech(Rect2(22, 12, 43, 31), Color("f8fafc"), true)
		"Calendar": _calendar()
		"Photos": _photos()
		_:
			_speech(Rect2(12, 16, 48, 34), Color("b8cce8"), true)
	if is_hovered() or has_focus():
		draw_style_box(_box(Color(0.65, 0.75, 0.9, 0.12), Color("899fbe")), Rect2(1, 1, 70, 70))
	if badge_count > 0:
		var copy := "99+" if badge_count > 99 else str(badge_count)
		var width := 22.0 if copy.length() == 1 else 31.0
		draw_style_box(_box(Color("7e2829")), Rect2(70 - width, 2, width, 23))
		draw_style_box(_box(Color("d9463f"), Color("ffffff")), Rect2(69 - width, 0, width, 22))
		draw_line(Vector2(71 - width, 2), Vector2(66, 2), Color("f4998d"), 1)
		var font := ThemeDB.fallback_font
		var text_width := font.get_string_size(copy, HORIZONTAL_ALIGNMENT_LEFT, -1, 16).x
		draw_string(font, Vector2(69 - width / 2 - text_width / 2, 17), copy, HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color.WHITE)

func _box(fill: Color, edge := Color("5d6572")) -> StyleBoxFlat:
	var box := StyleBoxFlat.new()
	box.bg_color = fill
	box.border_color = edge
	box.set_border_width_all(1)
	box.set_corner_radius_all(1)
	return box

func _bevel(rect: Rect2, fill: Color, edge := Color("606776")) -> void:
	draw_style_box(_box(Color(0, 0, 0, 0.12), Color.TRANSPARENT), Rect2(rect.position + Vector2(1, 2), rect.size))
	draw_style_box(_box(fill, edge), rect)
	draw_line(rect.position + Vector2(1, 1), rect.position + Vector2(rect.size.x - 2, 1), Color.WHITE, 1)
	draw_line(rect.position + Vector2(1, 1), rect.position + Vector2(1, rect.size.y - 2), Color.WHITE, 1)

func _person(origin: Vector2, fill: Color, factor := 1.0) -> void:
	# Angular outline, rounded head and flared shoulders match the old contact art.
	var outline := PackedVector2Array([Vector2(17, 0), Vector2(23, 2), Vector2(26, 8), Vector2(25, 21), Vector2(22, 26), Vector2(23, 32), Vector2(36, 40), Vector2(38, 49), Vector2(0, 49), Vector2(2, 40), Vector2(14, 32), Vector2(15, 26), Vector2(12, 21), Vector2(11, 10), Vector2(12, 4), Vector2(17, 0)])
	var points := PackedVector2Array()
	for point: Vector2 in outline: points.append(origin + point * factor)
	var shadow := PackedVector2Array()
	for point: Vector2 in points: shadow.append(point + Vector2(0, 2))
	draw_colored_polygon(shadow, Color(0.1, 0.15, 0.25, 0.16))
	draw_colored_polygon(points, fill)
	draw_polyline(points, Color("425a7c"), 1, true)

func _newspaper() -> void:
	_bevel(Rect2(9, 15, 52, 43), Color("e7e9ed"))
	_bevel(Rect2(14, 11, 50, 43), Color("fefefe"))
	draw_rect(Rect2(18, 15, 42, 6), Color("959aa7"))
	draw_rect(Rect2(18, 25, 15, 23), Color("a8b5d4"))
	for y in [25, 31, 37, 43]: draw_rect(Rect2(37, y, 22, 3), Color("adb2bf"))
	draw_line(Vector2(11, 21), Vector2(11, 50), Color("b4b7c0"), 2)

func _speech(rect: Rect2, fill: Color, lines: bool) -> void:
	_bevel(rect, fill)
	var tail := PackedVector2Array([rect.position + Vector2(8, rect.size.y - 1), rect.position + Vector2(8, rect.size.y + 9), rect.position + Vector2(18, rect.size.y - 1)])
	draw_colored_polygon(tail, fill)
	draw_polyline(tail, Color("606776"), 1, true)
	if lines:
		draw_rect(Rect2(rect.position + Vector2(6, 6), Vector2(rect.size.x - 12, 4)), Color("8499ba"))
		draw_rect(Rect2(rect.position + Vector2(6, 14), Vector2(rect.size.x - 16, 3)), Color("b3bac6"))

func _calendar() -> void:
	_bevel(Rect2(13, 12, 47, 49), Color("dedfe4"))
	_bevel(Rect2(11, 9, 47, 49), Color("fffefa"))
	draw_rect(Rect2(12, 10, 45, 12), Color("b63035"))
	draw_line(Vector2(13, 11), Vector2(55, 11), Color("e27d7e"), 1)
	draw_line(Vector2(12, 24), Vector2(56, 24), Color("c7c7c7"), 1)
	var font := ThemeDB.fallback_font
	draw_string(font, Vector2(18, 49), "31", HORIZONTAL_ALIGNMENT_LEFT, -1, 27, Color("363333"))
	draw_line(Vector2(13, 54), Vector2(56, 54), Color("d0cac5"), 1)

func _photos() -> void:
	_bevel(Rect2(8, 12, 43, 39), Color("fdfdfb"))
	draw_rect(Rect2(12, 16, 35, 30), Color("91a3be"))
	_bevel(Rect2(22, 24, 43, 35), Color("fffdf5"))
	draw_rect(Rect2(26, 28, 35, 27), Color("e4c88a"))
	var head := PackedVector2Array([Vector2(39, 31), Vector2(46, 32), Vector2(48, 37), Vector2(47, 43), Vector2(45, 46), Vector2(55, 51), Vector2(55, 55), Vector2(31, 55), Vector2(31, 51), Vector2(40, 46), Vector2(37, 41), Vector2(37, 35)])
	draw_colored_polygon(head, Color("866133"))

func _cross(origin: Vector2) -> void:
	draw_rect(Rect2(origin + Vector2(6, 0), Vector2(10, 27)), Color("386b20"))
	draw_rect(Rect2(origin + Vector2(-2, 8), Vector2(27, 10)), Color("386b20"))
	draw_rect(Rect2(origin + Vector2(8, 1), Vector2(6, 23)), Color("78bd42"))
	draw_rect(Rect2(origin + Vector2(0, 10), Vector2(23, 6)), Color("78bd42"))
