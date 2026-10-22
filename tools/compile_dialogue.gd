extends SceneTree
## Use the upstream compiler; do not implement a second .dialogue parser.

func _initialize() -> void:
	var data: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://content/story.json"))
	var seen := {}
	var failed := false
	for chapter in range(1, 7):
		var path := "res://content/dialogue/act_%02d.dialogue" % chapter
		var compiled := DMCompiler.compile_string(FileAccess.get_file_as_string(path), path)
		if not compiled.errors.is_empty():
			push_error(path + ": " + str(compiled.errors))
			failed = true
		for line: Dictionary in compiled.lines.values():
			if line.get("type") == DMConstants.TYPE_MUTATION:
				push_error(path + ": put consequences in story.json, not dialogue mutations")
				failed = true
			if line.has("static_id"):
				if seen.has(line.static_id):
					push_error("Duplicate stable ID: " + line.static_id)
					failed = true
				seen[line.static_id] = true
				data.strings[line.static_id] = line.text
	if failed:
		quit(1)
		return
	for node: Dictionary in data.nodes.values():
		for entry: Dictionary in node.lines + node.choices:
			if not seen.has(entry.text):
				push_error("Missing native dialogue ID: " + entry.text)
				failed = true
	if failed:
		quit(1)
		return
	var output := FileAccess.open("res://content/opening.json", FileAccess.WRITE)
	output.store_string(JSON.stringify(data, "  ", false) + "\n")
	output.close()
	print("Dialogue Manager compiled %d stable lines/replies across six acts" % seen.size())
	quit(0)
