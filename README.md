# The Next Hello

Fall in love one message at a time in a pixel art phone simulator. Meet through an online game, share photos, and navigate love, friendship, and distance through connected apps. Your choices shape the relationship and what happens when it's time to meet in person.

The project now includes a playable Godot 4.7.2 opening prototype. Meet Mizuki by chance in a randomly matched Lantern Quest session, draft and send replies, then choose a party activity, a private postcard, or an everyday-life call. Each invitation leads to a different playable continuation and follow-up.

The screen contains only Asahi's personal phone. It opens in a 414×896 portrait window; wider windows leave plain dark margins around the device. Home shows his Tokyo clock, Notes contains his personal reminders, and Settings holds his account.

## Play

Open `project.godot` in Godot and press **F6** with `scenes/phone.tscn` open, or **F5** to run the project. From this directory:

```powershell
godot --path .
```

Open **Notes** for your current chapter, objective, and completed tasks. Press **Continue in Games** to start the opening. Notes always links to the app where your next action takes place, and updates from your saved story progress without revealing unchosen paths. Chapter and objective guidance stays inside Notes rather than a home-screen mission panel.

Red numbered bubbles on app icons show unseen updates. New objectives flag Notes, new photos flag Photos, and changed plans flag Calendar. Opening an app clears only its own bubble; read status persists across saves. Updates already displayed in the active app do not remain marked as new.

Select a reply, then press **Send reply** to commit it. **Later** explicitly advances story time. Tap app icons to open them. The seven essential apps share one Home page. Drag vertically to scroll, swipe up from the bottom to go Home, and swipe down from the top for Notification Center. The home indicator and status-bar button provide click/keyboard alternatives; Escape returns Home or closes notifications. Tab and Enter navigate controls.

The phone uses a minimal warm palette, clear labels and simple pixel icons. Home contains seven apps once each, with no decorative wallpaper, large clock, duplicate dock or paper texture controls. The device keeps its **414:896 aspect ratio** with one standard text size. Settings offers window resolution presets, interface sound volume, Reduce Motion, manual saving and a new-opening confirmation. Story events create saved, tappable notifications and unread badges; ordinary navigation never advances the story.

The essential apps are **Messages, Games, Work, Photos, Calendar, Notes, and Settings**. Lantern Quest lives inside Games. The separate social, music, video and book apps are removed. Photos and Calendar reflect story choices. Favorites, drafts and story state persist locally with a recoverable save backup. Older app names migrate automatically, and saves last open in a removed app return to Home. No external services are used.

This build covers the opening, with temporary pixel illustrations. The six-act story, later playable consequences, eight planned endings, ten manual slots, rotating autosaves, localization and platform exports remain future work. See [implementation notes](design/IMPLEMENTATION.md).

## Validate

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools/check.ps1
```

The checks cover all 20 narrative nodes, drafts, route divergence, save recovery and cast migration, app rendering, mouse/touch gestures, notifications, sounds and fixed phone proportions from portrait to ultrawide. The UI check briefly opens a Godot window and writes screenshots into ignored `.local/`. Validation uses isolated saves, separate from play sessions.

- [Game Design Document](design/GDD.md) — concept, core loop, phone apps, characters, narrative arc, relationship rules, endings, presentation, scope, and validation plan.

Creator direction: a Japanese game with a male protagonist and a female love interest living in Hokkaido. The confirmed leads are Tachibana Asahi, 29, and Yukimura Mizuki, 23. The prototype places them in Tokyo and Sapporo, Hokkaido; city and supporting-story details remain editable.

- [Branching story and choice ledger](design/BRANCHING-STORY.md) — three paths and eight major decisions that change events.
- [Phone apps and immersion](design/PHONE-APPS.md) — the seven essential apps and their story connections.

Target platforms: PC/Steam, iOS, and Android. The central names and ages, consequential branching, fixed phone proportions and expanded phone are creator requirements; the earlier iOS/liquid-glass theme restriction has been lifted, and the current stationery style is the chosen visual direction; paths, content budgets, supporting identities and app branding remain proposals.
