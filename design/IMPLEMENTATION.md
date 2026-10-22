# First playable implementation

Built 22 October 2026 with Godot 4.7.2. This implements the opening validation milestone in GDD §17; it is not the six-act release or an approval of all proposed design details.

## Implemented

- A simple Notes utility holds chapter titles, current objectives, unsent-draft reminders, completed tasks and links to the next app. Home contains app navigation rather than a mission panel. Guidance is authored for all 20 nodes and derives completion from saved transitions, preserving older saves without a schema change.
- Numbered unread bubbles use saved per-app update IDs alongside notification history. Notes tracks the latest changed objective; Gallery tracks new images; Calendar tracks changed commitments, work availability and meeting plans. The same event is counted once per app. Opening an app clears its own updates, and Mark All as Read clears all bubbles. Older saves gain the new read-state field without losing story progress.

- A fixed 414:896 phone that scales uniformly inside portrait, desktop and ultrawide windows. The iOS-style home screen has app icons, two swipeable pages, a dock, a status bar and a Home indicator. Text reflows inside the same device proportions.
- Liquid-glass shaders sample the live backdrop with blur, rounded-edge refraction, highlights and subtle edge color separation. Dock, widgets, navigation and notification surfaces take separate backdrop snapshots. Reduce Transparency gives opaque surfaces; Reduce Motion disables app opening transitions and pointer-reactive highlights.
- Mouse dragging and touch navigate home pages, scroll app content, return Home from the bottom edge, and open Notification Center from the top. Visible button and keyboard alternatives remain available.
- Saved notification history, unread app badges, clickable banners and notification deep links. Original tap, sent and received sounds have separate volume from music. Closing or revisiting an app cannot duplicate an event notification.
- Creator-confirmed cast: Tachibana Asahi, 29, and Yukimura Mizuki, 23. Earlier saves migrate speaker names and saved commitment text while preserving story position.
- Twenty story nodes: a two-action cooperative garden encounter, a first private conversation, three invitations, distinct guild/private/call events, alternatives within each, and route-specific follow-ups.
- Explicit draft/Send separation, no real-time deadlines, and a confirmation before authored time jumps.
- Ten app surfaces. Social favorites; four synthesized original looping music sketches; six captioned, manually advanced video storyboards; three original book excerpts and an editable note; a work choice on the call path; canonical Gallery access and Calendar commitments.
- Versioned local JSON saves with checked writes, previous-valid backups, defensive loading, an autosave and one manual slot. Drafts, log, choices, facts, app, per-app scroll, favorites, note, and music selection/play state are stored. Saves also occur on normal window close and application suspension. Audio playback resumes at the beginning of its loop.
- Separate text-size, music and interface volume settings, plus window-resolution presets. No forced typing delays.

## Runtime choice

`scripts/story.gd` interprets a small JSON graph rather than introducing Ink or Yarn at this stage. The opening only needs lines, choices, state writes, explicit day transitions and terminals. Content is separate from presentation, and story effects only occur on committed transitions. `tools/build_content.py` authors `content/opening.json`, using stable English string IDs. Editing the generated JSON directly works but is overwritten by regeneration; edit the Python authoring source for durable changes. UI localization is not implemented yet.

`scripts/phone.gd` owns presentation, gestures, glass surfaces, notifications and app navigation. `scripts/app_icon.gd` draws code-native app icons, with an original SVG wallpaper. `scripts/pixel_art.gd` draws temporary illustrations on a consistent 160×90 coordinate grid. Music and interface sounds are generated in memory from original sequences. No sprite or audio assets are being presented as final commissioned art.

The installed Swallowtail CLI was used for liveness inspection, cold script validation, and a final screenshot of the running game. Initial runtime connections inside the sandbox failed; launching the playable build outside the sandbox restored its direct-server connection. Repeatable visual verification runs a rendered Godot CLI test and captures viewport PNGs for inspection. No alternate MCP was necessary.

## Verification

`tools/check.ps1` isolates Godot settings and saves under ignored `.local/qa/`.

- Story runner: every node and transition, all three invitations, distinct future event IDs, unsent drafts, exact JSON snapshot restoration, duplicate prevention, backup recovery, notification validation and earlier-save cast migration.
- Rendered UI runner: actual mouse/touch input for swipes and icon taps; notification history, read status, banners and sounds; every app; playback and mute; reduced-motion and opaque alternatives; fixed aspect ratio and complete device containment at 1280×720, 1920×1080, 2560×1440, 3440×1440 and 360×800, including 200% text. Screenshots include home pages, notifications, a draft, an incoming banner, portrait and large text. Runtime/shader errors fail the test.
- Swallowtail cold script validation is used alongside the Godot test runners.

Automated rendering and file inspection are not a human usability test. The GDD's five-reader gate is still pending. Mobile exports, device safe areas, screen readers and full keyboard-only playthroughs have not been certified.

## Next content milestone

The D01 invitation has distinct immediate playable events and a later follow-up on each path. Each follow-up records two future event IDs; those subsequent activities are not implemented yet and do not satisfy the release ledger's full later-playable-consequence contract. No ending resolver is included, and no prototype terminal is labeled a finished relationship ending.

Next, author and implement the guild small-party/after-game events, private illustration/buddy-read events, and shared-life leave/friend-introduction events. Then add the representative privacy/repair, meeting, and friendship sequences from the GDD's narrative-slice gate. Production-scale art and additional content should follow a reviewed visual target and first-reader feedback.
