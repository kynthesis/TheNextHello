# The Next Hello

Fall in love one message at a time in a pixel art phone simulator. Meet through an online game, share photos, and navigate love, friendship, and distance through connected apps. Your choices shape the relationship and what happens when it's time to meet in person.

The project now includes a playable Godot 4.7.2 opening prototype. Meet Mizuki in Lantern Quest, draft and send replies, then choose a guild activity, a private postcard, or an everyday-life call. Each invitation leads to a different playable continuation and follow-up.

The screen contains only Asahi's personal phone. It opens in a 414×896 portrait window; wider windows leave plain dark margins around the device. Home shows his Tokyo clock, Notes contains his personal reminders, and Settings holds his account.

## Play

Open `project.godot` in Godot and press **F6** with `scenes/phone.tscn` open, or **F5** to run the project. From this directory:

```powershell
godot --path .
```

Open **Notes** for your current chapter, objective, and completed tasks. Press **Continue in Lantern Quest** to start the opening. Notes always links to the app where your next action takes place, and updates from your saved story progress without revealing unchosen paths. Chapter and objective guidance stays inside Notes rather than a home-screen mission panel.

Red numbered bubbles on app icons show unseen updates. New objectives flag Notes, new photos flag Gallery, and changed plans flag Calendar. Opening an app clears only its own bubble; read status persists across saves. Updates already displayed in the active app do not remain marked as new.

Select a reply, then press **Send reply** to commit it. **Later** explicitly advances story time. Tap app icons to open them. Swipe or mouse-drag left/right between home pages, drag vertically to scroll, swipe up from the bottom to go Home, and swipe down from the top for Notification Center. The home indicator, page dots and status-bar button provide click/keyboard alternatives; Escape returns Home or closes notifications. Tab and Enter navigate controls.

The phone uses a cozy stationery style: warm cream panels, midnight-blue text, muted coral accents, grid-drawn pixel icons and a pixel landscape wallpaper. Navigation, dock and notifications use subtle, stationary paper texture. The device always keeps its **414:896 aspect ratio**, including at 200% text size. Settings offers window resolution presets, separate music/interface volumes, Reduce Motion, Simplify Paper Texture, manual saving and a new-opening confirmation. New story events create saved, tappable notifications with unread badges and original sounds; ordinary navigation never advances the story.

All ten apps have readable content and an interaction. Resonance plays four original looping music sketches; Vista and Loop use six captioned storyboards as temporary media. Gallery and Calendar reflect your story choices. Ordinary browsing, notes, favorites, drafts, and story state persist locally, with a recoverable save backup. No external services are used.

This build covers the opening, with temporary pixel illustrations. The six-act story, later playable consequences, full video assets, ending families, ten manual slots, rotating autosaves, localization and platform exports remain future work. See [implementation notes](design/IMPLEMENTATION.md).

## Validate

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools/check.ps1
```

The checks cover all 20 narrative nodes, drafts, route divergence, save recovery and cast migration, app rendering, mouse/touch gestures, notifications, sounds, paper texture settings and fixed phone proportions from portrait to ultrawide. The UI check briefly opens a Godot window and writes screenshots into ignored `.local/`. Validation uses isolated saves, separate from play sessions.

- [Game Design Document](design/GDD.md) — concept, core loop, phone apps, characters, narrative arc, relationship rules, endings, presentation, scope, and validation plan.

Creator direction: a Japanese game with a male protagonist and a female love interest living in Hokkaido. The confirmed leads are Tachibana Asahi, 29, and Yukimura Mizuki, 23. The prototype places them in Tokyo and Sapporo, Hokkaido; city and supporting-story details remain editable.

- [Branching story and choice ledger](design/BRANCHING-STORY.md) — three paths and eight major decisions that change events.
- [Phone apps and immersion](design/PHONE-APPS.md) — ten connected apps, including music, social, video, books, and work.

Target platforms: PC/Steam, iOS, and Android. The central names and ages, consequential branching, fixed phone proportions and expanded phone are creator requirements; the earlier iOS/liquid-glass theme restriction has been lifted, and the current stationery style is the chosen visual direction; paths, content budgets, supporting identities and app branding remain proposals.
