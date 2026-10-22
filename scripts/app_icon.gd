extends Button
## Code-native home-screen icons with a shared rounded-square silhouette.
var app := "Messages"
var badge_count := 0
const COLORS := {"Messages": "35cb65", "Lantern Quest": "454dbc", "Moments": "d96d9e", "Resonance": "f14a68", "Vista": "ed5354", "Loop": "202635", "Bookmark": "eb9a3e", "Desk": "4c8bdc", "Gallery": "f5f5f7", "Calendar": "fafafa", "Settings": "89919c", "Notes": "f3c84b"}

func _draw() -> void:
	var box := StyleBoxFlat.new()
	box.bg_color = Color(COLORS.get(app, "89919c"))
	box.set_corner_radius_all(16)
	draw_style_box(box, Rect2(Vector2(5, 5), Vector2(62, 62)))
	var white := Color.WHITE
	match app:
		"Notes":
			draw_style_box(_box(white, 4), Rect2(19, 17, 34, 39))
			for y in [28, 36, 44]:
				draw_line(Vector2(25, y), Vector2(47, y), Color("b99a42"), 2, true)
		"Messages", "Moments":
			draw_style_box(_box(white, 11), Rect2(17, 20, 38, 27))
			draw_colored_polygon(PackedVector2Array([Vector2(22, 43), Vector2(22, 54), Vector2(35, 43)]), white)
			if app == "Moments":
				for x in [26, 36, 46]: draw_circle(Vector2(x, 33), 2, Color("d96d9e"))
		"Resonance":
			draw_line(Vector2(30, 44), Vector2(30, 23), white, 4, true)
			draw_line(Vector2(48, 40), Vector2(48, 19), white, 4, true)
			draw_line(Vector2(29, 24), Vector2(49, 20), white, 5, true)
			draw_circle(Vector2(25, 46), 6, white)
			draw_circle(Vector2(43, 42), 6, white)
		"Vista", "Loop":
			draw_colored_polygon(PackedVector2Array([Vector2(29, 21), Vector2(29, 51), Vector2(51, 36)]), white)
			if app == "Loop": draw_line(Vector2(21, 22), Vector2(21, 50), Color("72e4e3"), 3)
		"Lantern Quest":
			draw_arc(Vector2(36, 26), 9, PI, TAU, 20, Color("ffe0a0"), 3, true)
			draw_style_box(_box(Color("ffe0a0"), 6), Rect2(24, 27, 24, 26))
			draw_line(Vector2(36, 32), Vector2(36, 47), Color("e99667"), 3)
		"Bookmark":
			draw_style_box(_box(white, 3), Rect2(18, 20, 36, 32))
			draw_line(Vector2(36, 21), Vector2(36, 51), Color("eb9a3e"), 2)
		"Desk":
			draw_style_box(_box(white, 5), Rect2(18, 27, 36, 25))
			draw_rect(Rect2(29, 20, 14, 9), white, false, 3)
			draw_line(Vector2(18, 37), Vector2(54, 37), Color("4c8bdc"), 2)
		"Gallery":
			for i in range(8):
				var angle := i * TAU / 8
				draw_circle(Vector2(36, 36) + Vector2(cos(angle), sin(angle)) * 13, 8, Color.from_hsv(float(i) / 8, 0.65, 0.94, 0.85))
			draw_circle(Vector2(36, 36), 6, Color("ffdc83"))
		"Calendar":
			draw_style_box(_box(Color("f45458"), 5), Rect2(15, 15, 42, 13))
			draw_string(ThemeDB.fallback_font, Vector2(21, 53), "23", HORIZONTAL_ALIGNMENT_LEFT, -1, 27, Color("222633"))
		"Settings":
			for i in range(8):
				var direction := Vector2.from_angle(i * TAU / 8)
				draw_line(Vector2(36, 36) + direction * 14, Vector2(36, 36) + direction * 23, white, 6, true)
			draw_arc(Vector2(36, 36), 15, 0, TAU, 32, white, 5, true)
			draw_circle(Vector2(36, 36), 6, white)
	if has_focus():
		draw_style_box(_box(Color.TRANSPARENT, 18, Color("a4d5ff")), Rect2(1, 1, 70, 70))
	if badge_count > 0:
		var count_text := "99+" if badge_count > 99 else str(badge_count)
		var width := 20.0 if count_text.length() == 1 else 30.0
		draw_style_box(_box(Color("ff453a"), 10, white), Rect2(72 - width, 0, width, 20))
		var font := ThemeDB.fallback_font
		var text_width := font.get_string_size(count_text, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x
		draw_string(font, Vector2(72 - width / 2 - text_width / 2, 14), count_text, HORIZONTAL_ALIGNMENT_LEFT, -1, 12, white)

func _box(color: Color, radius: int, border := Color.TRANSPARENT) -> StyleBoxFlat:
	var box := StyleBoxFlat.new()
	box.bg_color = color
	box.set_corner_radius_all(radius)
	box.border_color = border
	box.set_border_width_all(2 if border.a else 0)
	return box
