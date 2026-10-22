# Complete branching story first draft

Updated 22 October 2026. Godot 4.7.2. The full plot is now playable; this is an editorial first draft with temporary illustrations, not a release candidate or a measured 3–4 hour experience.

## Story and authoring

- Six acts from a coincidental October 2009 game encounter through winter decisions and spring epilogues. Asahi and Mizuki are strangers when matched; Daichi only appears later. Mizuki, Natsumi, Daichi and Misaki have separate contexts and personal commitments.
- Three activity paths and eight complete endings: two good, two bad, two neutral, one open and one secret. Friendship and amicable separation are complete outcomes. Bad outcomes require explicit sustained choices or refusal after a further repair offer. The secret finale requires a mutually chosen, kept and renewed ritual and respects the current path and travel plan.
- 94 authored scenes and 37 generated explicit time gates: 131 flow nodes, about 11,400 words including replies and guidance. The former 44-scene proposal is superseded by this finer-grained first draft. It remains substantially shorter than the earlier release word budget; no reading-duration claim has been verified.
- [STORY-SCRIPT.md](STORY-SCRIPT.md) contains every authored line, choice, condition, next scene and ending. [STORY-CHOICES.md](STORY-CHOICES.md) maps decisions to implemented later events.
- Dialogue Manager v4.1.0 (commit `a719088aea342572f29b5559fd8726896c9519b2`) is bundled under `addons/dialogue_manager` with its MIT license. All 131 scene cues and 753 stable line/reply IDs live in six native `.dialogue` files. Runtime reads use `DialogueResource.get_next_dialogue_line` and the custom mobile UI. `content/story.json` owns plot metadata and effects; `content/characters.json` owns cast profiles. `tools/build_content.py` invokes the upstream compiler through `tools/compile_dialogue.gd`, regenerating the audit cache, manuscript and branch witnesses. The old Python dialogue writers are removed.
- Facts, filtered choices, conditional lines, ordered destination rules and conditional fact updates drive the graph. A sent intention may lead to a waiting node; only an explicit Later action crosses to another story date. Uncertainty or canceled travel cannot erase a physical meeting that already occurred.
- Photos collects the images earned by this run, with descriptions and privacy context. Calendar shows the current fictional date and actual commitments. Notes omits generated time gates from its completed-events list. Ending completion is a real terminal state, not an opening-prototype label.

## Messaging presentation

- Incoming messages display an animated typing indicator, naming the upcoming speaker, then arrive one at a time. Longer replies take a little longer (0.65–1.8 seconds); receipts and saved notes use shorter delays. Outgoing committed replies display Sent followed by Read. These are simulated presentation states, not real service receipts and never a relationship score.
- A selected reply types into Asahi's unsent composer character by character, with short pauses at punctuation. Send remains separate and is disabled until composition completes or the player chooses Finish typing. Complete choice wording is always visible before selection and stays unchanged by the animation.
- The story now starts on 23 October 2009 and ends in spring 2010. A humanizer pass replaces polished speeches with direct requests, jokes and unfinished feelings; casual lowercase chat, brb/btw/lol and text smileys follow each voice. Work messages remain practical. All five profiles have age-consistent birthdays, signs, interests, habits, favorites and private motives. Zodiac signs have no effect on endings. Human reader feedback is still pending.
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

## Runtime and save compatibility

Create a run with `await HelloStory.create()`. Scene entry, Send, Later, reset and load await Dialogue Manager; drafting, receipts, validation and writes remain synchronous. Pure `choice_allowed` and `line_allowed` predicates query the story metadata. Scene reads yield native stable IDs and allowed replies; metadata applies effects once. No compiled line offset or engine resource is stored in the save. Old saves retain the exact narrative position and unsent choice while displaying the revised period text and dates. The upstream example balloon is not used.

Native dialogue is read-only: do not put mutations in these files. Keep effects in story metadata so presentation, re-reading and save recovery cannot repeat them. The compiler rejects mutation lines. A new scene needs a stable cue plus matching story metadata. Adding/removing a reply also requires its ID, destination, effect and any eligibility rule in that metadata.

The adapter releases the temporary resource self-links inserted by the upstream runtime after each read. This keeps chapter resources reclaimable without changing vendored addon code. UI text comes from the resolved native lines/responses, while saves continue storing stable IDs.

## Music

`tools/prepare_music.py` validates the 24 WAV masters and their license PDF headers, checks unlock scene IDs and produces normalized Vorbis playback copies plus `content/music.json`. It preserves source files and records source SHA-256 hashes, durations and license paths. WAV masters and license directories have `.gdignore` files; only the OGG playback resources enter Godot imports. Matching a PDF filename and header is an inventory check, not a legal review of its contents.

`scripts/music.gd` owns a non-positional AudioStreamPlayer routed to the Music bus. Volume uses dB conversion independently of interface sounds. Availability derives from committed story history, excluding the current unfinished scene; an ending rewards its song after message delivery finishes. New saves start with three songs and playback paused. Choosing a song or A/B candidate enables manual listening. Follow story chooses an unlocked instrumental appropriate to the phase, respecting the actual ending. The supplied Same Time Next Week candidates are treated as vocal following the latest brief, so they remain manual listening until a separate instrumental is provided.

Optional `state.music` stores song ID, A/B variant, automatic selection, playing intent and position. Older saves lacking the dictionary remain valid. Validation rejects unknown song IDs, variants and malformed positions. Loading reconstructs audio without replaying narrative effects; suspension pauses the stream while keeping playback intent. Repeat restarts the complete recording; seamless loop editing and listening QA remain pending.

`tests/test_music.gd` covers all 24 resources and durations, all unlock trigger scenes, selection guards, draft behavior, save restoration, old-save compatibility and volume/suspension. On Windows it uses headless display with WASAPI audio because Godot 4.7.2's Dummy audio driver retains OGG playback objects after rapid test pause/seek transitions. The UI suite also exercises music controls, hidden tracks and portrait fitting, with a screenshot at `.local/social_music.png`.
