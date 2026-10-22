# Music files

Store each song in its own folder, using lowercase names with underscores. Keep both Mureka versions, labeled `a` and `b`; neither is assumed to be the final selection.

Example:

```text
assets/audio/music/october_23/october_23_a.ogg
assets/audio/music/october_23/october_23_b.ogg
licenses/music/october_23/<original license filenames>
```

Use the actual downloaded extension (`.wav`, `.mp3`, or `.ogg`); changing the extension does not convert audio. Keep the downloaded audio intact until we choose versions and prepare game-ready files.

Store accompanying license files under the matching song folder in `licenses/music/`. Preserve their original filenames and contents. If the download includes separate licenses for A and B, put them in `licenses/music/<song>/a/` and `licenses/music/<song>/b/` respectively.

Song briefs and lyrics live in `design/SOUNDTRACK.md`. Adding files here does not yet add them to the in-game player.
