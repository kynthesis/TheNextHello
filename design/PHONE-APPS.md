# The phone: apps and immersion

**Status:** Proposed app design reflecting the creator's requested music, social, video, short-video, book, and work experiences. Companion to [the GDD](GDD.md) and [branching story](BRANCHING-STORY.md). App names are placeholders.

## Ten connected apps

The phone is Haruto's personal device: it contains his routines, interests, friends, and obligations as well as Yui's messages. Existing history and a small authored library make it feel lived in. New content follows fictional story time and player actions. Everything is an authored simulation; no external account is required.

| App | What the player can actually do | How it can change events |
|---|---|---|
| **Messages** | Private and group chat, reactions, attachments, transcript-based calls, drafts, and explicit replies. | Make or break commitments, introduce friends, negotiate boundaries, and change relationship mode. |
| **Lantern Quest** | Guild chat, cooperative encounters, activity invitations, screenshots. | Choose a shared guild project, invite another participant, or leave an activity; open distinct guild and friendship scenes. |
| **Moments — social** | Friend profiles and friend requests; feed posts; photo stories; reels/short clips; captions, comments, reactions, and audience selection. | Accepting a friend request can open a group introduction; sharing with permission can open a collaborative event; a known privacy violation can cancel it. Audience is visible before posting. |
| **Resonance — music** | Play a small original soundtrack library, like tracks, arrange a playlist, and share a track or playlist. Playback can continue while browsing other apps. | An invitation to listen together can become the selected private activity; a jointly made playlist can be used during a visit. Merely choosing a different song is flavor unless tied to an authored decision. |
| **Vista — long video** | Browse authored creator pages, watch short in-universe videos representing longer uploads, read relevant comments, save videos, share links. | Choose a tutorial for a collaborative project or discuss a Hokkaido travel video; accepting a resulting activity opens a creation or planning scene. Watching alone does not silently book anything. |
| **Loop — short video** | Swipe a finite set of authored clips, like/save/share, follow fictional creators, open linked profiles. | Sharing a relevant clip can invite a new activity or start a discussion about expectations. A public reference to the relationship requires an explicit audience/permission choice. No infinite algorithmic feed. |
| **Bookmark — books** | Read short original excerpts, mark a passage, keep a reading note, share a quote, join an offered buddy-read. | An agreed buddy-read opens a dedicated discussion or replaces another optional activity; a conversation about an excerpt can reveal a new personal topic. Book tastes never determine compatibility scores. |
| **Desk — work** | Team messages, assignments, a small task board, leave requests, deadline/availability decisions, and authored work interactions. | Accepting an assignment or requesting leave affects available visit dates and work follow-through scenes. Haruto can develop a professional goal independent of Yui. Decisions are bounded narrative tasks, not an office-management economy. |
| **Gallery** | Browse original photos and screenshots, inspect image descriptions, choose attachments, revisit shared collections. | Provides the actual image and audience context for private/public sharing; an early visit creates a collection that later-meeting paths do not yet have. |
| **Calendar** | Review work and personal commitments, compare availability, propose/reschedule events, review travel plans. | Choosing between explicit overlapping plans selects different events; approved leave and mutually agreed dates determine early, late, or postponed meeting. |

## Why both social reels and a short-video app?

Moments centers on people Haruto knows: their posts, stories, friendships, and small social consequences. Loop centers on discovering clips outside that circle. Vista supports deliberate watching, creator series, and projects. Reuse media controls and canonical content IDs so a cross-post does not become two contradictory versions of the same event.

Friends have privacy and independent interests. A friend request does not grant private messages, private photos, or Yui's secrets automatically. Profiles show what is public and what becomes accessible through an authored acceptance.

## Make it feel like a real personal phone

- Begin with a little history: an old playlist, unfinished book, work thread, friends' posts, and harmless game screenshots. Avoid an empty device waiting for the romance to begin.
- Each contact has consistent interests and posting habits. Not every post is about Haruto, and not every recommendation is a hidden romance clue.
- Let the player listen to music while reading or working. Pause or duck playback during another audio source; expose a visible playback control.
- Deliver notifications in authored batches; preserve them in a notification tray. They never steal focus or auto-send a draft.
- Use shared objects across apps: an assignment creates a Calendar commitment; a saved clip can be attached in Messages; a permitted photo can become a Moments post; the response can create a group scene.
- Give story posts a fictional expiry time. They expire only at explicit story-time transitions; warn before advancing past unseen relevant posts. Essential context always has a fallback.
- Provide a visible feed-end state. Refreshing cannot produce endless filler, farm relationship progress, or advance time.
- Keep optional browsing optional. Required clips have a transcript, visual description, and direct contextual link; players never hunt through every app to find a hidden progression flag.

## Content and release scope

All ten apps must have working navigation, readable content, and at least one meaningful interaction in the first playable phone experience. Build shared systems for lists, profiles, notifications, attachments, media playback, and links before bespoke polish. Release-scale content targets must be measured in the prototype.

Initial prototype content proposal: four playable original music tracks, six short original video items shared between Vista/Loop/Moments as appropriate, three original book excerpts, three work decision chains, and two social story sequences. These are authored assets with full text alternatives; a short clip can use restrained pixel animation and captions rather than expensive full animation.

The broader app surface increases UI, media, writing, and mobile QA work beyond the earlier five-app estimate. Retain the branching event budget, but embed these interactions in its existing scenes; do not quietly add ten independent simulators. Reassess total art/audio and authoring capacity before production. If cuts are needed, reduce feed volume and decorative animation first, preserving requested app functions and choice consequences.

Use fictional branding and original or properly licensed media for the proposed YouTube-style and TikTok-style experiences. This design proposes in-game analogues, not real-service integrations or streaming catalogs.

## PC and mobile behavior

On PC, mouse wheel and buttons navigate feeds. On iOS/Android, swipe scrolling and tapping are supported; visible controls provide alternatives to gesture-only actions. No hover-only metadata. Show keyboard focus, media captions, mute controls, image descriptions, adjustable text, and safe-area-aware navigation. Backgrounding suspends presentation and never expires a story, misses a call, or breaks a promise.

## App acceptance criteria

For every app, verify a complete action, its saved state, return navigation, and a valid outgoing link. For every interaction labeled a major decision, demonstrate changed events using the branching ledger. Decorative likes and playback choices must not be presented as guaranteed plot branches. A believable phone needs ordinary activity as well as consequential decisions.
