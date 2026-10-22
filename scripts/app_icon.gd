extends Button
## Twelve-cell pictograms share a three-pixel grid and a stationery palette.
var app := "Messages"
var badge_count := 0
const COLORS := {"Messages": "769184", "Games": "65728b", "Work": "7d8a9c", "Photos": "78998a", "Calendar": "b77b67", "Settings": "818475", "Notes": "be9a60"}
const GLYPHS := {
	"Messages": ["............", "..########..", ".##########.", ".##########.", ".##.##.##.#.", ".##########.", ".##########.", "..########..", "..###.......", "..##........", "............", "............"],
	"Notes": ["...######...", "..########..", "..##....##..", "..########..", "..##....##..", "..########..", "..##....##..", "..########..", "..##....##..", "..########..", "...######...", "............"],
	"Games": ["....####....", "...##..##...", "...######...", "..########..", "..##.##.##..", "..##.##.##..", "..##.##.##..", "..##.##.##..", "..########..", "...######...", ".....##.....", "............"],
	"Work": ["............", "....####....", "...##..##...", ".##########.", ".##########.", ".####..####.", ".####..####.", ".##########.", ".##########.", ".##########.", "............", "............"],
	"Photos": ["............", ".##########.", ".#........#.", ".#.....##.#.", ".#.....##.#.", ".#..##....#.", ".#.####...#.", ".########.#.", ".##########.", ".##########.", "............", "............"],
	"Calendar": ["...#....#...", "...#....#...", ".##########.", ".#........#.", ".##########.", ".#........#.", ".#.##.##..#.", ".#........#.", ".#.##.##..#.", ".#........#.", ".##########.", "............"],
	"Settings": [".....##.....", "..##.##.##..", "..########..", "...######...", ".###..#.###.", "####....####", "####....####", ".###.#..###.", "...######...", "..########..", "..##.##.##..", ".....##....."]
}

func _draw() -> void:
	var tint := Color(COLORS.get(app, "818475"))
	draw_style_box(_box(Color("c9b99d")), Rect2(5, 8, 62, 62))
	draw_style_box(_box(tint, Color("26354a")), Rect2(5, 4, 62, 62))
	draw_line(Vector2(11, 8), Vector2(60, 8), tint.lightened(0.28), 2)
	var glyph: Array = GLYPHS.get(app, GLYPHS.Messages)
	for y in range(glyph.size()):
		for x in range(glyph[y].length()):
			if glyph[y][x] == "#":
				draw_rect(Rect2(18 + x * 3, 17 + y * 3, 3, 3), Color("fff8e9"))
	if has_focus():
		draw_style_box(_box(Color.TRANSPARENT, Color("26354a")), Rect2(0, 0, 72, 72))
	if badge_count > 0:
		var count_text := "99+" if badge_count > 99 else str(badge_count)
		var width := 20.0 if count_text.length() == 1 else 30.0
		draw_style_box(_box(Color("a64e43"), Color("fff8e9")), Rect2(72 - width, 0, width, 20))
		var font := ThemeDB.fallback_font
		var text_width := font.get_string_size(count_text, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x
		draw_string(font, Vector2(72 - width / 2 - text_width / 2, 14), count_text, HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color("fff8e9"))

func _box(color: Color, border := Color.TRANSPARENT) -> StyleBoxFlat:
	var box := StyleBoxFlat.new()
	box.bg_color = color
	box.set_corner_radius_all(4)
	box.border_color = border
	box.set_border_width_all(2 if border.a else 0)
	return box
