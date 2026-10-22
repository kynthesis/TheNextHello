# The Next Hello

**Game Design Document · v0.3 · 22 October 2026**  
**Status:** Proposed first design; ready for creative review, not an approved production baseline.  
**Design basis:** The creator's pitch, genres, Steam tags, and direction for a Japanese game with a male protagonist and female love interest. The female love interest lives in Hokkaido, as directed by the creator. Tachibana Asahi, 29, and Yukimura Mizuki, 23, are creator-confirmed. Cities within each region and biographies remain proposals.
**Confirmed direction:** Japanese game; male protagonist; female love interest in Hokkaido; consequential branching story; target platforms PC/Steam, iOS, and Android; Asahi's account on Noir, a flat nostalgic social network, presented as a nostalgic mobile social app with exactly seven sections. The latest mobile direction supersedes the earlier desktop site layout.
**Engine:** Godot 4.7.2, selected by the creator's project instructions. A complete playable six-act first draft is implemented; see [implementation notes](IMPLEMENTATION.md) for scope and validation.

## 1. The promise

**Primary objective — creator direction:** Convey a story about long-distance love. Let players experience how Asahi and Mizuki build closeness while living apart: looking forward to a message, sharing ordinary moments, missing each other's presence, negotiating needs, and deciding how to sustain the relationship. The social network serves that story. Feature completeness and browsing volume are not the measure of success.

**Experience priorities:** Build shared routines before testing them. Make absence meaningful through authored situations rather than mandatory real-time waiting. Give both people independent lives and understandable needs. Let choices change how they support each other, handle conflict, meet, and return to distance afterward. A meeting is a relationship milestone, not an automatic solution to distance.

**Feature filter:** Each substantial feature must help express connection, absence, trust, independent responsibilities, or a shared future. Ordinary browsing can provide breathing room, but must not crowd out relationship scenes or become required busywork. Music can establish a shared ritual; social posts can reveal a day the other person could not share; work can create an honest availability conflict; photos can make an unfamiliar place feel familiar.

**Presentation boundary:** Convey the story through Asahi's account on the fictional social network hello, consistent with current creator direction. Photos, messages, call transcripts, shared media, travel updates, and later recollections can show life beyond the device. External room exploration, voiced messages, and new utility apps mentioned during brainstorming are not approved additions.

> Fall in love one message at a time in a pixel art social-network story. Meet through an online game, share photos, and navigate love, friendship, and distance through connected sections. Your choices shape the relationship and what happens when it's time to meet in person.

**Player fantasy:** Someone who was once a username becomes the person you want to tell about your day. Build that connection through small acts, discover who each of you is beyond the screen, and choose what place the relationship can have in your life.

**Central dramatic question:** Can the intimacy you build online become a relationship that works in everyday life?

**Genres:** Simulation, Indie. The simulation is a fictional social network and social life; narrative choices supply the main gameplay.

**Steam tags supplied by the creator:** Romance, Choices Matter, Interactive Fiction, Story Rich, Pixel Graphics, Multiple Endings, Dating Sim, Emotional, Text-Based, Conversation, Singleplayer, Point & Click, Atmospheric, 2D.

**Audience:** Players who enjoy intimate interactive fiction, slow-burn romance, everyday character detail, and emotionally distinct endings. Adult characters; final content rating and localization markets remain undecided.

**Format:** Offline singleplayer targeting PC/Steam, iOS, and Android, as directed by the creator. Premium pricing is a proposal. One central love interest, three supporting contacts, six narrative acts, three distinct relationship paths, and eight endings. Target a 3–4 hour first playthrough and 15–30 minute sessions. Duration is a writing and playtest target, not a measured claim.

## 2. Design pillars

| Pillar | What the player experiences | Design test |
|---|---|---|
| Intimacy through ordinary things | A bad lunch photo matters because somebody remembers it later. | Each chapter contains a small detail that returns with new emotional meaning. |
| A connected social world | Conversations, photos, game events, and plans refer to the same shared history. | Every chapter contains at least one meaningful cross-app consequence. |
| Choices change events | Decisions alter what happens, who is involved, when the couple meets, and what can happen afterward. | Every major decision has an immediate branch and at least two later event or action consequences; changed dialogue alone does not qualify. |
| Distance as lived experience | Conflicting routines and incomplete context complicate affection. | Friction arises from credible circumstances and character needs. |
| A life large enough for love | Friendship, independence, and romance all have room to matter. | Setting a boundary can strengthen the relationship; friendship has a complete ending. |

**Emotional rhythm:** Curiosity → ritual → vulnerability → friction → negotiation → recognition.

**Tone:** Tender, funny, sometimes awkward, occasionally painful. People can make mistakes and repair them. Avoid constant poetic dialogue: a character's jokes, abbreviations, interruptions, and mundane observations make the vulnerable messages land.

