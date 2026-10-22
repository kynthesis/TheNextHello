extends RefCounted
## Plain-data story state. Presentation never applies narrative effects.

const CONTENT_VERSION := "opening-1"
const APPS := ["Home", "Messages", "Lantern Quest", "Moments", "Resonance", "Vista", "Loop", "Bookmark", "Desk", "Gallery", "Calendar", "Settings"]
var content: Dictionary
var state: Dictionary
var last_error := ""

func _init() -> void:
	content = JSON.parse_string(FileAccess.get_file_as_string("res://content/opening.json"))
	reset()

func reset() -> void:
	state = {"version": 1, "content_version": CONTENT_VERSION, "node": "invite", "log": [], "facts": {}, "consumed": [], "draft": "", "app": "Home", "likes": [], "notes": "", "scroll": {}, "track": -1, "music_playing": false, "notifications": []}
	_enter("invite")

func text(id: String) -> String:
	return str(content.strings.get(id, id))

func current() -> Dictionary:
	return content.nodes[state.node]

func choices() -> Array:
	return current().get("choices", [])

func draft(id: String) -> bool:
	for choice: Dictionary in choices():
		if choice.id == id:
			state.draft = id
			return true
	return false

func send() -> bool:
	for choice: Dictionary in choices():
		if choice.id == state.draft:
			state.log.append({"speaker": "asahi", "text": choice.text})
			state.consumed.append(choice.id)
			state.facts.merge(choice.get("set", {}), true)
			state.draft = ""
			_enter(choice.to)
			return true
	return false

func later() -> bool:
	if not current().has("later"):
		return false
	_enter(current().later)
	return true

func _enter(id: String) -> void:
	state.node = id
	if id not in state.consumed:
		state.log.append({"speaker": "system", "text": content.nodes[id].title})
		state.log.append_array(content.nodes[id].get("lines", []).duplicate(true))
		state.facts.merge(content.nodes[id].get("set", {}), true)
		state.consumed.append(id)
		state.notifications.append({"id": id, "app": content.nodes[id].app, "text": content.nodes[id].title, "read": false})

func toggle_like(id: String) -> void:
	if id in state.likes:
		state.likes.erase(id)
	else:
		state.likes.append(id)

func valid(data: Variant) -> bool:
	if not data is Dictionary or data.get("version") != 1 or data.get("content_version") != CONTENT_VERSION:
		return false
	for key: String in ["log", "consumed", "likes"]:
		if not data.get(key) is Array:
			return false
	for key: String in ["facts", "scroll"]:
		if not data.get(key) is Dictionary:
			return false
	if not data.get("node") is String or not content.nodes.has(data.node):
		return false
	if not data.get("app") in APPS or not data.get("notes") is String or not data.get("draft") is String:
		return false
	if not data.get("track") is float and not data.get("track") is int:
		return false
	if data.track < -1 or data.track > 3:
		return false
	if not data.get("music_playing") is bool:
		return false
	if data.has("notifications"):
		if not data.notifications is Array:
			return false
		for notification: Variant in data.notifications:
			if not notification is Dictionary or not notification.get("id") is String or not notification.get("text") is String or not notification.get("read") is bool or not notification.get("app") in APPS:
				return false
	for entry: Variant in data.log:
		if not entry is Dictionary or not entry.get("speaker") is String or not entry.get("text") is String:
			return false
	if data.draft != "":
		var found := false
		for choice: Dictionary in content.nodes[data.node].get("choices", []):
			found = found or choice.id == data.draft
		if not found:
			return false
	return true

func save_to(path: String) -> bool:
	last_error = ""
	var file := FileAccess.open(path + ".tmp", FileAccess.WRITE)
	if file == null:
		last_error = "Could not write save. Your previous save is still available."
		return false
	file.store_string(JSON.stringify(state))
	file.flush()
	var write_error := file.get_error()
	file.close()
	if write_error != OK:
		last_error = "Save write failed. Your previous save is still available."
		return false
	# Copy only a validated primary, preserving a good backup after recovery.
	if FileAccess.file_exists(path):
		var old: Variant = _read_json(path)
		if valid(old) and DirAccess.copy_absolute(path, path + ".bak") != OK:
			last_error = "Could not back up the previous save."
			return false
	if DirAccess.rename_absolute(path + ".tmp", path) != OK:
		last_error = "Could not replace save. The previous version has been retained."
		return false
	return true

func load_from(path: String) -> bool:
	last_error = ""
	for candidate: String in [path, path + ".bak"]:
		if not FileAccess.file_exists(candidate):
			continue
		var data: Variant = _read_json(candidate)
		if valid(data):
			state = data
			if not state.has("notifications"):
				state.notifications = [{"id": state.node, "app": current().app, "text": current().title, "read": false}]
			# Preserve prototype saves when the creator renames the cast.
			for entry: Dictionary in state.log:
				if entry.speaker == "haru": entry.speaker = "asahi"
				if entry.speaker == "yuzu": entry.speaker = "mizuki"
			for key: String in state.facts:
				if state.facts[key] is String:
					state.facts[key] = state.facts[key].replace("Yui", "Mizuki")
			if candidate.ends_with(".bak"):
				last_error = "Recovered the previous valid save."
			return true
	last_error = "No compatible save found. Existing files have been kept."
	return false

func _read_json(path: String) -> Variant:
	var parser := JSON.new()
	if parser.parse(FileAccess.get_file_as_string(path)) != OK:
		return null
	return parser.data
