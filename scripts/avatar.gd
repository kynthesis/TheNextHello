extends Control
## Tiny fictional profile photos in the game's pixel-art style.
var who := "asahi"

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func _draw() -> void:
	draw_set_transform(Vector2.ZERO, 0, size / Vector2(32, 32))
	draw_rect(Rect2(0, 0, 32, 32), Color("7c879c"))
	draw_rect(Rect2(1, 1, 30, 30), Color.WHITE)
	draw_rect(Rect2(3, 3, 26, 26), Color("c5d1e0"))
	var shirts := {"asahi": "455f81", "mizuki": "a16b7c", "natsumi": "ac8b4b", "daichi": "617454", "mossbyte": "617454", "misaki": "797093"}
	var hair := Color("3d3336") if who.to_lower() != "natsumi" else Color("77513c")
	draw_rect(Rect2(7, 23, 18, 6), Color(shirts.get(who.to_lower(), "6784ae")))
	draw_rect(Rect2(11, 20, 10, 5), Color("d0a88e"))
	draw_rect(Rect2(9, 8, 14, 13), hair)
	draw_rect(Rect2(11, 11, 10, 11), Color("edc6a3"))
	draw_rect(Rect2(10, 8, 12, 4), hair)
	draw_rect(Rect2(10, 10, 3, 6), hair)
	if who.to_lower() in ["mizuki", "misaki", "natsumi"]:
		draw_rect(Rect2(8, 12, 3, 12), hair)
		draw_rect(Rect2(21, 12, 3, 12), hair)
	draw_rect(Rect2(13, 15, 1, 1), Color("493f3c"))
	draw_rect(Rect2(19, 15, 1, 1), Color("493f3c"))
