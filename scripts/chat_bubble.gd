extends PanelContainer
## Small squared speech tail, aligned with the old mobile chat cards.
var outgoing := false

func _ready() -> void:
	resized.connect(queue_redraw)

func _draw() -> void:
	var edge := Color("8da4c2") if outgoing else Color("b8bdc5")
	var fill := Color("d9e7f8") if outgoing else Color("ffffff")
	var x := size.x - 1 if outgoing else 1.0
	var direction := 1.0 if outgoing else -1.0
	var points := PackedVector2Array([Vector2(x, 14), Vector2(x + direction * 7, 20), Vector2(x, 27)])
	draw_colored_polygon(points, fill)
	draw_line(points[0], points[1], edge, 1, true)
	draw_line(points[1], points[2], edge, 1, true)
