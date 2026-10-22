"""Validate Mureka masters/licenses and build normalized OGG playback copies.

Run before Godot import. Original WAV and PDF files are never modified.
"""
import concurrent.futures
import hashlib
import json
from pathlib import Path
import shutil
import subprocess

ROOT = Path(__file__).resolve().parents[1]
TRACKS = [
    ("october_23", "October 23", False, []),
    ("lunch_break", "Lunch Break", False, []),
    ("the_last_bus", "The Last Bus", False, []),
    ("a_green_light", "A Green Light", False, ["first_dm"]),
    ("four_players", "Four Players", False, ["guild_event", "guild_guide", "private_event", "private_rescheduled", "lives_call", "lives_reschedule"]),
    ("two_windows", "Two Windows", False, ["after_game", "party_rest", "reading_evening", "reading_once", "small_call", "call_once"]),
    ("ink_on_the_table", "Ink on the Table", False, ["showcase", "showcase_setup", "studio_lunch", "studio_preview"]),
    ("away_for_dinner", "Away for Dinner", False, ["natsumi_invite"]),
    ("missed_the_last_train", "Missed the Last Train", True, ["work_adjusted", "work_kept", "work_broken"]),
    ("the_long_way_back", "The Long Way Back", False, ["privacy_repair", "promise_repair", "expectations_talk"]),
    ("your_coat", "Your Coat", True, ["romantic_date"]),
    # Latest brief offers lyrics for this title. Treat the supplied A/B as vocal
    # candidates conservatively until a separate instrumental is provided.
    ("same_time_next_week", "Same Time Next Week", True, ["end_together", "end_distance", "end_friendship", "end_goodbye", "end_unsaid", "end_burnout", "end_open", "end_secret"]),
]


def binary(name):
    found = shutil.which(name)
    if found:
        return found
    candidates = list((Path.home() / "AppData/Local/Microsoft/WinGet/Packages").glob(f"Gyan.FFmpeg*/**/{name}.exe"))
    if not candidates:
        raise RuntimeError(f"{name} is required to prepare music")
    return str(sorted(candidates)[-1])


def digest(path):
    with path.open("rb") as stream:
        return hashlib.file_digest(stream, "sha256").hexdigest()


def main():
    ffmpeg, ffprobe = binary("ffmpeg"), binary("ffprobe")
    output = ROOT / "assets/audio/playback"
    output.mkdir(parents=True, exist_ok=True)
    cache_path = ROOT / ".local/music_build.json"
    cache = json.loads(cache_path.read_text()) if cache_path.exists() else {}
    nodes = json.loads((ROOT / "content/story.json").read_text(encoding="utf-8-sig"))["nodes"]
    jobs, catalog = [], []
    for slug, title, vocals, scenes in TRACKS:
        assert all(scene in nodes for scene in scenes), title
        track = {"id": slug, "title": title, "vocals": vocals, "after": scenes, "variants": {}}
        for version in ("a", "b"):
            stem = f"{slug}_{version}"
            source = ROOT / f"assets/audio/music/{slug}/{stem}.wav"
            license_path = ROOT / f"licenses/music/{slug}/{stem}.pdf"
            if not source.is_file() or not license_path.is_file():
                raise RuntimeError(f"Missing master or license for {stem}")
            if not license_path.read_bytes().startswith(b"%PDF-"):
                raise RuntimeError(f"Invalid PDF header: {license_path}")
            info = json.loads(subprocess.check_output([ffprobe, "-v", "error", "-show_streams", "-show_format", "-of", "json", str(source)]))
            audio = next(stream for stream in info["streams"] if stream["codec_type"] == "audio")
            duration = float(info["format"]["duration"])
            if duration <= 0 or int(audio["channels"]) not in (1, 2):
                raise RuntimeError(f"Invalid audio: {source}")
            checksum = digest(source)
            target = output / f"{stem}.ogg"
            track["variants"][version] = {"path": f"res://assets/audio/playback/{stem}.ogg", "seconds": round(duration, 3), "source_sha256": checksum, "license": license_path.relative_to(ROOT).as_posix()}
            if cache.get(stem) != checksum or not target.exists():
                jobs.append((source, target))
            cache[stem] = checksum
        catalog.append(track)

    def convert(job):
        source, target = job
        temp = target.with_suffix(".tmp.ogg")
        subprocess.run([ffmpeg, "-v", "error", "-y", "-i", str(source), "-map", "0:a:0", "-vn", "-af", "loudnorm=I=-20:TP=-2:LRA=11", "-ar", "44100", "-c:a", "libvorbis", "-q:a", "4", "-threads", "1", str(temp)], check=True)
        temp.replace(target)
        print(f"Prepared {target.name}", flush=True)

    with concurrent.futures.ThreadPoolExecutor(max_workers=2) as pool:
        list(pool.map(convert, jobs))
    (ROOT / "content/music.json").write_text(json.dumps(catalog, indent=2) + "\n", encoding="utf-8")
    cache_path.parent.mkdir(parents=True, exist_ok=True)
    cache_path.write_text(json.dumps(cache, indent=2), encoding="utf-8")
    total = sum(path.stat().st_size for path in output.glob("*.ogg"))
    print(f"Validated 12 songs, 24 WAV masters and 24 license PDFs; playback {total / 1024**2:.1f} MiB")


if __name__ == "__main__":
    main()
