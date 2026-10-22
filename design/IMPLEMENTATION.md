# Complete branching story first draft

Updated 22 October 2026. Godot 4.7.2. The full plot is now playable; this is an editorial first draft with temporary illustrations, not a release candidate or a measured 3–4 hour experience.

## Story and authoring

- Six acts from a coincidental October game encounter through winter decisions and spring epilogues. Asahi and Mizuki are strangers when matched; Daichi only appears later. Mizuki, Natsumi, Daichi and Misaki have separate contexts and personal commitments.
- Three activity paths and eight complete endings: two good, two bad, two neutral, one open and one secret. Friendship and amicable separation are complete outcomes. Bad outcomes require explicit sustained choices or refusal after a further repair offer. The secret finale requires a mutually chosen, kept and renewed ritual and respects the current path and travel plan.
- 94 authored scenes and 37 generated explicit time gates: 131 flow nodes, about 12,800 words including replies and guidance. The former 44-scene proposal is superseded by this finer-grained first draft. It remains substantially shorter than the earlier release word budget; no reading-duration claim has been verified.
- [STORY-SCRIPT.md](STORY-SCRIPT.md) contains every authored line, choice, condition, next scene and ending. [STORY-CHOICES.md](STORY-CHOICES.md) maps decisions to implemented later events.
- `tools/build_content.py` keeps the stable opening IDs. `tools/story_chapters.py` authors the remaining acts. Regeneration produces `content/opening.json`, the manuscript and `tests/story_paths.json`. Edit authoring sources for durable changes.
- Facts, filtered choices, conditional lines, ordered destination rules and conditional fact updates drive the graph. A sent intention may lead to a waiting node; only an explicit Later action crosses to another story date. Uncertainty or canceled travel cannot erase a physical meeting that already occurred.
- Photos collects the images earned by this run, with descriptions and privacy context. Calendar shows the current fictional date and actual commitments. Notes omits generated time gates from its completed-events list. Ending completion is a real terminal state, not an opening-prototype label.

## Messaging presentation

- Incoming messages display an animated typing indicator, naming the upcoming speaker, then arrive one at a time. Longer replies take a little longer (0.65–1.8 seconds); receipts and saved notes use shorter delays. Outgoing committed replies display Sent followed by Read. These are simulated presentation states, not real service receipts and never a relationship score.
- A selected reply types into Asahi's unsent composer character by character, with short pauses at punctuation. Send remains separate and is disabled until composition completes or the player chooses Finish typing. Complete choice wording is always visible before selection and stays unchanged by the animation.
- The Emily is Away reference informs an initial voice pass on the chance encounter, ordinary calls, visit planning/arrival/return, conflict, space, confession and first date. Short messages and mundane callbacks carry more of the emotion. The rest of the manuscript still needs the same editorial attention and reader feedback.
- Show messages now, Instant messages and Reduce Motion skip presentation waits without selecting or sending anything. Closing or changing apps never sends a draft.
- Delivered-message cursor and Sent/Read states are saved. Older saves without presentation metadata load as already delivered. A saved partial composition restores its complete unsent text rather than resuming a fragile character tween. Suspension pauses timers/tweens; returning resumes presentation without advancing story time.
- Messages offers separate contact/group threads. Games and Work keep their own histories. Thread navigation cannot advance the story or expose another contact's conversation inside the selected thread.

## Social network and saving

The game uses a 414×896 portrait social app with exactly seven sections: News Feed, Profile, Friends, Photos, Events, Messages and Requests. Original teal, warm paper and coral styling preserves the nostalgic mobile menu reference. No desktop sidebars. Events combines objectives, commitments and completed history; stable Games/Work/Notes/Calendar keys remain compatible. Settings is a header utility. Profiles support local free-text statuses, comments and idempotent shares of friends' approved posts. Accepted requests expose friend profiles/photos; Natsumi is an existing friend. Own photos and private DM attachments are separate. Social data is validated and saved with safe defaults for old saves. See [SOCIAL-UI.md](SOCIAL-UI.md).

Local JSON saves retain story position, unsent drafts, facts, consumed event IDs, histories, notifications, read state, scroll and presentation state. Checked writes and previous-valid backups remain. Opening-era app and cast names migrate without restarting the story; existing terminal opening saves now have a continuation. Legacy optional-library fields remain harmless saved data with no active app or playback UI.

## Verification and remaining work

`tools/validate_content.py` exhaustively explores decision-relevant state and verifies every node, valid conditional choices, ending guards and all eight endings on each of the three activity paths. It emits compact witness paths for Godot. `tests/test_story.gd` replays those paths through the real runtime and checks saves, recovery, legacy migration, presentation isolation and explicit date transitions.

`tests/test_social.gd` renders every section and every ending, checks separate contact histories, actual mouse/touch gestures, drafts, typing dots, character composition, Sent/Read display, animation skipping, unread badges, sounds and portrait app fitting from portrait through ultrawide. Screenshots are written to ignored `.local/`. `tools/check.ps1` isolates QA saves and settings. Swallowtail performs cold script checks; Godot CLI performs imports and tests.

Automated coverage does not certify emotional pacing, cultural nuance or usability. First-reader feedback, final art, localization, expanded save slots/replay, screen readers, device safe areas and platform exports remain pending. The earlier 45,000–60,000-word release estimate is not presented as delivered by this first draft.
