class_name HelloStory
extends RefCounted
## Plain-data story state. Presentation never applies narrative effects.

const CONTENT_VERSION := "opening-1"
const APPS := ["Home", "Messages", "Games", "Work", "Photos", "Calendar", "Settings", "Notes"]
const APP_ALIASES := {"Lantern Quest": "Games", "Desk": "Work", "Gallery": "Photos"}
const RETIRED_APPS := ["Moments", "Resonance", "Vista", "Loop", "Bookmark"]
var characters: Dictionary
var content: Dictionary
var state: Dictionary
var last_error := ""
var _choices: Array = []
var _dialogues: Dictionary = {}

func _init() -> void:
	characters = JSON.parse_string(FileAccess.get_file_as_string("res://content/characters.json"))
	content = JSON.parse_string(FileAccess.get_file_as_string("res://content/story.json"))
	for chapter in range(1, 7):
		var path := "res://content/dialogue/act_%02d.dialogue" % chapter
		var resource: DialogueResource = load(path)
		_dialogues[path] = resource
		for line: Dictionary in resource.lines.values():
			if line.has("static_id"): content.strings[line.static_id] = line.text

static func create() -> HelloStory:
	var model := HelloStory.new()
	await model.reset()
	return model

func choice_allowed(id: String) -> bool:
	for choice: Dictionary in current().choices:
		if choice.id == id: return matches(choice.get("if", {}))
	return false

func line_allowed(id: String) -> bool:
	for line: Dictionary in current().lines:
		if line.text == id: return matches(line.get("if", {}))
	return false

func _read_scene(id: String) -> Dictionary:
	var resource: DialogueResource = _dialogues[content.nodes[id].dialogue]
	var lines: Array = []
	var options: Array = []
	var line: DialogueLine = await resource.get_next_dialogue_line(id, [self])
	while line != null:
		content.strings[line.static_id] = line.text
		lines.append({"speaker": line.character, "text": line.static_id})
		for response: DialogueResponse in line.responses:
			if not response.is_allowed: continue
			content.strings[response.static_id] = response.text
			for choice: Dictionary in content.nodes[id].choices:
				if choice.text == response.static_id: options.append(choice.duplicate(true))
		if not line.responses.is_empty(): break
		line = await resource.get_next_dialogue_line(line.next_id, [self])
	# Upstream adds an owning resource link to its compiled dictionaries while
	# reading. We retain only stable IDs, so release these temporary self-links.
	for source: Dictionary in resource.lines.values(): source.erase("resource")
	return {"lines": lines, "choices": options}

func reset() -> void:
	state = {"version": 1, "content_version": CONTENT_VERSION, "node": "invite", "log": [], "facts": {}, "consumed": [], "draft": "", "app": "Home", "likes": [], "notes": "", "scroll": {}, "track": -1, "music_playing": false, "notifications": [], "app_updates": {}, "shown_count": 0}
	await _enter("invite")
	state.social = _new_social()

func _new_social() -> Dictionary:
	return {"friends": ["Natsumi"], "declined": [], "posts": [], "comments": {}, "shares": []}

func social() -> Dictionary:
	if not state.has("social"): state.social = _new_social()
	return state.social

func pending_requests() -> Array[String]:
	var candidates: Array[String] = []
	if "first_dm" in state.consumed: candidates.append("Mizuki")
	if "guild_plan" in state.consumed: candidates.append("Daichi")
	if "family_chat" in state.consumed or "permission_granted" in state.consumed: candidates.append("Misaki")
	return candidates.filter(func(person: String) -> bool: return person not in social().friends and person not in social().declined)

func answer_request(person: String, accept: bool) -> bool:
	if person not in pending_requests(): return false
	social()["friends" if accept else "declined"].append(person)
	return true

func post_status(copy: String) -> bool:
	copy = copy.strip_edges()
	if copy.is_empty() or copy.length() > 280: return false
	social().posts.append({"copy": copy, "date": current().timestamp})
	return true

func add_comment(post: String, copy: String) -> bool:
	copy = copy.strip_edges()
	if copy.is_empty() or copy.length() > 280: return false
	if not social().comments.has(post): social().comments[post] = []
	social().comments[post].append(copy)
	return true

func text(id: String) -> String:
	return str(content.strings.get(id, id))

func current() -> Dictionary:
	return content.nodes[state.node]

func choices() -> Array:
	return _choices

func matches(conditions: Dictionary) -> bool:
	for key: String in conditions:
		if state.facts.get(key) != conditions[key]:
			return false
	return true

func destination(item: Dictionary, field := "to") -> String:
	for branch: Dictionary in item.get("routes" if field == "to" else "later_routes", []):
		if matches(branch.get("if", {})):
			return branch.to
	return item[field]

