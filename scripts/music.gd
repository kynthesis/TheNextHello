extends Node
## Playback and availability derive from committed story history, never UI visits.

signal changed

var catalog: Array = JSON.parse_string(FileAccess.get_file_as_string("res://content/music.json"))
var story: RefCounted
var player: AudioStreamPlayer
var volume := 0.65
var suspended := false
var error := ""
var loaded_path := ""

func _ready() -> void:
	if AudioServer.get_bus_index("Music") == -1:
		AudioServer.add_bus()
		AudioServer.set_bus_name(AudioServer.bus_count - 1, "Music")
	player = AudioStreamPlayer.new()
	player.name = "MusicPlayback"
	player.bus = "Music"
	add_child(player)
	player.finished.connect(_finished)
	set_volume(volume)

func _exit_tree() -> void:
	player.stream_paused = false
	player.stop()
	player.stream = null

static func valid_options(value: Variant) -> bool:
	if not value is Dictionary: return false
	if not value.get("song") is String or value.song not in ["october_23", "lunch_break", "the_last_bus", "a_green_light", "four_players", "two_windows", "ink_on_the_table", "away_for_dinner", "missed_the_last_train", "the_long_way_back", "your_coat", "same_time_next_week"]: return false
	if value.get("variant") not in ["a", "b"]: return false
	if not value.get("playing") is bool or not value.get("automatic") is bool: return false
	var position: Variant = value.get("position")
	return (position is float or position is int) and is_finite(float(position)) and position >= 0

func options() -> Dictionary:
	if not story.state.has("music"):
		story.state.music = {"song": "october_23", "variant": "a", "playing": false, "automatic": true, "position": 0.0}
	return story.state.music

func available() -> Array:
	var completed: Array = story.state.consumed.duplicate()
	# Consumed includes a scene on entry. Its reply (or final delivery) must finish
	# before its reward becomes visible. Earlier scenes have already completed.
	if not story.journal().complete or story.delivery_pending():
		completed.erase(story.state.node)
	return catalog.filter(func(track: Dictionary) -> bool:
		return track.after.is_empty() or track.after.any(func(scene: String) -> bool: return scene in completed))

func track(id: String) -> Dictionary:
	for entry: Dictionary in catalog:
		if entry.id == id: return entry
	return {}

func suggested() -> String:
	var chapter := int(story.current().chapter)
	var candidates: Array = ["a_green_light", "october_23"]
	if chapter >= 2: candidates.push_front("two_windows")
	if chapter >= 3: candidates.push_front("away_for_dinner")
	if chapter >= 5: candidates.push_front("the_long_way_back")
	if story.state.node in ["end_together", "end_distance", "end_friendship", "end_goodbye", "end_open", "end_secret"]:
		candidates.push_front("two_windows")
	var unlocked: Array = available().map(func(entry: Dictionary) -> String: return entry.id)
	for id: String in candidates:
		if id in unlocked: return id
	return "october_23"

func sync(model: RefCounted, restore := false) -> void:
	story = model
	var settings := options()
	var unlocked: Array = available().map(func(entry: Dictionary) -> String: return entry.id)
	var id: String = settings.song
	if settings.automatic:
		var mood := suggested()
		id = mood if mood in unlocked else "october_23"
	if id not in unlocked: id = "october_23"
	if settings.song != id:
		settings.song = id
		settings.position = 0.0
	var path: String = track(id).variants[settings.variant].path
	if path != loaded_path or restore:
		player.stop()
		loaded_path = path
		player.stream = load(path) as AudioStream
		error = "" if player.stream != null else "This recording could not be loaded."
		if player.stream != null:
			var position := clampf(float(settings.position), 0.0, maxf(0.0, player.stream.get_length() - 0.1))
			player.play(position)
	player.stream_paused = suspended or not settings.playing

func select(id: String, variant: String) -> bool:
	if variant not in ["a", "b"] or not available().any(func(entry: Dictionary) -> bool: return entry.id == id): return false
	var settings := options()
	settings.song = id
	settings.variant = variant
	settings.automatic = false
	settings.playing = true
	settings.position = 0.0
	sync(story, true)
	changed.emit()
	return true

func toggle() -> void:
	options().playing = not options().playing
	sync(story)
	changed.emit()

func automatic() -> void:
	options().automatic = not options().automatic
	sync(story)
	changed.emit()

func next() -> void:
	var list := available()
	if options().automatic: list = list.filter(func(entry: Dictionary) -> bool: return not entry.vocals)
	var index := -1
	for i in range(list.size()):
		if list[i].id == options().song: index = i
	var next_track: Dictionary = list[(index + 1) % list.size()]
	select(next_track.id, options().variant)

func remember() -> void:
	if story != null and loaded_path != "" and player.stream != null:
		options().position = maxf(0.0, player.get_playback_position())

func set_volume(value: float) -> void:
	volume = clampf(value, 0.0, 1.0)
	var bus := AudioServer.get_bus_index("Music")
	if bus != -1:
		AudioServer.set_bus_volume_db(bus, linear_to_db(maxf(volume, 0.0001)))
		AudioServer.set_bus_mute(bus, volume == 0.0)

func suspend(value: bool) -> void:
	suspended = value
	if story != null: sync(story)

func _finished() -> void:
	# Replay the whole recording. Generated files have not been edited for a
	# seamless loop, so do not claim sample-accurate looping.
	if story != null and options().playing:
		options().position = 0.0
		player.play()
		player.stream_paused = suspended
