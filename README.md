# The Next Hello

A branching story about long-distance love beginning in Japan in October 2009, told through Asahi's account in a recreation of old Facebook mobile. Meet by chance in Lantern Quest, share ordinary days, and make choices that change friendships, trust, travel and the future.

Godot 4.7.2. The complete playable first draft has six acts, three activity paths, 94 authored scenes and eight endings. Read the [story script](design/STORY-SCRIPT.md) or [implemented consequence map](design/STORY-CHOICES.md). About 11,400 words including replies and guidance; reader-tested pacing and final art remain pending.

## Play

Open `project.godot` and press **F5**, or run:

```powershell
godot --path .
```

The game is a nostalgic mobile social app with exactly seven sections: **News Feed, Profile, Friends, Photos, Events, Messages and Requests**. It recreates the supplied old Facebook references with blue gradient bars, the white wordmark, multicolor icons, red badges, a pale background, classic speech bubbles and a 414×896 portrait canvas that scales uniformly inside larger windows. Settings is a header utility; Games and Work are story contexts reached from Events or Messages, not extra menu sections. One standard reading size is supported.

Open **Events** for the current objective and use its Continue link to start. Profile supports local statuses; News Feed displays them alongside friends' updates. Comments and shared friend posts persist. Friends opens accepted profiles and their photos; Photos shows Asahi's own photos. Requests accepts or declines new friends after story encounters. Natsumi is already Asahi's friend. DMs remain available independently of accepting requests. Private work attachments stay in Messages.

Select a complete reply to watch Asahi compose it. **Finish typing** skips composition; **Send reply** commits it. Incoming messages show typing dots; outgoing replies show Sent then Read. **Show messages now**, Instant messages and Reduce Motion skip presentation waits. **Later** explicitly advances fictional time. Section links, mouse/touch scrolling, Tab/Enter and Escape support navigation. Escape returns Home or closes notifications.

Existing phone-era story saves retain position, choices, drafts, private histories, read states, reactions and commitments. The internal `Calendar` save key is displayed as Events. Only stable narrative keys are stored; opening a section never sends a draft or changes story facts. Save writes retain a recoverable previous version. No external social services or accounts are used.

Open **Music** in the header for play/pause, Next, A/B versions, independent music volume and Follow story. The library begins with October 23, Lunch Break and The Last Bus; completed scenes unlock the remaining songs. Locked titles stay hidden. Manual selection stays in control until Follow story is enabled again; automatic selection uses instrumental tracks. Playback starts paused in a new game. Track, version, pause state and position are saved with the run.

The 12 supplied songs have 24 WAV masters and matching license PDFs. Godot plays normalized OGG copies. Run `python tools/prepare_music.py` after replacing masters, then import in Godot. FFmpeg/FFprobe are required for conversion. See [soundtrack and unlocks](design/SOUNDTRACK.md) and [audio storage](assets/audio/music/README.md).

## Validate

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools/check.ps1
```

Checks cover all 131 flow nodes and eight endings on every activity path, conditional choices, save recovery, migration, typing, receipts, section navigation, feed privacy, notifications social requests/posts/comments/shares, and portrait fitting from narrow windows through ultrawide. The UI suite opens a Godot window and saves screenshots to ignored `.local/`. QA saves are isolated from play sessions.

See the [GDD](design/GDD.md), [social UI spec](design/SOCIAL-UI.md), and [implementation notes](design/IMPLEMENTATION.md). The principal characters are Tachibana Asahi, 29, in Tokyo and Yukimura Mizuki, 23, in Sapporo. Final illustrations, localization, expanded save slots/replay, screen-reader support, human playtesting and platform exports remain future work. PC/Steam, iOS and Android are target platforms; exports have not been certified.

## Dialogue and characters

Edit conversations in Godot's Dialogue tab: `content/dialogue/act_01.dialogue` through `act_06.dialogue`. Dialogue Manager 4.1.0 is bundled and pinned; the game uses its runtime with our own chat UI. Keep the `[ID:...]` keys stable because saves refer to them. `content/story.json` holds scene dates, requirements, destinations and consequences. The text in `content/opening.json` is generated for review and audit; it is not the game's dialogue source.

Run `python tools/build_content.py` after editing, or run the complete validation command above. The builder uses Dialogue Manager's compiler and regenerates the manuscript and branch fixtures. Conversation reads are side-effect free. Choosing a draft, typing, Read receipts and loading a save never apply a consequence; Send and Later do.

[Character profiles](design/CHARACTERS.md) cover all five people, birthdays/signs, habits, favorite things, private worries and texting voices. Public profile details come from `content/characters.json`. The English chats borrow American 2009 instant-message habits while keeping the Japanese setting. Short, specific replies replace repeated relationship speeches; all decision meanings and ending routes remain explicit.