func journal() -> Dictionary:
	# Derive the checklist from the run, so loading or browsing cannot award progress.
	var complete := choices().is_empty() and not current().has("later")
	var completed: Array = []
	for id: String in state.consumed:
		if content.nodes.has(id) and not content.nodes[id].get("interlude", false) and (id != state.node or complete):
			var node: Dictionary = content.nodes[id]
			completed.append({"id": id, "title": text(node.title), "chapter": node.chapter})
	return {"chapter": current().chapter, "title": text(current().chapter_title),
		"objective": text(current().objective), "app": current().app, "complete": complete,
		"draft_pending": state.draft != "", "completed": completed}

func draft(id: String) -> bool:
	for choice: Dictionary in choices():
		if choice.id == id:
			state.draft = id
			return true
	return false

func send() -> bool:
	for choice: Dictionary in choices():
		if choice.id == state.draft:
			var before: Dictionary = state.facts.duplicate(true)
			state.log.append({"speaker": "asahi", "text": choice.text, "app": current().app, "thread": current().thread, "delivery": "Sent"})
			state.shown_count = state.log.size()
			state.consumed.append(choice.id)
			state.facts.merge(choice.get("set", {}), true)
			state.draft = ""
			await _enter(destination(choice), before)
			return true
	return false

func later() -> bool:
	if not current().has("later"):
		return false
	await _enter(destination(current(), "later"))
	return true

func _enter(id: String, before: Variant = null) -> void:
	state.node = id
	if id not in state.consumed:
		var previous_facts: Dictionary = state.facts.duplicate(true) if before == null else before
		var context: Dictionary = content.nodes[id]
		var resolved: Dictionary = await _read_scene(id)
		for authored: Dictionary in resolved.lines:
			var entry: Dictionary = authored.duplicate(true)
			entry.app = context.app
			entry.thread = context.thread
			state.log.append(entry)
		state.facts.merge(content.nodes[id].get("set", {}), true)
		for rule: Dictionary in context.get("fact_rules", []):
			if matches(rule.get("if", {})):
				state.facts.merge(rule.get("set", {}), true)
				break
		var photo: String = context.get("set", {}).get("photo", "")
		if photo != "":
			if not state.facts.has("photo_ids"): state.facts.photo_ids = []
			if photo not in state.facts.photo_ids: state.facts.photo_ids.append(photo)
		state.consumed.append(id)
		state.notifications.append({"id": id, "app": content.nodes[id].app, "text": content.nodes[id].title, "read": false})
		state.app_updates.Notes = [id]
		for key: String in ["screenshot", "desk_photo", "postcard", "photo"]:
			if state.facts.get(key, false) and not previous_facts.get(key, false):
				_queue_update("Photos", id)
		for key: String in ["commitment", "work", "meeting_plan", "future_travel"]:
			if state.facts.get(key) != previous_facts.get(key):
				_queue_update("Calendar", id)

	_choices = (await _read_scene(id)).choices

func delivery_pending() -> bool:
	if int(state.shown_count) < state.log.size():
		return true
	for entry: Dictionary in state.log:
		if entry.get("delivery") == "Sent": return true
	return false

func advance_delivery() -> void:
	# Presentation changes no story fact, choice, commitment or story time.
	for entry: Dictionary in state.log:
		if entry.get("delivery") == "Sent":
			entry.delivery = "Read"
			return
	state.shown_count = mini(int(state.shown_count) + 1, state.log.size())

func reveal_all() -> void:
	state.shown_count = state.log.size()
	for entry: Dictionary in state.log:
		if entry.has("delivery"): entry.delivery = "Read"

func visible_log(app: String, thread: String) -> Array:
	return state.log.slice(0, int(state.shown_count)).filter(func(entry: Dictionary) -> bool: return entry.app == app and entry.thread == thread)

func threads() -> Array:
	var result: Array = []
	for entry: Dictionary in state.log:
		if entry.app == "Messages" and entry.thread not in result:
			result.append(entry.thread)
	return result

func _queue_update(app: String, id: String) -> void:
	if not state.app_updates.has(app):
		state.app_updates[app] = []
	if id not in state.app_updates[app]:
		state.app_updates[app].append(id)

func unread_count(app: String) -> int:
	# One event can update a screen and notify it; count it only once.
	var unread: Dictionary = {}
	for id: String in state.app_updates.get(app, []):
		unread[id] = true
	for notification: Dictionary in state.notifications:
		if notification.app == app and not notification.read:
			unread[notification.id] = true
	return unread.size()

func mark_app_read(app: String) -> void:
	state.app_updates.erase(app)
	for notification: Dictionary in state.notifications:
		if notification.app == app:
			notification.read = true

