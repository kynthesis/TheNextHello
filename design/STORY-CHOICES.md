# Implemented choice consequences

This ledger describes the complete playable first draft. Stable `guild_*` IDs are compatibility keys, not a guild in the fiction. Conditions are internal, not visible score meters. Read the actual dialogue and replies in [STORY-SCRIPT.md](STORY-SCRIPT.md).

| Decision | Immediate branch | Later playable differences |
|---|---|---|
| D01 — shared activity | Game party, private postcard, or everyday-life call | `party_evening` → `after_game`/`party_rest`; `illustration_evening` → `reading_evening`/`reading_once`; `sister_intro` → optional family chat and `small_call`/`call_once`. A mutually chosen ritual changes the secret finale's activity. |
| D02 — overlapping friendship commitment | Keep Sunday, negotiate Saturday setup, or knowingly double-book | Kept/repaired reliability opens `friend_confidant` and `local_dinner`; the agreed alternative opens `studio_lunch` and `studio_preview`; unrepaired absence leads to `friend_update`, without those invitations. A missed promise offers a concrete box-collection repair rather than an affection penalty. |
| D03 — image privacy | Ask for a separately approved image, keep the draft private, or publish against an explicit boundary | Approved use opens `approved_workshop` and `licensed_update`; private use opens `private_second_page` and `private_update`; violation cancels the workshop, causes `canceled_workshop`, and later allows only `boundary_followthrough`. Repair does not restore the canceled event or erase a downloaded copy. |
| D04 — work and leave | Deliver a feasible handoff, keep a weekend assignment, or knowingly promise the same hours twice | Actual handoff/review scenes differ; approved leave opens the early visit action while deferred leave closes it. `project_meeting` and `supervised_review` remain distinct later career outcomes. A repeated unsustainable promise opens a further warning, not an automatic bad ending. |
| D05 — first meeting | Early December if feasible and trust permits, January, or online for now | `early_arrival`/`early_afternoon` → `return_tokyo`; `late_anticipation` → `january_preparation` and actual `late_arrival`/`late_afternoon`; `online_weekend` → `distance_agreement`. First-meeting photos and completed-meeting state exist only after an actual visit. |
| D06 — repair or expectations | Concrete changed action, agreed space with a follow-up, or refusal | `agreed_space` plays the agreed return; `repair_action` opens a new limited invitation and a privacy-specific follow-through. Refusal reaches `last_repair_offer`; only a further explicit refusal closes contact in `end_unsaid`. Honest rest and boundaries preserve the repair route. |
| D07 — relationship | Mutually agree romance, choose friendship, or end contact with care | `romantic_date`, `friend_activity`, and `amicable_goodbye` are separate activities. Friendship keeps a friendship plan and cannot silently resolve as a romantic or secret reunion. Separation cancels future plans without deleting past events. |
| D08 — Mizuki's work and the future | Agree a realistic plan, renew an earned ritual, explicitly choose uncertainty, separate, or insist on an already unsustainable pattern | Workable plans enact later travel if agreed and select the appropriate good/friend ending. Explicit uncertainty plays `open_conversation`, postpones only unplayed travel and reaches `end_open`. A repeated overpromise gets `burnout_warning`, with a corrective option before `end_burnout`. A renewed ritual can replace a good finale with the distinct `end_secret` activity. Mizuki accepts her own job; Asahi chooses his response. |

## Ending guards

- **A Place for Us:** mutual romance, workable plan, completed first meeting and no unresolved rupture.
- **Same Sky, New Plan:** mutual romance, workable online plan, postponed meeting and no unresolved rupture.
- **Still in the Party:** mutual friendship and a workable friendship plan.
- **Thank You for the Time:** explicit amicable separation; it does not punish healthy incompatibility.
- **Words Left Unsaid:** explicit refusal after the further repair opportunity.
- **Nothing Left to Give:** previous broken overlapping promises, the burnout warning, and explicit refusal of the sustainable alternative.
- **Maybe, Someday:** both explicitly agree to an uncertain future. Missing state never chooses it.
- **The Everyday Hello:** a mutually chosen ritual was kept and renewed, romance and a workable plan are agreed, and no unresolved rupture remains. Available on every activity path; no collectible checklist, extra app, perfect-reply score or retconned earlier acquaintance.

## Evidence

The content audit explores 6,867 decision-relevant states and 174 transitions across all 131 flow nodes. All eight endings are reachable from all three activity paths (24 ending/path combinations). Godot replays generated witnesses for every node and every ending/path combination. This proves implemented reachability and guard behavior; reader testing is still needed to judge whether the consequences feel sufficiently distinct and emotionally credible.
