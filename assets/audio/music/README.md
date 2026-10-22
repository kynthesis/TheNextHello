# Music files

Store each song in its own folder, using lowercase names with underscores. Keep both Mureka versions, labeled `a` and `b`; neither is assumed to be the final selection.

Example:

```text
assets/audio/music/october_23/october_23_a.wav
assets/audio/music/october_23/october_23_b.wav
licenses/music/october_23/<original license filenames>
```

Use the actual downloaded extension (`.wav`, `.mp3`, or `.ogg`); changing the extension does not convert audio. Keep the downloaded audio intact until we choose versions and prepare game-ready files.

Store accompanying license files under the matching song folder in `licenses/music/`. Preserve their original filenames and contents. If the download includes separate licenses for A and B, put them in `licenses/music/<song>/a/` and `licenses/music/<song>/b/` respectively.

Song briefs and lyrics live in `design/SOUNDTRACK.md`. This folder contains the WAV masters and is excluded from Godot imports by `.gdignore`. Game playback uses the smaller OGG copies in `assets/audio/playback/`.

Run `python tools/prepare_music.py` after replacing a master or adding a catalog entry. It validates the 24 masters and matching license PDFs, checks scene references, normalizes playback copies toward -20 LUFS with a -2 dB true-peak target, and writes `content/music.json`. It requires FFmpeg and FFprobe. Master WAVs and license files remain unchanged. Import the generated OGG files in Godot afterward.

The in-game Music header utility supports play/pause, next song, A/B variants, independent volume and an optional automatic instrumental selection. Three songs are available in a new game. Later availability derives from completed scenes; opening a page or drafting a reply cannot unlock a song. Save files retain selection, playback intent and position. Volume is a global preference in settings.
