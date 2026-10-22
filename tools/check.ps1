# Keep validation saves and Godot settings inside the ignored workspace folder.
$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path $PSScriptRoot -Parent
$oldAppData = $env:APPDATA
$oldLocalAppData = $env:LOCALAPPDATA
try {
    $env:APPDATA = Join-Path $projectRoot '.local/qa/appdata'
    $env:LOCALAPPDATA = Join-Path $projectRoot '.local/qa/localappdata'
    New-Item -ItemType Directory -Force -Path (Join-Path $projectRoot '.local') | Out-Null
    & godot --headless --path $projectRoot --import
    if ($LASTEXITCODE -ne 0) { throw 'Asset import failed.' }
    & python (Join-Path $projectRoot 'tools/build_content.py')
    if ($LASTEXITCODE -ne 0) { throw 'Native dialogue compilation or graph audit failed.' }
    & godot --headless --path $projectRoot --script res://tests/test_story.gd
    if ($LASTEXITCODE -ne 0) { throw 'Story tests failed.' }
    # Exercise the audio mixer with no display. Dummy audio in Godot 4.7.2 can
    # retain OGG playback objects at shutdown after rapid pause/seek operations.
    & godot --headless --audio-driver WASAPI --path $projectRoot --script res://tests/test_music.gd
    if ($LASTEXITCODE -ne 0) { throw 'Music tests failed.' }
    & godot --path $projectRoot --script res://tests/test_social.gd
    if ($LASTEXITCODE -ne 0) { throw 'Social UI tests failed.' }
} finally {
    $env:APPDATA = $oldAppData
    $env:LOCALAPPDATA = $oldLocalAppData
}
