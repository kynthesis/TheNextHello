# First playable implementation

Built 22 October 2026 with Godot 4.7.2. This implements the opening validation milestone in GDD §17; it is not the six-act release or an approval of all proposed design details.

## Implemented

- Asahi's point of view throughout the shell: only the phone is visible, with a 414×896 default window. Wider windows add plain margins. Home shows Tokyo and the local story clock, Messages uses a contact header and "Me" for sent messages, Settings shows Asahi's account, and all 20 Notes reminders use his voice. The previous exterior title/instructions and relationship tagline are removed.

- A simple Notes utility holds chapter titles, current objectives, unsent-draft reminders, completed tasks and links to the next app. Home contains app navigation rather than a mission panel. Guidance is authored for all 20 nodes and derives completion from saved transitions, preserving older saves without a schema change.
- Numbered unread bubbles use saved per-app update IDs alongside notification history. Notes tracks the latest changed objective; Photos tracks new images; Calendar tracks changed commitments, work availability and meeting plans. The same event is counted once per app. Opening an app clears its own updates, and Mark All as Read clears all bubbles. Older saves gain the new read-state field without losing story progress.

- A fixed 414:896 phone that scales uniformly inside portrait, desktop and ultrawide windows. The stationery-style home screen has app icons, one page, a status bar and a Home indicator. Text reflows inside the same device proportions.
- Minimal warm surfaces, midnight-blue text, restrained coral accents and familiar pixel icons. Decorative wallpaper, oversized Home clock, duplicate dock, panel shadows and paper textures/settings are removed. Navigation and notification surfaces are flat. Reduce Motion disables app transitions. One standard text size is supported; Home uses four columns and app headers stay horizontal.
- Mouse dragging and touch scroll app content, return Home from the bottom edge, and open Notification Center from the top. Visible button and keyboard alternatives remain available.
- Saved notification history, unread app badges, clickable banners and notification deep links. Original tap, sent and received sounds have a dedicated volume control. Closing or revisiting an app cannot duplicate an event notification.
- Creator-confirmed cast: Tachibana Asahi, 29, and Yukimura Mizuki, 23. Earlier saves migrate speaker names and saved commitment text while preserving story position.
- Twenty story nodes: a two-action cooperative garden encounter, a first private conversation, three invitations, distinct party/private/call events, alternatives within each, and route-specific follow-ups.
- Explicit draft/Send separation, no real-time deadlines, and a confirmation before authored time jumps.
- Seven essential apps: Messages, Games (Lantern Quest), Work, Photos, Calendar, Notes and Settings. Standalone social, music, video and book libraries and Home pagination are removed.
- Versioned local JSON saves with checked writes, previous-valid backups, defensive loading, an autosave and one manual slot. Drafts, log, choices, facts, app, per-app scroll, favorites, note, and music selection/play state are stored. Saves also occur on normal window close and application suspension. Older app names migrate in saved navigation, notifications, badges and scroll; retired apps return to Home. Legacy optional-library data remains preserved but has no playback or app UI.
- One standard text size, interface sound volume, plus window-resolution presets. Earlier saved text-scale preferences are ignored. No forced typing delays.

## Runtime choice

`scripts/story.gd` interprets a small JSON graph rather than introducing Ink or Yarn at this stage. The opening only needs lines, choices, state writes, explicit day transitions and terminals. Content is separate from presentation, and story effects only occur on committed transitions. `tools/build_content.py` authors `content/opening.json`, using stable English string IDs. Editing the generated JSON directly works but is overwritten by regeneration; edit the Python authoring source for durable changes. UI localization is not implemented yet.

`scripts/phone.gd` owns presentation, gestures, flat surfaces, notifications and app navigation. `scripts/app_icon.gd` draws code-native app icons. Earlier wallpaper and texture assets are retained as unused source assets. `scripts/pixel_art.gd` draws temporary illustrations on a consistent 160×90 coordinate grid. Interface sounds are generated in memory from original sequences. No sprite or audio assets are being presented as final commissioned art.

The installed Swallowtail CLI was used for liveness inspection, cold script validation, and a final screenshot of the running game. Initial runtime connections inside the sandbox failed; launching the playable build outside the sandbox restored its direct-server connection. Repeatable visual verification runs a rendered Godot CLI test and captures viewport PNGs for inspection. No alternate MCP was necessary.

## Verification

`tools/check.ps1` isolates Godot settings and saves under ignored `.local/qa/`.

- Story runner: every node and transition, all three invitations, distinct future event IDs, unsent drafts, exact JSON snapshot restoration, duplicate prevention, backup recovery, notification validation, essential-app links and earlier-save cast/app migration.
- Rendered UI runner: actual mouse/touch input for swipes and icon taps; notification history, read status, banners and sounds; every essential app; sound mute; reduced-motion alternatives; fixed aspect ratio and complete device containment at 1280×720, 1920×1080, 2560×1440, 3440×1440 and 360×800, with standard text in Messages, Home and Notes and horizontal content-containment checks. Screenshots include Home, notifications, a draft, an incoming banner, portrait layouts. Runtime/shader errors fail the test.
- Swallowtail cold script validation is used alongside the Godot test runners.

Automated rendering and file inspection are not a human usability test. The GDD's five-reader gate is still pending. Mobile exports, device safe areas, screen readers and full keyboard-only playthroughs have not been certified.

## Next content milestone

The D01 invitation has distinct immediate playable events and a later follow-up on each path. Each follow-up records two future event IDs; those subsequent activities are not implemented yet and do not satisfy the release ledger's full later-playable-consequence contract. No ending resolver is included, and no prototype terminal is labeled a finished relationship ending.

Next, author and implement the party small-party/after-game events, private illustration/buddy-read events, and shared-life leave/friend-introduction events. Then add the representative privacy/repair, meeting, and friendship sequences from the GDD's narrative-slice gate. Production-scale art and additional content should follow a reviewed visual target and first-reader feedback.

## Updated release plan

The GDD proposes eight distinct endings (two good, two bad, two neutral, one open, one secret) and a revised 44-scene budget. These are design targets, not implemented endings. The chance-encounter opening, seven essential apps and minimal UI are implemented. Existing `guild_*` IDs are retained for save compatibility but their visible fiction uses ordinary game parties; Daichi does not introduce the couple.
