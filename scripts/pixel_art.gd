extends Control
## Temporary pixel illustrations rendered to a single consistent low-res grid.
var kind := "city"

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	resized.connect(queue_redraw)

func block(x: float, y: float, w: float, h: float, color: String) -> void:
	var bounds := Rect2(0, 0, 160, 90)
	draw_rect(Rect2(x, y, w, h).intersection(bounds), Color(color))

func _draw() -> void:
	draw_set_transform(Vector2.ZERO, 0, size / Vector2(160, 90))
	block(0, 0, 160, 90, "283044")
	if kind == "lantern":
		block(0, 0, 160, 90, "172c36")
		for i in range(12):
			block(i * 16 - 8, 26 + (i % 3) * 9, 10, 64, "244249")
		block(0, 75, 160, 15, "405c52")
		for i in range(9):
			block(18 + i * 15, 65 - (i % 3) * 3, 12, 4, "6b8170")
		for x in [52, 104]:
			block(x, 53, 7, 14, "c18d95")
			block(x, 48, 7, 6, "e5c6ac")
			block(x + 9, 53, 5, 7, "efc879")
			block(x + 10, 54, 3, 4, "fff1bc")
		block(120, 18, 9, 9, "efc879")
	elif kind == "desk":
		block(0, 0, 160, 90, "49546b")
		block(12, 9, 62, 48, "263343")
		block(16, 13, 54, 40, "93aab0")
		block(42, 13, 3, 40, "49546b")
		block(16, 32, 54, 3, "49546b")
		block(0, 68, 160, 22, "987d7b")
		block(82, 35, 54, 34, "253544")
		block(86, 39, 46, 26, "cfbcaa")
		block(90, 44, 25, 2, "8a8f91")
		block(90, 50, 36, 2, "8a8f91")
		block(78, 69, 62, 3, "bac1bd")
		block(35, 57, 16, 17, "e5c7a4")
		block(49, 59, 6, 10, "e5c7a4")
		block(51, 61, 2, 5, "987d7b")
		for x in [38, 43, 47]:
			block(x, 43 + x % 3, 2, 17, "677d73")
	else:
		block(0, 0, 160, 54, "666b87")
		block(0, 37, 160, 19, "b68c91")
		block(0, 53, 160, 37, "353e53")
		block(122, 12, 10, 10, "efd5b2")
		var heights := [30, 42, 22, 36, 51, 25, 38, 19, 33]
		for i in heights.size():
			var x := i * 20 - 5
			block(x, 90 - heights[i], 16, heights[i], "29374a")
			for y in range(94 - heights[i], 85, 7):
				for dx in [3, 9]:
					if (i + y + dx) % 4 != 0:
						block(x + dx, y, 3, 3, "d9b294")
		for i in range(22):
			block((i * 37) % 160, (i * 19) % 90, 1, 3, "9bacc1")
