# Social network UI

Creator direction, 22 October 2026: the game is no longer a phone. Tell the story through an original fictional social network using the compact section-grid structure in the supplied early social-network references. Use our own identity, colors and icons rather than Facebook branding. This supersedes the former phone-only and fixed-aspect requirements.

## Visual identity and layout

The working site name is **hello**. Deep teal (#285552), warm paper (#f0eee7), near-white panels (#fffdf8), muted coral (#b77b67), restrained borders and custom pixel pictograms form the theme. Plain readable text stays at one standard reading size. Header, labels and metadata have a fixed hierarchy; there are no alternate text scales. No device frame, signal/battery status, OS dock or home gesture bar.

The site fills its window. Default: 1120×800. At 1060 pixels and wider, show navigation, content and a chat sidebar. From 720 pixels, show navigation and content. Narrower windows use horizontally scrollable section links and one reading column. Content scrolls vertically. The shared header always provides Home, Notifications and Asahi's Profile. No network action depends on swiping an invisible edge.

Home contains a 3-column section grid and a private photo shelf. Its next-action link opens the current scene. The News Feed is a separate optional view. Keep white space and familiar functional labels; avoid decorative dashboards or relationship scores.

## Sections and actions

| Section | Function |
|---|---|
| Home | Section grid, private photo shelf, current-scene link, Notifications and Settings. |
| News Feed | Authored updates, saved Like reactions and expandable authored comments. No freeform public posting. |
| Profile | Asahi's own account, city, photos, private notes and current plan. |
| Friends | Contacts encountered in this run; links to their private conversations. |
| Messages | Separate direct/group threads, call transcripts, drafts and choices. |
| Photos | Earned images, captions and privacy context. |
| Events | Actual commitments, work availability and travel. Internal Calendar key stays compatible. |
| Games | Lantern Quest and its party chats. Random matchmaking starts the relationship. |
| Work | Hoshino Studio team messages and scheduling choices. |
| Notes | First-person reminders, chapter history and current-action links. |
| Settings | Sound, motion, immediate messages, window size, saves and restart confirmation. |

Feed material unlocks from committed events. A private photo, work draft or message is never automatically public. Home's photo shelf is explicitly private. New friends do not introduce Asahi and Mizuki; Daichi appears after their random game encounter. No friends or requests are invented to fill the menu.

## Chat and story state

Incoming messages use left-aligned light bubbles with speaker labels and avatars. Asahi's outgoing bubbles sit on the right in pale sage. Typing dots, varied incoming delays and pauses during composition support intimate conversation. Complete reply wording remains visible before selection. Send is separate; discarding, browsing, resizing or closing never sends it. Sent and Read describe presentation only, not affection or availability. Skips and reduced motion preserve the same chosen text and effects.

The story graph, all three paths and eight endings remain intact. Only explicit Later transitions cross dates. Reactions, notifications, delivered-message cursors and drafts persist. Old phone-era saves keep stable section/node IDs. Profile/feed/friends are lightweight views of Home, so reloading returns to the section grid without discarding narrative state.

Verify the grid, feed actions/privacy, Profile, Friends, section links, notifications, separate threads, unsent drafts, typing completion/skips, receipts, every ending, and clipping at narrow/desktop/ultrawide sizes. Human reading/pacing feedback and final art remain pending.
