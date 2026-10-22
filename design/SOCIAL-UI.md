# Nostalgic mobile social UI

Creator direction, 22 October 2026: name the network Noir and flatten the nostalgic social UI. Keep the familiar blue palette and multicolor icon shapes, with solid fills, fine borders and no beveled buttons or gradients. All character conversations use DMs or group chats in Messages. Work and gaming remain story topics, with no separate screens. The account belongs to Asahi. This is a local fictional network with no real social-service login.

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

Settings and Music are header utilities. All authored scene conversations use Messages: the opening runs in Mizuki's DM, later party scenes in After Hours, and office conversations in Hoshino Studio. Old Games/Work screen keys migrate to Messages without repeating a scene or changing a choice. Legacy Notes/Calendar navigation opens Events. Events alone holds progress, objectives and next-action links; no mission banners, progress badges or feed/home objective cards.

## Layout and tone

Use a 414×896 portrait canvas, scaled uniformly inside larger windows with dark blue-gray margins. A flat blue header carries the white Noir wordmark, Settings and Music. Home has accepted-friend search, exactly seven labeled multicolor icons in a three-column grid, three own-photo thumbnails and a flat blue Notifications footer. No hardware bezel, wallpaper, large clock, dock or gesture bar. One standard reading size; headings and metadata have a fixed hierarchy.

White incoming bubbles align left; Asahi's pale-blue bubbles align right. Use flat fills, thin outlines and small tails. Square pixel portraits stand in for profile photos. News Feed uses compact blue Like/Comment/Share links on pale action strips. Asahi types one character at a time, usually 110–190 ms per key with additional word and punctuation pauses. Incoming typing waits last 1.2–5 seconds according to message length. Explicit Send commits a reply; typing, Sent/Read and skip controls never change the selected meaning. Only Later advances fictional time.

Original interface synthesis evokes early iOS: soft keyboard ticks, a lower spacebar click, a short sending whoosh and a three-note incoming chime. These are synthesized cues, not Apple recordings. Keys sound once per visible character, with small pitch variations. Instant messages, Reduce motion and Finish typing skip presentation without a burst of skipped clicks. Interface volume mutes all cues independently of music. Notifications opens a manual list of real incoming message snippets; scene titles never appear as mission notifications.

## Social actions and privacy

Profile supports local fictional statuses up to 280 characters. They appear on Profile and News Feed. Comments also accept up to 280 characters and display as Asahi. Share copies a friend's public-to-friends post onto Asahi's profile; repeated Share does not duplicate it. Posts/comments/shares are optional social activity and do not impersonate a consequential narrative choice or generate AI replies. No real account or network service is involved.

Natsumi starts as Asahi's existing friend. Mizuki's request follows the chance game encounter. Daichi and Misaki requests follow their respective introductions. Accepting or declining never advances the plot, sends a DM or changes the origin of the relationship. Friends opens accepted profiles; Messages remains independently usable. All posted statuses/comments/shares and request decisions persist in saves. Unposted status/comment text is kept during browsing in the current session; it is not a saved narrative reply.

Photos contains Asahi's own images. Friends' photos live on their profiles. Private work drafts and postcards remain under Shared attachments in Mizuki's conversation, with withdrawal respected. Private messages or attachments cannot be shared through the feed's Share action. Placeholder pixel illustrations are still awaiting final artwork.

## Compatibility and verification

Older saves gain safe social defaults while retaining story facts, drafts, delivered messages, receipts, commitments and all eight endings. Validate malformed social data before replacing a save. Run `tools/check.ps1` for branch coverage, saves, migration, request acceptance/decline, statuses, comments, shares, exactly seven sections, profile/photo separation, private attachments and portrait fitting through ultrawide windows. Human playtests and platform export certification remain pending.