func toggle_like(id: String) -> void:
	if id in state.likes:
		state.likes.erase(id)
	else:
		state.likes.append(id)

func valid(data: Variant) -> bool:
	if not data is Dictionary or data.get("version") != 1 or data.get("content_version") != CONTENT_VERSION:
		return false
	if data.has("music") and not preload("res://scripts/music.gd").valid_options(data.music):
		return false
	if data.has("social"):
		var network: Variant = data.social
		if not network is Dictionary: return false
		for key: String in ["friends", "declined", "shares"]:
			if not network.get(key) is Array: return false
			for value: Variant in network[key]:
				if not value is String: return false
		for key: String in ["friends", "declined"]:
			for person: String in network[key]:
				if person not in ["Mizuki", "Natsumi", "Daichi", "Misaki"]: return false
		if not network.get("posts") is Array or not network.get("comments") is Dictionary: return false
		for post: Variant in network.posts:
			if not post is Dictionary or not post.get("copy") is String or not post.get("date") is String: return false
		for post: Variant in network.comments:
			if not post is String or not network.comments[post] is Array: return false
			for copy: Variant in network.comments[post]:
				if not copy is String: return false
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
	if data.has("app_updates"):
		if not data.app_updates is Dictionary:
			return false
		for app: Variant in data.app_updates:
			if app not in APPS or not data.app_updates[app] is Array:
				return false
			for id: Variant in data.app_updates[app]:
				if not id is String:
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
		if entry.has("delivery") and entry.delivery not in ["Sent", "Read"]:
			return false
		if entry.has("app") and entry.app not in APPS: return false
		if entry.has("thread") and not entry.thread is String: return false
	if data.has("shown_count") and (not (data.shown_count is float or data.shown_count is int) or data.shown_count < 0 or data.shown_count > data.log.size() or data.shown_count != int(data.shown_count)):
		return false
	if data.draft != "":
		var found := false
		for choice: Dictionary in content.nodes[data.node].get("choices", []):
			var eligible := true
			for key: String in choice.get("if", {}):
				eligible = eligible and data.facts.get(key) == choice["if"][key]
			found = found or (choice.id == data.draft and eligible)
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
			if not state.has("social"): state.social = _new_social()
			if not state.has("shown_count"): state.shown_count = state.log.size()
			if not state.has("app_updates"):
				state.app_updates = {"Notes": [state.node]}
			if not state.has("notifications"):
				state.notifications = [{"id": state.node, "app": current().app, "text": current().title, "read": false}]
			# Preserve prototype saves when the creator renames the cast.
			for entry: Dictionary in state.log:
				var context: Dictionary = content.nodes.get(entry.text.get_slice(".", 0), current())
				if not entry.has("app"): entry.app = context.app
				if not entry.has("thread"): entry.thread = context.thread
				if entry.speaker == "haru": entry.speaker = "asahi"
				if entry.speaker == "yuzu": entry.speaker = "mizuki"
				# Stable line IDs now describe the corrected chance encounter.
				if entry.text in ["invite.line.0", "splash.line.2"]: entry.speaker = "system"
				if entry.text == "bridge.line.2": entry.speaker = "mizuki"
			for key: String in state.facts:
				if state.facts[key] is String:
					state.facts[key] = state.facts[key].replace("Yui", "Mizuki")
			if candidate.ends_with(".bak"):
				last_error = "Recovered the previous valid save."
			_choices = (await _read_scene(state.node)).choices
			return true
	last_error = "No compatible save found. Existing files have been kept."
	return false

func _read_json(path: String) -> Variant:
	var parser := JSON.new()
	if parser.parse(FileAccess.get_file_as_string(path)) != OK:
		return null
	return _migrate_apps(parser.data)

func _migrate_apps(data: Variant) -> Variant:
	# Normalize only known old app IDs. Validation still rejects malformed data.
	if not data is Dictionary or data.get("version") != 1 or data.get("content_version") != CONTENT_VERSION:
		return data
	if data.get("app") is String:
		data.app = "Home" if data.app in RETIRED_APPS else APP_ALIASES.get(data.app, data.app)
	for key: String in ["scroll", "app_updates"]:
		if data.get(key) is Dictionary:
			for old: String in APP_ALIASES:
				if data[key].has(old):
					data[key][APP_ALIASES[old]] = data[key][old]
					data[key].erase(old)
			for retired: String in RETIRED_APPS:
				data[key].erase(retired)
	if data.get("notifications") is Array:
		var kept: Array = []
		for notification: Variant in data.notifications:
			if notification is Dictionary and notification.get("app") is String:
				if notification.app in RETIRED_APPS:
					continue
				notification.app = APP_ALIASES.get(notification.app, notification.app)
			kept.append(notification)
		data.notifications = kept
	return data
