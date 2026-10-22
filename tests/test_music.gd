extends SceneTree

const Story := preload("res://scripts/story.gd")
const Music := preload("res://scripts/music.gd")
var passed := 0
var failed := 0
var paths: Array = JSON.parse_string(FileAccess.get_file_as_string("res://tests/story_paths.json"))

func check(condition: bool, label: String) -> void:
	if condition: passed += 1
	else:
		failed += 1
		push_error("FAIL: " + label)

func fixture(id: String) -> HelloStory:
	var run := await Story.create()
	for path: Dictionary in paths:
		if path.name != "node:" + id: continue
		for step: String in path.steps:
			if step == "later": await run.later()
			else:
				run.draft(step)
				await run.send()
		return run
	check(false, "fixture exists: " + id)
	return run

func ids(library: Node) -> Array:
	return library.available().map(func(entry: Dictionary) -> String: return entry.id)

func _initialize() -> void:
	await process_frame
	var library := Music.new()
	root.add_child(library)
	library.set_volume(0.0)
	var model := await Story.create()
	library.sync(model)
	check(ids(library) == ["october_23", "lunch_break", "the_last_bus"], "exactly three starting songs")
	check(not library.options().playing and library.player.stream_paused, "new game starts with music paused")
	for entry: Dictionary in library.catalog:
		for version: String in ["a", "b"]:
			var recording: Dictionary = entry.variants[version]
			var stream: AudioStream = load(recording.path)
			check(stream != null and stream.get_length() > 30, "playable imported recording: " + entry.id + version)
			check(absf(stream.get_length() - float(recording.seconds)) < 0.2, "conversion preserves duration: " + entry.id + version)
			check(FileAccess.file_exists("res://" + recording.license), "matching license: " + entry.id + version)
		for scene: String in entry.after:
			model = await fixture(scene)
			library.sync(model, true)
			var already_unlocked: bool = entry.id in ids(library)
			if not already_unlocked:
				check(not library.select(entry.id, "a"), "cannot play current scene's unearned song: " + scene)
			if not model.choices().is_empty():
				model.draft(model.choices()[0].id)
				check((entry.id in ids(library)) == already_unlocked, "drafting does not unlock: " + scene)
				await model.send()
			elif model.current().has("later"):
				await model.later()
			model.reveal_all()
			library.sync(model)
			check(entry.id in ids(library), "completed trigger unlocks: " + scene)
			check(library.select(entry.id, "b"), "both variants share the unlock: " + scene)
			library.automatic()
			check(not library.track(library.options().song).vocals, "automatic playback excludes vocals: " + scene)
	for ending: String in ["end_friendship", "end_goodbye", "end_unsaid", "end_burnout", "end_open"]:
		model = await fixture(ending)
		model.reveal_all()
		library.sync(model, true)
		check(("your_coat" in ids(library)) == ("romantic_date" in model.state.consumed), "romantic song depends on past date, not ending label: " + ending)
	model = await Story.create()
	library.sync(model, true)
	check(library.select("lunch_break", "b"), "manual track selection")
	library.player.seek(12.0)
	library.remember()
	library.toggle()
	check(not library.options().automatic and not library.options().playing, "manual selection and pause persist as data")
	check(model.save_to("user://test_music.json"), "music settings save")
	var restored := await Story.create()
	check(await restored.load_from("user://test_music.json"), "music settings load")
	library.sync(restored, true)
	check(library.options().song == "lunch_break" and library.options().variant == "b" and not library.options().playing, "selected track, version and pause restored")
	check(absf(library.player.get_playback_position() - 12.0) < 0.5, "playback position restored")
	var legacy: Dictionary = restored.state.duplicate(true)
	legacy.erase("music")
	check(restored.valid(legacy), "older saves remain valid without music options")
	for bad: Variant in [{}, {"song": "missing", "variant": "a", "playing": false, "automatic": true, "position": 0}, {"song": "october_23", "variant": "c", "playing": false, "automatic": true, "position": 0}, {"song": "october_23", "variant": "a", "playing": false, "automatic": true, "position": -1}]:
		var invalid: Dictionary = restored.state.duplicate(true)
		invalid.music = bad
		check(not restored.valid(invalid), "malformed music settings rejected")
	library.set_volume(0)
	check(AudioServer.is_bus_mute(AudioServer.get_bus_index("Music")), "zero volume mutes music bus")
	library.set_volume(0.5)
	check(not AudioServer.is_bus_mute(AudioServer.get_bus_index("Music")), "raising volume unmutes music")
	library.toggle()
	library.suspend(true)
	check(library.player.stream_paused and library.options().playing, "application pause retains playback intent")
	library.suspend(false)
	check(not library.player.stream_paused, "application resume restores playback")
	DirAccess.remove_absolute("user://test_music.json")
	DirAccess.remove_absolute("user://test_music.json.bak")
	library.queue_free()
	await create_timer(0.15).timeout
	print("Music tests: %d passed, %d failed" % [passed, failed])
	quit(1 if failed else 0)