**Conversation reference — creator direction:** Use [Emily is Away](https://store.steampowered.com/app/417860/Emily_is_Away/) as a reference for intimate chat, uncertainty and relationships changing between conversations. Keep Asahi's account as the viewpoint. Let short replies, uneven typing, ordinary details and callbacks carry emotion. The English chats borrow American 2009 instant-message habits. Mizuki tends to type casually in lowercase, using brb/btw/lol and text smileys; Asahi uses punctuation and dry jokes. Friends and work retain their own voices. Vulnerable messages should sound harder to send than everyday banter. Avoid giving every character a polished explanation of the scene's lesson. The player sees the complete reply before choosing; hesitation never changes its meaning or forces a different outcome. All eight endings remain consequential authored outcomes.

## 3. Scope and boundaries

The player uses a fictional social network. All contacts and online-game players are authored characters. The online game is simulated inside this singleplayer experience and requires no account or connection.

### Included in the proposed release

- Seven main sections: News Feed, Profile, Friends, Photos, Events, Messages and Requests. See [Social UI](SOCIAL-UI.md).
- One central relationship with three distinct story paths and a complete friendship alternative.
- Major choices that open and close authored events before the ending, with lasting consequences.
- Three supporting characters with individual needs and resolutions.
- Photo selection and captioning, contextual sharing, messaging, group chat, and simple cooperative game encounters.
- An authored in-person meeting sequence, alternative decision to postpone, and relationship-specific epilogues.
- Save/load, conversation history, read-text skipping, accessible text presentation, and keyboard navigation.

### Outside the first release

Multiple romance routes, real multiplayer, freeform AI chat, user photo uploads, procedural story generation, real social network integration, voice acting, an explorable city, and a full RPG within the social network. There are no daily login requirements or real-time appointments.

**Cut order if scope grows:** Cosmetic account customization → optional public posts → additional game encounter variations → extra ambient conversations. Preserve the central relationship, repair opportunities, cross-app consequences, and complete endings.

## 4. Player identity and cast

The protagonist is male and the love interest is female, as directed by the creator. All principal characters are adults. The central names and ages are creator-confirmed: Tachibana Asahi, 29, and Yukimura Mizuki, 23. Supporting ages remain 24 for Natsumi, 27 for Daichi and 29 for Misaki at the October 2009 opening. See [character profiles](CHARACTERS.md) for birthdays, zodiac signs, interests, favorites and voice rules.

**Setting proposal:** Japan, beginning on 23 October 2009 and continuing into spring 2010. Asahi lives in Tokyo and Mizuki in Sapporo, Hokkaido. Distance comes from living in different cities, limited leave, travel planning, and mismatched routines. Seasonal street photos, train-station check-ins, convenience-store snacks, and everyday messages establish place through messages and photos. Keep cultural details specific to each character rather than relying on stereotypes.

**Central couple:** Tachibana Asahi and Yukimura Mizuki, who first know each other through their game usernames. Their first meeting is purely coincidental: random matchmaking places them in the same Lantern Quest session. No guild or mutual friend introduces them. Daichi only appears later as a player joining an open party.

| Character | Proposed identity | Desire and contradiction | Narrative function |
|---|---|---|---|
| Tachibana Asahi / `asahi` (player) | Japanese man, 29, he/him; junior office worker in Tokyo; editable given/display name and one of three avatars | Wants connection while settling into a demanding new routine; defines how much to disclose. | Expressive protagonist with enough fixed circumstances to support authored drama. |
| Yukimura Mizuki / `mizuki` | Japanese woman, 23, she/her; illustrator living in Sapporo, Hokkaido | Wants to be known, but uses humor and helpfulness to avoid asking for support. Considering a local work opportunity. | Central romance and possible lasting friend. |
| Natsumi | 24, she/her; player's longtime local friend | Wants reliable friendship while preparing a small creative showcase; fears becoming an afterthought. | A relationship worth maintaining in its own right. |
| Daichi / `mossbyte` | 27, he/him; a fellow player who joins a later public party | Wants the group to stay welcoming, but avoids conflict until plans become messy. | A later game friend with his own needs; does not introduce Asahi and Mizuki. |
| Misaki | 29, she/her; Mizuki's older sister | Wants Mizuki to build a sustainable life; has her own move to arrange. | Gives Mizuki a life beyond the player's attention; enters a shared chat with consent. |

**Protagonist customization:** Editable given/display name, avatar, and recurring preference choices such as favorite weather or comfort food. Asahi is a male protagonist with he/him pronouns; Mizuki is the female love interest. Preferences create callbacks, never compatibility locks.

**Character agency:** Mizuki can decline a call, keep a commitment, ask for space, or disagree. The player cannot unlock intimacy by repeating gifts or flattering every answer. A friendship choice is respected immediately and changes subsequent writing.

## 5. Core loop

**Notice → explore context → choose an action → see a response → carry a memory forward.**

1. Open the site at an authored date and time; see two or three available threads or activities.
2. Read messages and inspect relevant photos, posts, game invitations, or plans.
3. Choose a reply, select something to share, join an activity, or state a boundary.
4. Receive an immediate reaction; a significant choice also records a future consequence.
5. Finish the required scene and any optional activity, then explicitly advance time.

### Three scales of play

| Scale | Loop | Reward |
|---|---|---|
| Moment, 1–3 minutes | Read a short exchange and choose a response. | Humor, recognition, a new detail, or a changed tone. |
| Story day, 10–20 minutes | Complete a central conversation and choose optional social activity. | A shared memory and a shift in the relationship. |
| Chapter, 25–40 minutes | Build toward a meaningful request, conflict, or decision. | A new relationship phase, with visible callbacks to earlier choices. |

No currency, grind, affection farming, or mandatory collectible hunt. Optional interactions add perspective and personalized callbacks. Required context is always available on the main path.

## 6. The social network and connected sections

Home uses a compact three-column grid with exactly seven sections: News Feed, Profile, Friends, Photos, Events, Messages and Requests. Profile supports Asahi's statuses/comments/shares; Friends exposes accepted friends' profiles/photos; Photos contains his own photos; Events holds objectives; Messages holds DMs; Requests accepts or declines new friends after encounters. Settings is available through the header Menu. Lantern Quest, work and private notes remain story contexts rather than additional menu sections. See [Social UI](SOCIAL-UI.md).

| Section | Player actions | Purpose |
|---|---|---|
| **News Feed** | Read updates, Like, comment and share friend posts. | See ordinary lives beyond the DM. |
| **Profile** | Read Asahi's account and publish local statuses. | Express his public-facing everyday life. |
| **Friends** | Open accepted friends' profiles and photos. | Learn about people through what they choose to share. |
| **Photos** | Revisit Asahi's own photos and screenshots. | Keep personal memories; private attachments stay in DMs. |
| **Events** | Current objective, chapter, commitments, completed events and next-action link. | Story guidance and concrete plans. |
| **Messages** | Direct/group conversations, private attachments, drafts and explicit replies. | Main narrative and meaningful decisions. |
| **Requests** | Accept or decline requests earned after encounters. | New friendships without changing the chance-meeting origin. |

Settings and Music are available through the header Menu. All characters communicate through Messages DMs or group chats. Work and Lantern Quest remain story topics; their separate screens are removed. Legacy Games/Work keys migrate into Messages. Events alone holds objectives, progress and next-action links, without mission banners or progress badges.

**Cross-app rule:** A content item has one canonical identity and state. Opening the same photo through a message or Photos shows the same caption, permissions, and history. Posting an image does not automatically send it privately.

**Discoverability:** Notifications lead directly to their scene. If an attachment matters to a choice, the choice panel offers a direct link to inspect it. Icons have text labels; essential actions never depend on recognizing a tiny symbol.

### Example connected interaction

Mizuki sends a work-in-progress sketch in Messages. Asahi can ask about it or offer to reschedule tonight's game. The private image appears in Shared attachments; an agreed schedule change appears in Events and changes the party conversation in Games. Optional context never becomes a hidden progression requirement.

## 7. Messaging and meaningful choices

### Reply behavior

- Most exchanges offer 2–3 authored responses with the complete outgoing text visible before selection. Long replies expand before sending.
- Selecting a response creates a draft; a separate Send action commits it. Editing or backing out of a draft has no story effect.
- Use different intentions, not a repeated “nice / cruel / neutral” pattern: ask a question, offer company, share something personal, suggest a practical step, or ask for time.
- Emoji reactions provide tone and occasional callbacks; they do not substitute for explicit agreement to a major relationship change.
- “I need to answer this later” appears only where a postponement branch is authored. It creates a visible reminder and a later follow-up opportunity.
- Ambient messages can arrive in authored sequences. Typing indicators and simulated pauses are skippable and have no effect on outcomes.
- Closing the game, reading slowly, or leaving a screen open never counts as silence or rejection.

### Consequence classes

| Class | Example | Required response |
|---|---|---|
| Flavor | Pick a favorite game pet. | Immediate acknowledgment or a later personalized line. |
| Memory | Share a vulnerable photo caption. | A named memory revisited in another scene. |
| Commitment | Agree to attend Natsumi's showcase. | Visible Calendar entry and authored follow-through or renegotiation. |
| Boundary | Ask Mizuki not to joke during a serious conversation. | Changed behavior or an explicit repair scene if that boundary is crossed. |
| Relationship | Say you want friendship or discuss a meeting. | New scene framing, available actions, or ending eligibility. |

Every authored choice is labeled internally by class and has a documented consequence. Flavor choices can share an outcome; the writing must not imply a major divergence when none exists.

### Sample exchange: an image with two meanings

Context: Mizuki sends a photo of her desk. A mug holds pens; the laptop displays an unfinished application. The image has an equivalent text description.

**Mizuki:** “proof i did, technically, leave the raid to do work”

| Outgoing reply | Immediate response | Later effect |
|---|---|---|
| “The mug has a new job. How's the application going?” | Mizuki talks about uncertainty if she is ready; otherwise asks to discuss it later. | Records that the player asked about work; enables a relevant check-in. |
| “Want company while you work? No need to talk.” | Mizuki chooses whether company would help. | If accepted, creates a quiet shared session memory. |
| “I should sleep, but I'm rooting for you. Tell me tomorrow?” | Mizuki acknowledges the boundary. | Adds a follow-up thread; sleeping is not scored as neglect. |

The player's role is to express care and needs, not to diagnose the one correct interpretation of an image.

## 8. Relationship model

Use explicit narrative facts and small, hidden state categories. There is no visible love meter and no single numerical score that buys an ending.

| State | Values | Change rule |
|---|---|---|
| `relationship_mode` | undefined / romantic / friends | Changes through an explicit conversation with mutual agreement. |
| `disclosure_stage` | acquaintance / personal / vulnerable | Advances through authored exchanges in which both choose to share. |
| `active_rupture` | none / named issue | Created by a substantial conflict; resolved only by its repair scene or acknowledged separation. |
| `communication_agreement` | unset / agreed / needs_revision | Records a practical expectation, such as how to cancel plans. |
| `meeting_plan` | unraised / discussing / confirmed / postponed / declined / completed | Changes through explicit proposals and responses. |
| `future_plan` | unset / workable / incompatible / explicitly_undecided | Records the mutually acknowledged plan; explicitly_undecided requires the open-ending conversation and is never inferred from missing data. |
| `shared_memories` | Set of stable memory IDs | Added once per meaningful event; used for dialogue and epilogue details. |
| `commitments` | Records: person, event, status | proposed / accepted / kept / renegotiated / missed; resolved by authored story actions. |

**Rupture rule:** One clumsy reply does not silently destroy the relationship. A serious issue receives an understandable response and at least one clearly offered repair opportunity before an ending locks. Apologizing does not erase it automatically: repair includes listening and a concrete agreement.

**Boundary rule:** Saying no, staying friends, or protecting rest never applies a generic affection penalty. If two needs conflict, the story acknowledges incompatibility rather than treating a boundary as wrongdoing.

**Friendship rule:** Natsumi has a tracked commitment and chapter callbacks, not a competing affection bar. Her resolution changes independently of the romance ending. Mizuki never requires the player to abandon friends.

**Branching structure:** Six acts describe emotional phases, not mandatory scenes. After the shared introduction, the player develops one of three central paths: Game-first, Private connection, or Shared lives. Acts three and four contain different events and conflicts on each path. Meeting can happen in act four, act six, or be postponed. No mandatory misunderstanding or final-chapter choice resets the history.

A major choice must change the next playable event, record a lasting fact, and change at least two later events or available actions. Differences consisting only of wording, callbacks, or an ending slide fail this requirement. Flavor replies remain available but are not advertised as major choices.

Paths may meet at a shared milestone, but entry conditions, available actions, and resulting scenes must preserve their differences. Reuse interface and art where helpful. Do not force separate events back into an identical story. One explicit path transition is supported at act three's relationship conversation; completed and missed events remain in history. Friendship and separation remain available afterward on every path.

**Past events stay true:** An apology can repair trust without restoring a missed showcase, undoing a public disclosure, or recreating a declined visit. A previously public photo remains a known disclosure even after deletion. Save/load and a new replay can explore alternatives; the active story does not silently rewrite them.

**Branching specification:** See [Branching story and choice ledger](BRANCHING-STORY.md) for paths, eight major choices, event consequences, and coverage requirements.

## 9. Time, distance, and commitments

The story spans roughly four fictional months across six narrative acts. The number and order of authored days vary by path; there is no fixed two-days-per-chapter schedule. An early meeting introduces a post-meeting long-distance act that a first-meeting-at-the-end path does not contain.

Each day contains one required anchor scene and up to two optional scenes. Unread optional content remains available until the next explicit time jump. The day-end panel names anything that will be left behind. Previously delivered messages and images remain in history afterward.

Time advances only when the player chooses **Later**, **Go to sleep**, or a clearly labeled chapter transition. The site date is fictional; it never reads the player's wall clock for narrative deadlines.

**Overlapping plans:** A conflict only occurs when the script presents two events as overlapping and the player explicitly accepts incompatible plans or chooses one. Merely reading one conversation before another cannot break a promise. The Calendar offers attend, decline, or renegotiate where authored; the consequence is shown in dialogue.

**Shared clock, different routines:** Both characters use the same local-time display. Calendar slots compare Asahi's office commitments with Mizuki's illustration deadlines and available travel days. Availability is pre-authored; scheduling is a conversation, not an optimization puzzle. Physical distance remains important even without a time-zone difference.

**Silence:** Waiting can be emotionally meaningful through authored time jumps. The player always knows when an action will move the story forward. No critical choice expires while the player is thinking.

## 10. Lantern Quest: the game within the game

**Fiction:** A cozy cooperative fantasy game about carrying lanterns through ruined gardens. Asahi and Mizuki first meet by chance through random matchmaking, with no party membership, mutual contact, or arranged introduction. They choose whether to play together again afterward.

**Format:** Three reusable encounter templates—light a route, protect a companion, and choose a shared reward—recombined across five authored sessions. Each session lasts roughly 2–4 minutes and contains 2–3 turn-based decisions.

**Actions:** Choose a role, inspect a situation, then pick a cooperative action. For example: light a safe bridge, wait for a partner, or attempt a shortcut after discussing it. The companion's response makes communication style visible.

**Outcome:** Success changes playful banter and the session screenshot. A mishap creates an alternate shared memory; it does not remove required story access. No reflex tests, character leveling, loot economy, combat simulation, or mandatory repetition.

**Accessibility:** “Story outcome” mode summarizes the encounter and preserves its social choices. Both modes offer the same romance and friendship outcomes.

The opening session teaches the complete loop: coordinate with `mizuki`, recover from a harmless mistake, save a screenshot, and receive the first direct message.

## 11. Narrative arc and chapters

| Act | Shared dramatic purpose | What can differ through choices |
|---|---|---|
| 1. **A Chance Encounter** | Establish Asahi, Mizuki, and their first game session. | The next invitation can be a party activity, private photo exchange, or personal call. |
| 2. **A Place in the Day** | Establish the relationship's habits through actions. | The player chooses an activity with Mizuki's agreement; this selects Game-first, Private connection, or Shared lives. Commitments determine which people take part. |
| 3. **What We Carry** | Decide what to reveal and who to include. | Party disagreement, a private creative collaboration, or preparation for a visit. A friend can become a confidant, stay uninvolved, or become someone owed a repair. |
| 4. **The Distance Between Us** | Experience the consequences of prior commitments. | An early meeting, a privacy conflict, a canceled collaboration, or an honest scheduling negotiation. A conflict does not occur if its trigger never happened. |
| 5. **What We Ask of Each Other** | Choose practical and emotional next steps. | Post-meeting adjustment, an unrepaired issue, a friendship transition, or a first-meeting proposal. Mizuki makes her own work decision; support affects the shared plan, not ownership of her career. |
| 6. **The Next Hello** | Resolve the relationship's future. | First meeting, second meeting, continued distance with a concrete plan, friendship, or separation. Earlier choices determine which proposals remain credible and available. |

### Different paths, different events

- **Game-first:** The party remains the shared space. A group obligation and leadership disagreement test how the couple communicates publicly. Meeting may begin as a group event; party participation can continue or end depending on conduct and commitments.
- **Private connection:** Photos, calls, and an optional creative collaboration deepen the relationship away from the party. Choices about permission and promises determine whether the collaboration is completed, canceled, or becomes a privacy conflict. A private visit is proposed later.
- **Shared lives:** The couple introduces friends and explores an earlier Hokkaido visit. Accepting a mutually feasible visit leads to an act-four meeting and new scenes about returning to distance afterward. Declining it leads to an alternate planning sequence, not the same trip with different dialogue.

No route is the correct way to love Mizuki. Good communication can avoid a preventable argument but does not remove practical tradeoffs. Every route supports romance, friendship, and separation, with different histories.

### The in-person meeting

The meeting is playable and resolved on screen. The meeting can occur in act four or act six. Calendar records the agreed place; Messages handles arrival; the site then opens a short illustrated scene with dialogue choices for the first greeting and conversation. A new shared photo returns the player to Photos afterward.

Use a small set of bespoke pixel illustrations rather than a navigable environment. The first greeting can be a joke, an honest admission of nerves, or a quiet hello. A touch or hug requires an offered choice and reciprocal acceptance. The scene acknowledges that in-person chemistry may differ without making either person deceptive.

If the pair postpones or separates, the final act uses a fully authored conversation of comparable emotional weight. It never ends at a locked travel screen.

## 12. Endings and resolution rules

Eight planned endings cover good, bad, neutral, open and secret outcomes. The creator requested this wider range; the names and exact eligibility below are working proposals. Categories are internal authoring labels, not a visible score or judgment of the player. Each ending needs its own final conversation, a photo or account-state change, and an epilogue. A changed closing caption alone is not another ending.

| Category | Ending | Eligibility and resolution |
|---|---|---|
| Good | **A Place for Us** | Mutual romance, completed meeting, workable plan and no unresolved rupture. They take a concrete next step while retaining independent lives. Relocation is not required. |
| Good | **Same Sky, New Plan** | Mutual romance, a deliberately postponed meeting, workable long-distance plan and no unresolved rupture. They enact a shared routine and agree when to revisit travel. |
| Bad | **Words Left Unsaid** | A named serious rupture remains unresolved because an explicit repair opportunity and follow-up were refused. The final exchange shows the lost trust and resulting separation. One awkward reply never qualifies. |
| Bad | **Nothing Left to Give** | Repeated knowingly incompatible promises have harmed both people's independent commitments; offered opportunities to reduce demands or renegotiate were rejected. An authored burnout conversation ends the relationship. Honest unavailability, rest, work obligations or a boundary cannot trigger this ending by themselves. |
| Neutral | **Still in the Party** | Both explicitly choose friendship and agree a sustainable friendship plan. It is a complete relationship, with its own final activity and future contact. |
| Neutral | **Thank You for the Time** | They mutually acknowledge incompatibility or respectfully choose to separate, without an unresolved qualifying harm. They recognize what mattered and say goodbye. Separation is not automatically a bad ending. |
| Open | **Maybe, Someday** | Both explicitly choose to leave the future undecided, with no unaddressed rupture. A final conversation states what remains uncertain and whether contact continues. The emotional scene is complete even though the future remains open; missing data never selects it. |
| Secret | **The Everyday Hello** | A good-ending plan is eligible and a mutually chosen recurring ritual has been kept and renewed through authored scenes. Both choose to give that ritual a place in their future. A distinct playable ordinary-day finale shows the life they have built, rather than merely changing an epilogue caption. Equivalent ritual opportunities must exist on every central path. |

**Resolver order:** Resolve authored harm first: refused repair selects Words Left Unsaid; repeated overcommitment with the burnout confrontation selects Nothing Left to Give. If both harm flags exist, the final confrontation explicitly identifies the active cause; there is no arbitrary hidden tie-break. A cleared rupture can no longer select either bad ending. Then resolve an explicit amicable separation to Thank You for the Time, mutual friendship with a workable friendship plan to Still in the Party, or mutually acknowledged uncertainty to Maybe, Someday. A workable romantic plan resolves by completed/postponed meeting to A Place for Us/Same Sky, New Plan; qualifying shared-ritual scenes and mutual renewal replace that base finale with The Everyday Hello.

**Completeness guard:** Undefined relationship mode, unset future plan or contradictory commitments triggers a clarifying conversation. An explicitly undecided future is a distinct authored state for the open ending. Unraised/discussing travel receives planning context; confirmed travel must play before a completed-meeting ending. Declining travel requires an explicit decision about a continuing arrangement, friendship, uncertainty or separation. No hidden default ending fills missing state.

**Secret-ending rules:** No perfect-reply score, feed completion, hidden collectible hunt, extra app, or prior acquaintance is required. Earlier choices must produce observable ritual scenes; discovery can reward paying attention without concealing required context. The secret ending never reveals that the initial meeting was arranged or that the couple already knew each other. Asahi and Mizuki still meet entirely by chance.

Within an ending, memories, Natsumi's commitments and communication agreements choose contextual details. These variants do not add to the count of eight endings. Names and categories appear in replay records only after discovery, with any hints spoiler gated. All eight endings are now implemented in the complete branching first draft; see STORY-SCRIPT.md and STORY-CHOICES.md. Editorial review, final art and release validation remain pending.

## 13. Presentation, art, and audio direction

**Visual identity:** Noir uses flat blue navigation, its own white wordmark, a pale gray-lilac background, multicolor icons, red message badges and readable labels. Use solid fills and thin borders, with no bevels, gradients or button shadows. Home has a three-column section grid and an own-photo shelf. Global header icons open Friends/Requests, Messages, Notifications, Search and Menu, with red counters and white active icons. News Feed and private Messages are separate. White incoming bubbles align left; Asahi's pale-blue replies align right, with small speech tails. Pixel illustrations remain where they carry story context.

**Pixel treatment:** Low-resolution art with a consistent pixel grid, nearest-neighbor image scaling, and restrained animation. Render dialogue as accessible UI text rather than baking it into pixel images. Offer a readable non-pixel font.

**Composition and viewpoint:** Asahi's logged-in fictional mobile social app fills a 414×896 portrait canvas. Uniformly scale it to fit larger windows with plain dark blue-gray margins. No desktop sidebars. Preserve one standard reading size, wrapping and scrolling. Exactly seven main menu sections, own-profile and friend-photo separation, Requests, and Events as the objective list follow the latest creator direction. Private content never automatically appears in News Feed.

**Character presence:** Avatars, evolving profile photos, typing habits, personal photo compositions, and selected meeting illustrations carry personality. No constant full-screen talking portraits.

**Photos:** Everyday scenes, imperfect framing, repeated objects, and changing light. A mug, window, or game screenshot becomes meaningful through repetition. Never require identifying tiny image details to progress; image descriptions supply equivalent information.

**Motion:** Brief app transitions, message arrival, subtle cursor or avatar motion. Reduce-motion mode removes decorative movement. Missed notifications remain in an inbox.

**Audio:** Small electronic and acoustic motifs; environmental room tone; distinct but soft message sounds. Reuse the shared-ritual motif at the meeting with a warmer arrangement. Silence supports difficult conversations. Separate music, ambience, and interface volume controls. All audio-only information also appears in text.

**Provisional asset budget:** Seven app icon families, four contact/avatar sets plus three player avatars, 24 unique photo illustrations, six meeting/ending illustrations, twelve music titles with A/B candidates, and approximately twelve interface/game sound effects. Shared templates and altered crops can recur but do not count as new unique photos. The supplied soundtrack has 24 WAV masters and matching license PDFs; [SOUNDTRACK.md](SOUNDTRACK.md) defines its scene-based availability. Music and Settings live under the header Menu, keeping the seven main sections.

The earlier standalone social/music/video/book app expansion is deferred. Keep content focused on the existing relationship scenes and revise provisional illustration/audio counts after the branching prototype; see SOCIAL-UI.md for the essential app scope.

This establishes direction for a later art bible; it does not approve an asset-production style or commission final art.

## 14. UX, controls, and accessibility

### Screen flow

Social Home → Section → Thread or item → Optional reply draft → Send → Response. Home returns to the section grid; each section restores its scroll position. Settings and save menus pause presentation.

**Controls:** On PC, mouse for selection and scrolling; keyboard focus traversal and arrows for navigation; Enter/Space to activate; Escape to close the top overlay or go back. On iOS and Android, tap to select, swipe to scroll, and a visible Back control; platform back actions close the top surface before leaving the game. No hover-only interaction or swipe-only essential action. Touch targets use platform-appropriate accessible sizing, with an initial design target of at least 48 logical units and separated adjacent actions. Selecting a reply never sends it with the same input event. Mobile home/background interruptions pause presentation without making story choices. Gamepad support is a separate scope decision; layout should permit it without assuming launch support.

### Required reading conveniences

- Full conversation history and a chapter/date index; image descriptions accessible from history.
- One standard text size, incoming typing indicators, Sent/Read states and character-by-character composition for Asahi's unsent drafts. Finish typing, Show messages now, Instant messages and Reduce Motion skip animation waits without sending or choosing.
- Auto-advance pauses on choices, unread attachments, and required context; notifications do not steal focus.
- Skip-read mode stops at unseen variants and decisions, including changed image captions. It never makes a choice automatically.
- Clear focus indicators; state communicated through labels and symbols as well as color.
- Legible contrast, scalable controls, and scrolling for long replies; no timed reading or precision clicking.
- No information available only through audio. Readable standard-size text and keyboard access are launch requirements; screen-reader support requires an early feasibility investigation before any compatibility claim.
- Optional content notes describing themes and a menu path to revisit them. Proposed themes include loneliness, interpersonal conflict, and relationship separation.

**Layout acceptance targets:** At 1280×720, 1920×1080, and 2560×1440, plus a 21:9 window, required controls remain reachable and messages do not overlap. At the standard text size, use wrapping and scrolling rather than clipping. Also verify narrow and tall mobile portrait layouts, safe-area cutouts, touch-only navigation, and standard text without clipped Send/Back controls. Supported OS versions and minimum devices remain to be selected. These are future test conditions, not completed verification.

## 15. Progress, replay, and saving

**Progress feedback:** Chapter titles, dated conversation history, shared Photos collections, and changed everyday routines. No public relationship ranking.

**Save behavior:** Save at any stable interaction, including an unsent draft or unanswered choice. If an animation is active, finish its current atomic message transition before capturing state. Loading reconstructs the same interaction without reapplying consequences.

Provide ten manual slots, one quicksave, and three rotating autosaves separate from manual slots. Autosave after committed choices and day transitions, and capture stable state on mobile backgrounding. Returning from suspension never advances story time. Saves are local per installation; cross-platform sync is undecided and must not be promised. Save writes use a temporary file and recoverable previous version; errors retain the last valid save and show a clear message.

**Authoritative saved data:** Schema and content versions, exact scene/node position, delivered-message log, selected choices, narrative facts, commitments, shared memories, available events, consumed event IDs, attachment access, drafts, current screen/scroll context, and any pending presentation step. Store plain data, not engine object references.

Settings and globally seen text live separately from playthrough state. Seen-text tracking uses content ID plus variant, preventing a familiar line ID from skipping a new branch. Future saves require validation and explicit migration; incompatible saves are preserved and explained.

**Replay:** After one ending, unlock chapter replay from that run's recorded chapter-start snapshots. Replay creates a separate run and preserves downstream consequences from its new decisions. An ending gallery summarizes only endings already seen; optional hints are spoiler gated.

## 16. Content plan and authoring contract

| Content | Proposed first-release budget |
|---|---|
| Narrative acts / authored scenes | 6 / 94 in the complete first draft; route varies by run |
| Explicit time gates | 37 generated presentation/flow nodes, separate from authored scenes |
| Ending sequences | 8: 2 good, 2 bad, 2 neutral, 1 open, 1 secret |
| Major decisions | 8, with expressive replies, repair opportunities and smaller commitments |
| Draft words | Approximately 11,400 including replies and guidance across all paths |
| Earlier release-length target | 45,000–60,000 words and 3–4 hours per run; not delivered or verified by this compact first draft |

The previous 44-scene proposal is superseded by a finer-grained 94-scene draft with the complete plot and all endings. Generated waiting nodes are explicit story-time boundaries, not additional authored scenes. See [the complete script](STORY-SCRIPT.md) and [implemented consequence map](STORY-CHOICES.md). Measure reading time and assess editorial expansion before treating the first draft as the release baseline. Reassess art/audio counts against the reviewed script.

**Scene definition:** One bounded interaction with an entry condition, dramatic purpose, and terminal state. A genuinely different event needs its own scene ID; a changed greeting does not. Eight major choices are specified in [the branching ledger](BRANCHING-STORY.md). No single playthrough can experience all three central paths or all mutually exclusive outcomes.

**Each scene record must include:** Stable ID; chapter/day; participating characters; allowed app surfaces; entry condition; required context; line and choice IDs; state effects; attachment IDs; exit event; fallback for missing optional context; later callback references, path eligibility, excluded events, and a record of the major choice causing this scene.

**Narrative runtime contract:** Content yields a message, a choice set, an app command, a wait-for-player interaction, a jump, or an end. Conditions read typed narrative state. Commands update it once through recorded event IDs. Presentation handles bubbles and transitions separately from story logic. The implemented JSON graph has stable IDs, conditional choices/lines, ordered destinations, conditional fact updates and once-only event effects. Native dialogue lives in content/dialogue/*.dialogue; scene requirements and consequences live in content/story.json. The build uses the upstream Dialogue Manager compiler.

**Localization:** Stable string IDs from the first draft, separate speaker identities and display names, localized captions and image descriptions, no sentence assembly from fragments, flexible bubble height, and no player text embedded in art. Initial writing language is English; release languages are undecided.

**Choice ledger:** For every decision, record intent, immediate response, delayed consequence, state writes, and the scene that proves the consequence. This ledger is the practical defense against cosmetic branching and abandoned promises.

## 17. Production approach and validation gates

### First playable: prove the opening connection

Build a branching prototype of the introduction and one major choice with three playable continuations: party activity, private collaboration, and visit planning. Include a save/load round trip and a later event that changes on each continuation. Temporary art is sufficient; measure duration rather than forcing all paths into a fixed demo length. Graybox UI and temporary art are sufficient.

**Question to answer:** Do players recognize that their actions changed the events of the relationship, and do the apps make those consequences understandable?

**Proposed test gate:** With five first-time readers, at least four can navigate without intervention, identify one event that their choice caused and an alternate event that did not happen after comparing runs, and name one specific reason they want another conversation with Mizuki. Record qualitative feedback as well as the count; this is a small usability sample, not market validation.

### Narrative slice: prove conflict and agency

Before full production, script representative scenes for all three central paths, an early meeting with its aftermath, a late meeting, a privacy consequence with repair, and a friendship transition. Confirm that each feels coherent and that no path requires people-pleasing to progress.

### Full production and completion

1. Establish character voices, story outline, choice ledger, and a visual target.
2. Author and implement chapters one to three; test cadence and reading duration.
3. Author chapters four to six and every ending before polishing optional content.
4. Complete required art/audio, accessibility, replay, and save recovery.
5. Run narrative coverage and usability checks; freeze text before localization and final layout review.

No schedule or staffing estimate is assumed. Actual production planning follows the prototype's measured authoring and implementation effort.

## 18. Acceptance criteria and principal risks

These are release acceptance targets. The complete first draft has automated narrative and UI coverage; human playtesting and the full release checks remain pending. See [implementation notes](IMPLEMENTATION.md).

| Area | Acceptance criterion |
|---|---|
| Choices matter | Each of the eight major decisions changes the next playable event and at least two later event/action opportunities. Compare runs from identical pre-choice states; wording-only changes fail. |
| Narrative coverage | All three central paths, eight endings, and eight major decisions have reachable test paths; every node terminates or has a valid transition; every reachable choice set has an available option. |
| Consent and boundaries | Friendship, declining a call, and setting rest boundaries remain viable; character responses acknowledge explicit requests. |
| Repair | Every route to an unresolved-rupture ending includes the offered repair conversation and a clear player decision. |
| Time | Waiting in real time or reopening the game changes no narrative deadline or commitment. |
| App consistency | The same photo, commitment, or message has the same state wherever opened; optional content is not a hidden progression requirement. |
| Save integrity | Quit/reload at an unanswered choice, unsent draft, image view, and day transition reproduces state without duplicate side effects; a failed save can recover the prior valid state. |
| Reading comfort | Required navigation works by keyboard; standard text fits through wrapping and scrolling; reduced motion and instant delivery preserve every choice. |
| Ending coherence | Resolver covers every reachable final state; contradictory or missing agreements route to clarification before resolution. |

| Risk | Mitigation | Evidence needed |
|---|---|---|
| Reading feels passive | Give photos, plans, and cooperative actions consequences in conversation. | Readers describe actions they chose, not only messages they read. |
| Branches exceed writing capacity | Limit the cast and three central paths; reuse assets and cap optional content before cutting event divergence. | Choice ledger and revised scene/word budget remain feasible after the branching slice. |
| Characters become reward machines | Preserve refusals, independent obligations, and meaningful friendship. | Readers recognize Mizuki's needs and feel able to disagree. |
| Simulated delay becomes tedious | Make typing and waiting skippable; use explicit time jumps. | Replays retain emotional pacing without forced pauses. |
| Dense UI makes text too small | Separate text rendering from pixel art; wrap and scroll within the portrait app canvas. | Layout checks pass at the standard reading size from narrow to ultrawide windows. |
| Meeting feels like a teaser | Budget its illustrations and final conversation from the start. | Each ending resolves the central question on screen. |

## 19. Decisions to revisit with the creator

Creator direction establishes a Japanese game, a male protagonist, a female love interest living in Hokkaido, meaningful story branching, and PC/Steam, iOS, and Android targets. The setting interpretation and remaining details below are working proposals for review.

| Decision | Current proposal | When it needs to be settled |
|---|---|---|
| Romance structure | One central love interest with friendship as a complete alternative. | Before committing to the full narrative outline. |
| Identities and setting | Male protagonist Tachibana Asahi and female love interest Yukimura Mizuki; Tokyo–Hokkaido setting, with Sapporo as the proposed city and Japanese supporting cast. | Names and ages confirmed; review cities and biographies before final character art. |
| Tone and content | Hopeful adult romance, emotional friction, non-explicit intimacy. | Before detailed script and content-rating planning. |
| Length and scale | Six acts, three central paths, 3–4 hours per run, eight endings; 94-scene first draft; release length remains unmeasured. | Reassess after first playable reading times. |
| Meeting presentation | Message-led arrival followed by illustrated dialogue vignettes. | Prototype before commissioning final illustrations. |
| Platform and technology | PC/Steam, iOS, and Android confirmed as targets; Godot 4.7.2 selected. OS minimums and release order undecided. | Validate save lifecycle, touch UI, and builds during prototype before production implementation. |
| Input and access | Mouse/keyboard on PC and touch on mobile; investigate screen-reader feasibility. | During the first playable. |
| Commercial details | Premium release; price, launch date, languages, mobile purchase model, and platform release order unset. | Separate production and release planning. |

## 20. Skill basis and document ownership

This master design uses the game-development router to select engine-neutral guidance from **visual-novel**, **dialogue-systems**, **game-ui-ux**, and **save-systems**: controlled branching, explicit consequences, a shared state model across screens, reading conveniences, and recoverable exact-position saving.

This is a whole-game proposal rather than an approved per-system specification. Future system GDDs and the art bible should derive from reviewed decisions here. If a system changes a chapter, state rule, content budget, or ending condition, update this document and its choice ledger together.

## Dialogue authoring

Dialogue Manager v4.1.0 is pinned and bundled under its MIT license. Conversations are six native `.dialogue` files in `content/dialogue/`, editable in Godot's Dialogue tab. The custom mobile interface reads them through the addon's runtime. Stable `[ID:...]` keys preserve saved histories and outgoing drafts. Plot facts, response destinations and once-only consequences remain in `content/story.json`; cast details live in `content/characters.json`. Native predicates read state without changing it. Send and Later apply consequences. The build uses the upstream compiler, regenerates the review script/audit cache and replays all eight endings.

The story opens on 23 October 2009 and continues into spring 2010. The fictional network retains the requested Sent/Read presentation. Noir keeps the nostalgic social-network layout and established fictional Sent/Read interactions. It uses no real social-service account. Interface audio recreates early iOS keyboard ticks, sending whoosh and incoming tri-tone through original synthesis. POV typing is slow and uneven, with word/punctuation pauses and a skip control. Public profiles show birthdays and selected interests; private motives stay in writer notes and character behavior. Zodiac signs are flavor details with no compatibility score.
