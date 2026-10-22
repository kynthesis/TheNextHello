extends Button
## Monochrome navigation icons with classic red counters and an active marker.
var symbol := "messages"
var badge_count := 0
var active := false

func _ready() -> void:
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	focus_entered.connect(queue_redraw)
	focus_exited.connect(queue_redraw)
	resized.connect(queue_redraw)

func _draw() -> void:
	if active:
		draw_rect(Rect2(Vector2.ZERO, size), Color("304d86"))
		draw_colored_polygon(PackedVector2Array([Vector2(size.x / 2 - 5, size.y), Vector2(size.x / 2, size.y - 5), Vector2(size.x / 2 + 5, size.y)]), Color("eef0f7"))
	var ink := Color.WHITE if active else Color("a6bbdc")
	draw_set_transform(Vector2(size.x / 2 - 12, size.y / 2 - 12))
	match symbol:
		"friends":
			draw_circle(Vector2(8, 7), 3.4, ink)
			draw_circle(Vector2(17, 9), 3.1, ink)
			draw_colored_polygon(PackedVector2Array([Vector2(2, 20), Vector2(2, 16), Vector2(7, 12), Vector2(9, 12), Vector2(14, 16), Vector2(14, 20)]), ink)
			draw_colored_polygon(PackedVector2Array([Vector2(14, 21), Vector2(14, 17), Vector2(17, 14), Vector2(22, 17), Vector2(22, 21)]), ink)
		"messages":
			draw_rect(Rect2(2, 4, 20, 14), ink)
			draw_colored_polygon(PackedVector2Array([Vector2(5, 16), Vector2(5, 23), Vector2(12, 17)]), ink)
		"notifications":
			draw_circle(Vector2(12, 12), 10, ink)
			var sea := Color("304d86") if active else Color("3b5998")
			draw_colored_polygon(PackedVector2Array([Vector2(5, 5), Vector2(11, 3), Vector2(14, 6), Vector2(10, 9), Vector2(7, 8), Vector2(6, 13), Vector2(3, 11)]), sea)
			draw_colored_polygon(PackedVector2Array([Vector2(12, 12), Vector2(17, 9), Vector2(21, 13), Vector2(17, 18), Vector2(15, 22), Vector2(13, 17)]), sea)
		"search":
			draw_arc(Vector2(10, 10), 6.5, 0, TAU, 32, ink, 2.5, true)
			draw_line(Vector2(15, 15), Vector2(22, 22), ink, 3, true)
		"menu":
			for y in [6, 12, 18]: draw_line(Vector2(3, y), Vector2(21, y), ink, 2.5, true)
	draw_set_transform(Vector2.ZERO)
	if badge_count > 0:
		var copy := "99+" if badge_count > 99 else str(badge_count)
		var font := get_theme_font("font")
		var width := maxf(17.0, font.get_string_size(copy, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x + 6)
		var rect := Rect2(Vector2(minf(size.x / 2 + 1, size.x - width - 2), 3), Vector2(width, 17))
		draw_rect(rect, Color("dc5151"))
		draw_string(font, rect.position + Vector2(3, 13), copy, HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color.WHITE)
