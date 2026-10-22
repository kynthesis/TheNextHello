# Nostalgic mobile social UI

Creator direction, 22 October 2026: recreate old Facebook mobile using the supplied reference images, including its blue gradients, wordmark, multicolor icons, red badges and chat bubbles. This replaces the previous teal theme direction. The account belongs to Asahi, with Emily is Away's intimate conversations. No desktop sidebars. This remains a local story game with fictional content and no Facebook login or connection.

## Seven main sections

| Section | Purpose |
|---|---|
| News Feed | Friends' updates, Asahi's statuses, Likes, comments and shared posts. |
| Profile | Asahi's own profile; write a status, revisit posts and shares, open his photos. |
| Friends | Accepted friends' profiles, public-to-friends posts and their photos. |
| Photos | Asahi's own window photo, game screenshots and earned meeting photos. |
| Events | Current story objective, chapter, next-action link, commitments and completed events. |
| Messages | Private DMs, group conversations, call transcripts, drafts and attachments. |
| Requests | Accept or decline new friend requests after story encounters. |

Settings and Music are header utilities. Games, Work, Notes and Calendar remain stable internal narrative/save keys. They are not extra menu sections. Events links to Lantern Quest and work scenes when the story needs them; the Messages conversation list also provides these links. Legacy Notes/Calendar navigation opens Events.

## Layout and tone

Use a 414×896 portrait app canvas, scaled uniformly to fit the window, centered in plain dark blue-gray margins on desktop. Default window is the portrait size. A glossy blue header carries the white facebook wordmark, Settings and Music. Home has Search friends, exactly seven labeled multicolor icons in a three-column grid, three own-photo thumbnails, an Events link and a fixed blue Notifications footer. Search opens an accepted friend's profile by name. No hardware bezel, wallpaper, large clock, device dock or gesture bar. One standard reading size; metadata and headings have a fixed hierarchy, with no alternate text scaling.

Incoming white bubbles align left; Asahi's pale-blue bubbles align right. Both have fine borders, shallow gradients and small speech tails. Square pixel portraits stand in for profile photos. News Feed uses compact blue Like/Comment/Share links on gray-lilac action strips. Skippable typing dots, variable message delays and pauses during Asahi's composition retain the selected wording. Explicit Send commits a reply; Sent/Read never score affection. Only Later advances fictional dates. Buttons, mouse/touch scrolling, visible keyboard focus and Escape provide navigation.

Interface audio is synthesized: a soft key click during visible composition, a short sending chirp and a glassy two-note inbox bell. These recreate the period's sound; they are not extracted Facebook recordings. Global interface volume still mutes every cue independently of music.

## Social actions and privacy

Profile supports local fictional statuses up to 280 characters. They appear on Profile and News Feed. Comments also accept up to 280 characters and display as Asahi. Share copies a friend's public-to-friends post onto Asahi's profile; repeated Share does not duplicate it. Posts/comments/shares are optional social activity and do not impersonate a consequential narrative choice or generate AI replies. No real account or network service is involved.

Natsumi starts as Asahi's existing friend. Mizuki's request follows the chance game encounter. Daichi and Misaki requests follow their respective introductions. Accepting or declining never advances the plot, sends a DM or changes the origin of the relationship. Friends opens accepted profiles; Messages remains independently usable. All posted statuses/comments/shares and request decisions persist in saves. Unposted status/comment text is kept during browsing in the current session; it is not a saved narrative reply.

Photos contains Asahi's own images. Friends' photos live on their profiles. Private work drafts and postcards remain under Shared attachments in Mizuki's conversation, with withdrawal respected. Private messages or attachments cannot be shared through the feed's Share action. Placeholder pixel illustrations are still awaiting final artwork.

## Compatibility and verification

Older saves gain safe social defaults while retaining story facts, drafts, delivered messages, receipts, commitments and all eight endings. Validate malformed social data before replacing a save. Run `tools/check.ps1` for branch coverage, saves, migration, request acceptance/decline, statuses, comments, shares, exactly seven sections, profile/photo separation, private attachments and portrait fitting through ultrawide windows. Human playtests and platform export certification remain pending.
