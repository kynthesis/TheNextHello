# The Next Hello

A branching story about long-distance love, told through Asahi's account on an original fictional social network. Meet by chance in Lantern Quest, share ordinary days, and make choices that change friendships, trust, travel and the future.

Godot 4.7.2. The complete playable first draft has six acts, three activity paths, 94 authored scenes and eight endings. Read the [story script](design/STORY-SCRIPT.md) or [implemented consequence map](design/STORY-CHOICES.md). About 12,800 words including replies and guidance; reader-tested pacing and final art remain pending.

## Play

Open `project.godot` and press **F5**, or run:

```powershell
godot --path .
```

Home uses a compact section grid, private photo shelf and Notifications entry. News Feed, Profile, Friends, Photos, Events and Messages have familiar names. Games holds Lantern Quest; Work, Notes and Settings support the story. The original visual theme uses deep teal, warm paper, muted coral and custom pixel icons. There is no phone shell, battery bar or gesture indicator. The site fills the window and adapts between one, two and three columns, starting at 1120×800. One standard text size is supported.

Use **Continue in Games** to begin. **Notes** always links to the next story action. News Feed is an optional set of authored updates; private chat and client drafts never appear there. Contacts unlock through the current run. **Like** saves a reaction; **Comment** opens an authored comment without advancing the story.

Select a complete reply to watch Asahi compose it. **Finish typing** skips composition; **Send reply** commits it. Incoming messages show typing dots; outgoing replies show Sent then Read. **Show messages now**, Instant messages and Reduce Motion skip presentation waits. **Later** explicitly advances fictional time. Section links, mouse/touch scrolling, Tab/Enter and Escape support navigation. Escape returns Home or closes notifications.

Existing phone-era story saves retain position, choices, drafts, private histories, read states, reactions and commitments. The internal `Calendar` save key is displayed as Events. Only stable narrative keys are stored; opening a section never sends a draft or changes story facts. Save writes retain a recoverable previous version. No external social services or accounts are used.

## Validate

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools/check.ps1
```

Checks cover all 131 flow nodes and eight endings on every activity path, conditional choices, save recovery, migration, typing, receipts, section navigation, feed privacy, notifications and responsive layouts from narrow windows through ultrawide. The UI suite opens a Godot window and saves screenshots to ignored `.local/`. QA saves are isolated from play sessions.

See the [GDD](design/GDD.md), [social UI spec](design/SOCIAL-UI.md), and [implementation notes](design/IMPLEMENTATION.md). The principal characters are Tachibana Asahi, 29, in Tokyo and Yukimura Mizuki, 23, in Sapporo. Final illustrations, localization, expanded save slots/replay, screen-reader support, human playtesting and platform exports remain future work. PC/Steam, iOS and Android are target platforms; exports have not been certified.
