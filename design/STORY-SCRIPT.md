# The Next Hello: complete branching first draft

Six acts, three activity paths, eight endings. This is the full playable first draft, with every authored line and choice; production pacing and final art remain to be reviewed.

Read one branch at a time. Conditions below are authoring notes and never appear as scores in the interface. All scenes are presented as private messages, transcripts, photographs or saved notes.

## Act 1: A Chance Encounter

### 01 / A chance encounter
ID: `invite` · FRI  23 OCT     23:08 · Games / Lantern Quest

**system:** Random matchmaking pairs you with mizuki for a garden run. You have never met.

**mizuki:** oh hi. first time in this garden?

**mizuki:** i can carry the lantern. unless you want it?

- **Reply:** Deal. Slow and steady. I'd like to see the garden. → `bridge`; records {'role': 'lookout'}.
- **Reply:** I'll take the lantern. You can stop me walking into things. → `bridge`; records {'role': 'lantern'}.

### The crooked bridge
ID: `bridge` · FRI  23 OCT     23:08 · Games / Lantern Quest

**system:** A stone bridge crosses the dark water. A second lantern flickers on the far bank.

**mizuki:** shortcut should be fine

**mizuki:** i did fall in last time. should probably mention that

- **Reply:** Let's light the stepping stones. I'll wait for you. → `first_dm`; records {'garden_memory': 'stones'}.
- **Reply:** Want to try the bridge together? We can be damp legends. → `splash`; records {'garden_memory': 'splash'}.

### A small detour
ID: `splash` · FRI  23 OCT     23:08 · Games / Lantern Quest

**system:** The bridge folds into the water. Two tiny characters respawn under the same leaf.

**mizuki:** okay. nice leaf though

**system:** You save a screenshot of the two of you under the leaf.

- **Reply:** Next time, we take the stones. Keeping the screenshot though. → `first_dm`; records no new fact.

### A new conversation
ID: `first_dm` · FRI  23 OCT     23:08 · Messages / Mizuki

**system:** Lantern garden screenshot added to Photos. A private message arrives from mizuki.

**mizuki:** thanks for waiting btw. most people just go

**mizuki:** Mizuki. Sapporo. currently holding a noodle lid shut with my elbow

- **Reply:** Asahi. Tokyo. Put a book on it. Finally, a use for my unread pile. → `night`; records {'intro': 'books'}.
- **Reply:** Asahi. Tokyo. Glad I'm not the only one having a heroic evening. → `night`; records {'intro': 'heroic'}.

### A little after eleven
ID: `night` · FRI  23 OCT     23:08 · Messages / Mizuki

Major decision: **D01**

**mizuki:** lid defeated. hi Asahi

**mizuki:** i draw for work. six versions of the same window today. needed to look at something else

**mizuki:** you playing again this weekend? or we could do something else. if you want

- **Reply:** Another garden run this weekend? We could play together again. → `guild_agreed`; records {'path': 'guild'}.
- **Reply:** Want to swap window photos? Maybe make something small together. → `private_agreed`; records {'path': 'private'}.
- **Reply:** I'd like to know your everyday life. A call, when we're both free? → `lives_agreed`; records {'path': 'lives'}.

### One more party
ID: `guild_agreed` · FRI  23 OCT     23:08 · Messages / Mizuki

**mizuki:** Yes. Maybe open a small party? As long as we get to play together.

**system:** Saturday's garden run is in Calendar. You and Mizuki will open a public party together.

**Later:** `guild_plan`.

### Two windows
ID: `private_agreed` · FRI  23 OCT     23:08 · Messages / Mizuki

**mizuki:** I'd like that. Two cities, two windows. Maybe a little illustrated postcard?

**mizuki:** Just between us for now. Rough work makes me shy.

**system:** A private photo exchange is in Calendar. Mizuki will send her desk photo tomorrow.

**Later:** `private_photo`.

### Beyond the username
ID: `lives_agreed` · FRI  23 OCT     23:08 · Messages / Mizuki

**mizuki:** A call sounds good. Sunday afternoon? My sister's helping me move a shelf Saturday.

**mizuki:** Fair warning: my everyday life contains a lot of arguing with furniture.

**system:** Sunday's call is in Calendar. Tomorrow, check your work schedule before confirming.

**Later:** `lives_work`.

## Act 2: A Place in the Day

### 02 / A garden for everyone
ID: `guild_plan` · SAT  24 OCT     16:42 · Games / Lantern Quest

**mossbyte:** Hi, I'm Daichi. Thanks for opening the party. A few more new players want to join. Could you lead separate groups?

**mizuki:** I was looking forward to playing together. Could we guide one small group instead?

- **Reply:** One small group. We'll show them the safe route together. → `guild_event`; records {'guild_plan': 'small group'}.
- **Reply:** Let's make a route guide tonight, then let someone else lead. → `guild_guide`; records {'guild_plan': 'route guide'}.

### Lanterns in the rain
ID: `guild_event` · SAT  24 OCT     16:42 · Games / Lantern Quest

**system:** You and Mizuki bring three new players through the garden. At the bridge, everyone waits.

**mizuki:** Look at that. A whole party that doesn't leave anyone behind.

**mossbyte:** I'm keeping the group small next week too. Thanks for saying something.

**Later:** `guild_callback`.

### A map with a warning
ID: `guild_guide` · SAT  24 OCT     16:42 · Games / Lantern Quest

**system:** You mark safe stones while Mizuki draws a tiny skull on the crooked bridge. A newcomer volunteers to guide.

**mizuki:** Our first joint publication. Please credit the skull artist.

**mossbyte:** Pinned the guide. You two can just play tonight.

**Later:** `guild_callback`.

### 03 / The next invitation
ID: `guild_callback` · TUE  27 OCT     20:16 · Messages / Mizuki

**mizuki:** Daichi asked before adding people this time. I think we started something.

**mizuki:** Next Saturday, same garden? I'd like a little time with just you after.

**system:** The conversation stays in your message history. There is another evening ahead, when you choose to continue.

**Later:** `party_evening`.

### 02 / The mug has a new job
ID: `private_photo` · SAT  24 OCT     16:42 · Messages / Mizuki

**system:** Mizuki shared a private desk photo. Read this description or open Shared attachments in Messages: pens in a mug, a half-finished illustration on a laptop, rain against the window.

**mizuki:** Window attempt seven. Application deadline Monday. Please keep this one between us.

- **Reply:** Want quiet company while we make the postcard? We can leave it unfinished. → `private_event`; records {'collaboration': 'quiet company'}.
- **Reply:** Let's move our postcard session until after your deadline. I'll send my photo now. → `private_rescheduled`; records {'collaboration': 'rescheduled'}.

### A room in two cities
ID: `private_event` · SAT  24 OCT     16:42 · Messages / Mizuki

**system:** A song plays softly in the background. You send your rainy Tokyo window; Mizuki sends a small line drawing in return. Neither of you posts it.

**mizuki:** I finished the corner I was stuck on. Quiet company works, apparently.

**system:** A private postcard joins Photos. Mizuki keeps working on her application.

**Later:** `private_callback`.

### Room to finish
ID: `private_rescheduled` · SAT  24 OCT     16:42 · Messages / Mizuki

**mizuki:** Thank you. Tuesday evening? I want to do this when I'm not watching a deadline.

**system:** You share the Tokyo window privately. The postcard session moves to Tuesday; tonight Mizuki works on her application.

**mizuki:** Your window has good rain. Keeping that photo.

**Later:** `private_callback`.

### 03 / After the deadline
ID: `private_callback` · TUE  27 OCT     20:16 · Messages / Mizuki

**mizuki:** Submitted. I checked the attachment three times. Four if we're being honest.

**mizuki:** Can I show you the finished illustration? And I found a short story we could read together.

**system:** The conversation stays in your message history. There is another evening ahead, when you choose to continue.

**Later:** `illustration_evening`.

### 02 / Making room
ID: `lives_work` · SAT  24 OCT     16:42 · Work / Hoshino Studio

**team:** Monday's handoff needs a check. You can finish Saturday afternoon or take the Sunday review. Both are fine; tell me which.

**system:** Mizuki's proposed call is Sunday afternoon. Friday work is available; taking Sunday means explicitly rescheduling the call.

- **Reply:** I'll do the Saturday check so Sunday stays free. → `lives_call`; records {'work': 'Saturday handoff', 'commitment': 'Sunday / Call with Mizuki (confirmed)'}.
- **Reply:** I'll take Sunday. I'll ask Mizuki about another call time before confirming. → `lives_reschedule`; records {'work': 'Sunday review', 'commitment': 'Monday / Call with Mizuki (confirmed)'}.

### A shelf, assembled
ID: `lives_call` · SUN  25 OCT     15:00 · Messages / Mizuki

**system:** Sunday afternoon. A call transcript opens after your completed Saturday handoff.

**mizuki:** Can you hear me? Sorry. My sister says hello. And that I put the shelf upside down.

**asahi:** I'd like the shelf's side of the story.

**mizuki:** It's staying silent. Clever shelf.

**system:** You talk about ordinary weekends, and what a visit might look like. No travel is booked.

**Later:** `lives_callback`.

### A different evening
ID: `lives_reschedule` · MON  26 OCT     19:30 · Messages / Mizuki

**asahi:** I chose the Sunday review. Could we call Monday evening instead? I'd like to give it proper time.

**mizuki:** Monday works. My sister will have gone home, so you'll miss the shelf assembly commentary.

**system:** Monday evening. After the work review, you and Mizuki talk over dinner on a call. No introduction to Misaki happened this time.

**mizuki:** Tell me about Tokyo on a normal day. Not the postcard version.

**Later:** `lives_callback`.

### 03 / A possible journey
ID: `lives_callback` · TUE  27 OCT     20:16 · Calendar / Mizuki

**mizuki:** If we ever meet, I'd rather have an ordinary afternoon than a perfect itinerary.

**system:** You compare a future leave window and agree to discuss it again. A visit is a possibility, not a promise.

**system:** The conversation stays in your message history. There is another evening ahead, when you choose to continue.

**Later:** `sister_intro`.

### The smallest party
ID: `party_evening` · SAT  31 OCT     19:40 · Games / Lantern Quest

**mossbyte:** I put FOUR in the party description. Someone has asked if six counts as four with enthusiasm.

**mizuki:** It does not. I have spoken to mathematics.

**asahi:** Our guide says the bridge is safe if you don't stand on it. A difficult instruction for a bridge.

**mossbyte:** Two new players are nervous about asking for help. Could you show them how we use the lanterns?

**mizuki:** Only if we actually play together afterward. Last week I spent more time explaining the game than playing it.

**mossbyte:** Fair. I'll close the party after this run. No surprise additions.

**system:** You light the first stepping stone. A new player waits for your second lantern instead of running ahead.

**mizuki:** There. Better than a perfect run. Someone stayed.

- **Reply:** One for them, then one just us? → `after_game`; records {'ritual': True}.
- **Reply:** Can we just play tonight? Guide another day. → `party_rest`; records {'ritual': False}.

### After everyone leaves
ID: `after_game` · SAT  31 OCT     21:15 · Messages / Mizuki

**mizuki:** he actually closed the party lol

**asahi:** Someone give him a badge.

**mizuki:** don't. he'll organize a ceremony

**mizuki:** liked that last run. just us

**asahi:** Me too.

**mizuki:** next Saturday? just a short one if we're around

**system:** Calendar: an optional Saturday check-in. Either person can cancel by saying so.

**mizuki:** and if we're not around that's fine. don't want to make it homework

**Later:** `natsumi_invite`.

### An evening that belongs to us
ID: `party_rest` · SAT  31 OCT     21:15 · Messages / Mizuki

**mizuki:** I didn't know I was tired until we said no to the extra run.

**asahi:** Daichi sent a picture of four empty party slots. I think he is learning restraint.

**mizuki:** Good for him. Better for us.

**mizuki:** I don't need us to establish a whole tradition after knowing each other for a week. Tonight was nice on its own.

**asahi:** We can let it be one nice evening.

**mizuki:** Thank you. I want to come back because I want to, not because we filled a square on a calendar.

**system:** You leave Saturday open. The next invitation will require a new agreement.

**Later:** `natsumi_invite`.

### The corner she kept
ID: `illustration_evening` · SAT  31 OCT     20:10 · Messages / Mizuki

**mizuki:** Finished illustration attached. The window is still crooked. Deliberately now, which apparently makes it style.

**asahi:** That is also how I describe my laundry pile.

**mizuki:** The client accepted the application sample. I am trying not to turn that into a prediction of my entire future.

**system:** In the attached drawing, one small rectangle of warm light sits beneath a gray sky. Your rainy-window photo is beside it in Photos.

**mizuki:** The story I mentioned is about a person who keeps taking the wrong train because the platform is quiet. I wondered if you'd read a page with me.

**asahi:** Out loud? My dramatic voice is mostly my normal voice with worse posture.

**mizuki:** Quietly is fine. I liked knowing someone else was doing something ordinary nearby.

- **Reply:** A page and a window photo on Saturdays, when we can? No catching up required. → `reading_evening`; records {'ritual': True}.
- **Reply:** Let us just read this page tonight. We can decide next time when it comes. → `reading_once`; records {'ritual': False}.

### Two bookmarks
ID: `reading_evening` · SAT  31 OCT     21:00 · Messages / Mizuki

**mizuki:** The line I kept: the platform wasn't where she was going, but it was somewhere she could breathe.

**asahi:** I keep thinking she could also just go home. Then I remember the first apartment I rented in Tokyo.

**mizuki:** Bad apartment?

**asahi:** Fine apartment. Very good walls. Nothing on either side I recognized yet.

**mizuki:** Mine had a kettle that clicked so loudly I thought someone had come in. I liked the sound anyway.

**asahi:** A page and a window, then. Small enough for a bad week.

**mizuki:** And optional enough for a worse one. I want the tradition, not homework.

**system:** Saturday's optional reading check-in appears in Calendar. The finished drawing remains private.

**Later:** `natsumi_invite`.

### One page is enough
ID: `reading_once` · SAT  31 OCT     21:00 · Messages / Mizuki

**mizuki:** I reached the bottom. The character finally took her own train. Character development through public transport.

**asahi:** I have eaten dinner while we read. That may also count as development.

**mizuki:** What did you have?

**asahi:** A meal assembled from things with different reheating times. Some of it was excellent.

**mizuki:** I like knowing these tiny, useless facts. They make the photo feel less like a postcard.

**system:** You close the attachment without making a standing appointment. Tonight's conversation stays in history.

**Later:** `natsumi_invite`.

### A shelf with witnesses
ID: `sister_intro` · SAT  31 OCT     15:20 · Messages / Mizuki

**mizuki:** Misaki asked if you are the person who recommended putting a book on the noodle lid.

**asahi:** A lasting legacy. I hoped to be remembered for more, but I accept this.

**mizuki:** She wants to thank you. The shelf instructions were not heavy enough. Are you okay if I add you both to a chat?

**mizuki:** You can say not yet. She is not interviewing applicants for a position in my life.

- **Reply:** Sure. Tell her I take no responsibility for load-bearing books. → `family_chat`; records {'sister_contact': True}.
- **Reply:** Another time? I would like to know you a little better first. → `ordinary_call`; records {'sister_contact': False}.

### Three people and a shelf
ID: `family_chat` · SAT  31 OCT     15:30 · Messages / Mizuki & Misaki

**misaki:** Hello, Asahi. I am told you are responsible for the successful noodles.

**asahi:** The book did most of the work.

**misaki:** Good. I prefer people who credit their team.

**mizuki:** The team is a paperback with soup on it.

**misaki:** I move next month. She has helped every weekend and pretended it takes no time. If she falls asleep during a game, it isn't a review of your personality.

**mizuki:** I can explain my own schedule, you know.

**misaki:** You can. I will stop. I do want the shelf photograph kept in this chat. Our mother does not need evidence.

**asahi:** Understood. Private archive, questionable carpentry.

**Later:** `ordinary_call`.

### What happens between calls
ID: `ordinary_call` · SAT  31 OCT     20:00 · Messages / Mizuki

**mizuki:** i was trying to think of something to tell you. bought detergent. that's about it

**asahi:** Renamed a file six times. Big day here too.

**mizuki:** could call anyway? don't have to do anything

**asahi:** I'd like that. Need to wash up though. If I go quiet it's the dishes.

**mizuki:** okay good. was fully prepared to overthink that

- **Reply:** Saturdays, if we can? "Dishes" means back in a bit. → `small_call`; records {'ritual': True}.
- **Reply:** Tonight, yes. Can we ask each time though? Saturdays get messy. → `call_once`; records {'ritual': False}.

### Dishes
ID: `small_call` · SAT  31 OCT     21:00 · Messages / Mizuki

**system:** Call transcript. A tap runs in Tokyo; a cupboard closes in Sapporo.

**mizuki:** Dishes.

**asahi:** Understood. I will wait in this highly exclusive silence.

**system:** Three minutes later, Mizuki returns to describe a mug whose handle gets hot. Asahi admits he owns a pan lid with no matching pan.

**mizuki:** I don't know why this is nice.

**asahi:** Maybe we don't have to entertain each other every second.

**mizuki:** Let's keep that part. If we have a Saturday, we can share some of it. If we don't, we can say so.

**Later:** `natsumi_invite`.

### A plan for tonight
ID: `call_once` · SAT  31 OCT     21:00 · Messages / Mizuki

**mizuki:** Tonight works. I appreciate you saying what you can actually offer.

**asahi:** My calendar is mostly guesses. I'm trying to label them.

**mizuki:** Mine includes a box called "probably tired." It is the most accurate one.

**system:** You eat dinner with the call open. Neither person fills every silence. When Mizuki says she wants to draw alone, the call ends without an argument.

**mizuki:** I liked this. We can ask again. An invitation is nicer than a test.

**Later:** `natsumi_invite`.

## Act 3: What We Carry

### The invitation that was already there
ID: `natsumi_invite` · WED  04 NOV     18:15 · Messages / Natsumi

Major decision: **D02**

**natsumi:** You remember the showcase on Sunday? You said you could help me hang the prints. I have finally bought hooks that fit the wall.

**asahi:** The famous hooks. I was starting to think they were a metaphor.

**natsumi:** They were a week of my life. Please respect the medium.

**system:** Calendar: the showcase overlaps with the Sunday afternoon Mizuki offered for a longer session. Both people are waiting for an answer.

**natsumi:** I can find another pair of hands if you tell me now. I cannot find one five minutes after opening.

**natsumi:** Also, I would like you there as my friend. Not just as someone tall enough to reach things.

- **Reply:** I said I would be there. I will keep Sunday and ask Mizuki for another time. → `showcase`; records {'friend_plan': 'kept', 'commitment': 'Sunday / Natsumi showcase; Mizuki rescheduled'}.
- **Reply:** Can I help install Saturday and come to the opening briefly? I want to agree a real alternative with you. → `showcase_setup`; records {'friend_plan': 'renegotiated', 'commitment': 'Saturday setup / Sunday brief showcase'}.
- **Reply:** I can do both. Keep me on the full Sunday shift; I will make the other plan fit. → `showcase_missed`; records {'friend_plan': 'missed', 'overpromise': True, 'commitment': 'Two knowingly overlapping Sunday promises'}.

### The person on this side of the screen
ID: `showcase` · SUN  08 NOV     16:40 · Messages / Natsumi

**system:** In Photos: Natsumi on a step stool, one print held sideways. Caption: "Do not let the artist measure things."

**natsumi:** We sold two. Two whole people walked in and wanted something I made in their houses.

**asahi:** Three, if your mother is allowed to buy the same print twice.

**natsumi:** She is. I run a generous institution.

**natsumi:** You checked your phone once, told me who you were answering, and came back. That was nice. I don't need your life to stop for my afternoon.

**system:** Mizuki's message arrives after the showcase: "Thanks for moving our plan instead of disappearing from one. How did it go?"

**natsumi:** Tell this mysterious person I approve of her timing. Then help me remove the hooks we have only just learned to love.

**Later:** `privacy_request`.

### The alternative that happened
ID: `showcase_setup` · SUN  08 NOV     12:20 · Messages / Natsumi

**natsumi:** Saturday setup was the right call. I could sleep last night instead of arguing with the hanging wire.

**asahi:** That is the first positive review of my knot work.

**natsumi:** You came back today, too. Half an hour was half an hour because you told me before I built my expectations around three.

**system:** In the photo Natsumi sends, your jacket is visible behind the first visitor. Later, you join Mizuki at the time you agreed together.

**natsumi:** I am keeping one of the unsold prints for you. Not payment. A threat to your empty walls.

**asahi:** My walls are frightened and grateful.

**Later:** `privacy_request`.

### An empty square on the floor
ID: `showcase_missed` · SUN  08 NOV     18:30 · Messages / Natsumi

**natsumi:** I waited for forty minutes before asking the shop owner to help. I couldn't leave the table.

**asahi:** I lost track of the other session. I thought I could get across town faster.

**natsumi:** You knew the times overlapped. I could have accepted a no. I built the afternoon around your yes.

**system:** The showcase goes ahead without you. Its photograph arrives after closing; someone else stands where your ladder was meant to be.

**natsumi:** I don't want an enormous apology tonight. I want a smaller promise that actually happens. Can you collect the remaining boxes tomorrow?

- **Reply:** Yes. Send me the collection time. I will decline the other plan before agreeing to this one. → `friend_repair`; records {'friend_repair': True}.
- **Reply:** I am not going to be available. I will pay the delivery fee and stop promising to turn up. → `friend_distance`; records {'friend_repair': False}.

### The boxes
ID: `friend_repair` · MON  09 NOV     19:10 · Messages / Natsumi

**system:** You collect the boxes at the agreed time. Natsumi sends a photo of the empty storage corner.

**natsumi:** Thank you. That helped. Yesterday still happened, but so did this.

**asahi:** I was trying to be available to everyone without telling anyone what I could actually do.

**natsumi:** Yes. It is a very lonely way to make people like you.

**natsumi:** I am still your friend. Next time I ask, tell me the actual answer. Even if it is boring.

**system:** Her next message is a photograph of one print leaning against your door. A friendship continues with a repaired agreement, not an erased afternoon.

**Later:** `privacy_request`.

### A smaller circle
ID: `friend_distance` · MON  09 NOV     19:10 · Messages / Natsumi

**natsumi:** Delivery is arranged. Thank you for paying the fee.

**asahi:** I don't want this to be the end of us talking.

**natsumi:** It doesn't have to be. But I'm not asking you to help with the next event. I need to know I can run it without waiting.

**system:** Natsumi keeps sending occasional ordinary messages. She stops asking you to share responsibility for her work. That change remains true later.

**natsumi:** Go enjoy the person you keep checking your phone for. Just remember there are people in the place you already live.

**Later:** `privacy_request`.

### The picture without permission
ID: `privacy_request` · SAT  14 NOV     20:15 · Messages / Mizuki

Major decision: **D03**

**mizuki:** Work-in-progress attached. This is the application I didn't want to talk about until it existed.

**system:** Image description: a tram window reflected over a drawing of a small print shop. A client's draft name appears in one corner.

**mizuki:** Please keep this one between us. The client hasn't announced the project, and that name should not be outside my work folder yet.

**mizuki:** You can ask me about the drawing. You can't put it in the game chat to show people what I do.

**system:** Daichi has asked whether Mizuki might contribute an illustration to a public route guide. Sharing with a group would be publication, not a private compliment.

- **Reply:** May I ask for a separate approved image for the guide? This draft stays private. I am happy to join a caption-check chat with Misaki if you both want that. → `permission_granted`; records {'privacy': 'permission', 'rupture': False}.
- **Reply:** I will keep it private. We can make the postcard just for ourselves. → `private_collection`; records {'privacy': 'private', 'rupture': False}.
- **Reply:** I will post this draft in the public game chat anyway. People should see how good it is. → `privacy_breach`; records {'privacy': 'breach', 'rupture': True}.

### The version she chose
ID: `permission_granted` · SUN  15 NOV     16:00 · Messages / Mizuki & Misaki

**mizuki:** New attachment. I removed the client layer and drew a different window. This one may go in the route guide, with my name.

**misaki:** I am helping her check the caption, with permission to be in this chat. Hello again, or hello properly, Asahi.

**asahi:** Hello properly. I have also been checking that I understand which file is which.

**misaki:** That sounds basic until someone does not do it.

**system:** You publish only the approved image. The game guide credits Mizuki; the private draft remains in the private Photos collection.

**mizuki:** Someone asked if I would do another little drawing. I said maybe, after my paid work. You didn't answer for me. I noticed.

**misaki:** Good. She gets to be an artist and a person with a Sunday.

**Later:** `approved_workshop`.

### A room she agreed to enter
ID: `approved_workshop` · WED  18 NOV     20:00 · Games / Lantern Quest

**mossbyte:** Approved image is pinned. Client draft is not in the guide. Everyone has survived reading the caption.

**mizuki:** An historic day for file management.

**asahi:** I will try not to let our success change me.

**system:** You and Mizuki run a small drawing-and-route workshop. New players add their own warning symbols to dangerous stones.

**mizuki:** This is fun because I chose to be here. That matters more than whether everybody likes the drawing.

**mossbyte:** Next workshop can wait. I am learning how not to volunteer people while thanking them.

**Later:** `work_decision`.

### An audience of one
ID: `private_collection` · SUN  15 NOV     16:00 · Messages / Mizuki

**mizuki:** Thank you for not making me justify it twice.

**asahi:** Daichi can make the guide without this picture. It is still a good picture if no one else sees it.

**mizuki:** Sometimes I forget that. Work makes everything feel like a thing that should be posted when it is finished.

**system:** In Photos, the draft remains marked Private. No public workshop is scheduled. Instead, you exchange one unfinished page each.

**mizuki:** Your page has a rice stain.

**asahi:** That is a separate collaboration with dinner.

**mizuki:** I like the part you drew before you tried to make it presentable. Can we keep that too?

**Later:** `private_second_page`.

### The things that do not get posted
ID: `private_second_page` · WED  18 NOV     20:00 · Messages / Mizuki

**system:** You open a shared call while Mizuki finishes the paid file. The unfinished pages stay in a two-person collection.

**mizuki:** I thought the quiet version of this would feel like missing an opportunity. It feels like having a room with a door.

**asahi:** We can open it when we want. Or not.

**mizuki:** Exactly. Tell me one thing you made today that no one is going to applaud.

**asahi:** A mostly successful lunch. A folder I can actually find things in. This time.

**mizuki:** I will take those. I made a boundary and a bad cup of tea.

**Later:** `work_decision`.

### Where the file went
ID: `privacy_breach` · SUN  15 NOV     16:00 · Messages / Mizuki

**mizuki:** Daichi sent me the link. I asked you not to post that file.

**asahi:** I wanted people to see your work. I wasn't trying to hurt you.

**mizuki:** I know what you wanted. I am telling you what happened. The draft has a client name on it. Someone downloaded it before Daichi removed the post.

**system:** The public workshop is canceled. Misaki does not join the planning chat. Deleting your message does not remove the copy someone saved.

**mizuki:** I need to contact the client. Please do not explain my work to anyone else while I do that.

**mizuki:** We will talk about this. Not while I am cleaning it up.

**Later:** `canceled_workshop`.

### The evening that did not happen
ID: `canceled_workshop` · WED  18 NOV     20:00 · Messages / Daichi

**mossbyte:** I removed the image and asked the person with the copy to delete it. I cannot promise that they did.

**asahi:** Can I join the workshop to explain?

**mossbyte:** There is no workshop. Mizuki canceled it. Making her hear an explanation in front of strangers would be another thing she did not agree to.

**system:** The game stays available, but the collaborative event does not. You run the garden alone; the route guide uses plain arrows instead of her drawing.

**mossbyte:** When someone gives you a file, they are not giving you their yes to everything you could do with it.

**asahi:** I understand that more clearly now.

**mossbyte:** Tell her what you will do differently. Then do it. She can still decide it is not enough.

**Later:** `work_decision`.

## Act 4: The Distance Between Us

### The days have edges
ID: `work_decision` · MON  23 NOV     18:05 · Work / Hoshino Studio

Major decision: **D04**

**team:** We need a final layout check on the weekend of the 28th. You asked about travel. There are three ways to cover it; none require pretending we have two of you.

**team:** You can take the check and use January leave. You can ask for a Friday handoff if you finish the draft by Thursday. Or you can tell me you are still deciding.

**asahi:** If I promise Friday and miss Thursday, who has to pick it up?

**team:** Someone who has already made their own weekend plans. I am being explicit because last-minute optimism costs other people time.

**system:** Mizuki has offered the following weekend for an early visit. A completed Friday handoff would make it feasible; accepting the weekend check means proposing a later visit.

**team:** I would rather approve a smaller plan that happens than reassure everyone with a plan that cannot.

- **Reply:** I will finish the draft Thursday and request the Friday handoff. Please confirm before I book anything. → `work_adjusted`; records {'leave': 'approved', 'work_broken': False, 'work': 'Friday handoff; early December leave approved'}.
- **Reply:** I will take the weekend check. I will discuss January with Mizuki instead of promising December. → `work_kept`; records {'leave': 'deferred', 'work_broken': False, 'work': 'Weekend check kept; January leave available'}.
- **Reply:** Put me on the weekend check. I will promise Mizuki the early weekend too and sort it out afterward. → `work_broken`; records {'leave': 'deferred', 'work_broken': True, 'work': 'Overlapping work and travel promises; leave not approved'}.

### The handoff
ID: `work_adjusted` · FRI  27 NOV     18:00 · Work / Hoshino Studio

**team:** Draft received Thursday. Friday checks are done. Your leave is approved.

**asahi:** I am still finding errors in files I already checked.

**team:** You are a person, not a guarantee. You left a readable list of what remains. That is what a handoff is.

**system:** Calendar records the approved dates. Nothing has been booked for either person yet.

**team:** In January I can let you own a small project if you want it. You showed me where the risks were instead of concealing them.

**asahi:** Let us talk about the actual workload before I say yes.

**team:** Excellent. You are learning the sentence I wish everyone knew.

**Later:** `visit_plan`.

### The weekend he stayed
ID: `work_kept` · SAT  28 NOV     18:00 · Work / Hoshino Studio

**team:** Thanks for the check. You found the missing export before it went out.

**asahi:** I wanted to be somewhere else today. I also agreed to do this.

**team:** Both can be true. Put in your January request while the calendar is clear.

**system:** You send Mizuki the available dates rather than a photograph of a booked ticket. She sends back three evenings she can actually keep.

**team:** The next review is yours if you want it. It comes with a planning meeting, not an assumption that you are always here.

**asahi:** I would like to plan it. I am getting better at telling the difference.

**Later:** `visit_plan`.

### Someone else stayed late
ID: `work_broken` · SAT  28 NOV     19:30 · Work / Hoshino Studio

**team:** You said the check would be done before leaving. It wasn't. Someone else missed their train to finish it.

**asahi:** I thought I could do it on the way. The connection dropped and the export was wrong.

**team:** I am not arguing about the connection. You accepted two plans that needed the same hours.

**system:** Leave is deferred. The early visit is not booked. You complete a supervised handoff on Monday; the optional January project goes to someone else.

**team:** Next time, choose before the conflict becomes someone else's evening. A no would have been manageable.

**asahi:** I owe them an apology and a real handoff. I can do both without asking them to tell me I meant well.

**Later:** `visit_plan`.

### A date is not a feeling
ID: `visit_plan` · SUN  29 NOV     20:10 · Messages / Mizuki

Major decision: **D05**

**mizuki:** so. about coming here

**asahi:** I'd get a hotel. We could just meet for an afternoon?

**mizuki:** yes. want to see you. just a bit scared of planning a whole weekend

**system:** Calendar shows Asahi's confirmed work commitments. A ticket will be booked only after both people have agreed to the visit.

**mizuki:** January works too. or we can wait. please don't buy a ticket just because i brought it up

**mizuki:** what do you want to do?

- **Reply:** My leave is approved. Can we agree December 5, an afternoon in Sapporo, with separate places to stay? (requires {'leave': 'approved', 'rupture': False}) → `early_arrival`; records {'visit': 'early', 'meeting_plan': 'confirmed', 'commitment': '5 December / First Sapporo afternoon'}.
- **Reply:** January 16 gives us time to plan. I want to meet you then, after we have talked through what still needs attention. → `late_anticipation`; records {'visit': 'late', 'meeting_plan': 'confirmed', 'commitment': '16 January / First Sapporo afternoon'}.
- **Reply:** I want to keep getting to know you online for now. Can we revisit travel without treating this as a rejection? → `online_weekend`; records {'visit': 'online', 'meeting_plan': 'postponed', 'commitment': 'Online for now; travel discussion in February'}.

### The last three minutes
ID: `early_arrival` · SAT  05 DEC     13:57 · Messages / Mizuki

**system:** Travel folder: hotel confirmation, return ticket, and the station exit Mizuki suggested.

**mizuki:** by the exit. gray coat. enormous scarf. tea

**asahi:** There are three gray coats. Think I just waved at a vending machine.

**mizuki:** good choice. very dependable

**asahi:** Wait. Think I see you.

**mizuki:** yeah. hi. sorry i'm still texting. come over?

- **Reply:** Me too. Can I hug you when I get there, if you still want that? → `early_afternoon`; records {'greeting': 'offered hug'}.
- **Reply:** We can start with hello and walk a little. There is no test to pass. → `early_afternoon`; records {'greeting': 'quiet hello'}.

### A photograph with no landmark
ID: `early_afternoon` · SAT  05 DEC     19:45 · Messages / Mizuki

**mizuki:** Back home. Your tea receipt is in my pocket. I have no idea why I kept it.

**asahi:** Evidence that I can buy a drink in person, after weeks of describing drinks by text.

**system:** Saved note: We asked before moving closer. Then we walked, took a wrong turn, and found a shop where neither of us knew what to order. I liked hearing her decide out loud.

**mizuki:** I was quieter than I expected. You didn't try to turn me back into the version who has time to compose a message.

**asahi:** I was trying not to explain every silence. I liked walking with you.

**system:** A shared photo is added to Photos: two cups on a scratched table, a scarf on the empty chair, no famous landmark.

**mizuki:** If we do this again, I would like another ordinary afternoon. Longer eventually. Not because this one was insufficient.

**Later:** `return_tokyo`.

### A weekend with a future date
ID: `late_anticipation` · SAT  05 DEC     19:45 · Messages / Mizuki

**mizuki:** The station was full today. I caught myself looking for someone I know is not arriving until January.

**asahi:** Is that nice or awful?

**mizuki:** A little of both. I didn't want to send only the nice half.

**system:** Calendar: January 16. In Photos, our pictures still come from separate cities. I keep wondering what we will choose to photograph together.

**mizuki:** I asked for the afternoon off work. Approved. Have you checked your leave before we buy anything?

**asahi:** Yes. We can compare confirmations instead of treating the tickets like a surprise gift.

**mizuki:** Good. I want a meeting we both get to arrive at.

**Later:** `january_preparation`.

### An afternoon without a ticket
ID: `online_weekend` · SAT  05 DEC     19:45 · Messages / Mizuki

**mizuki:** No station today. I wondered if I would be disappointed all afternoon. Then I bought bread and thought I could tell you about that instead.

**asahi:** I would like the bread report.

**mizuki:** Extremely detailed. Potentially several paragraphs.

**system:** Call transcript: we compare photographs from our kitchens, argue amiably about bread, then play one short garden encounter before dinner.

**mizuki:** I still want to know if we will meet. I can live with not deciding today. I can't live with never being allowed to ask.

**asahi:** We put the discussion in February. I won't pretend the reminder is a ticket.

**Later:** `distance_agreement`.

## Act 5: What We Ask of Each Other

### The room after the train
ID: `return_tokyo` · SUN  06 DEC     21:10 · Messages / Mizuki

**mizuki:** home?

**asahi:** Yeah. Haven't unpacked.

**mizuki:** found your receipt again. was going to throw it out

**asahi:** Did you?

**mizuki:** no. stupid isn't it. yesterday i could just look up and you were there

**system:** Photos: our two cups. I open it again before answering.

**mizuki:** glad you came. just having a bit of a night. you don't have to fix it

**Later:** `conflict_check`.

### What a ticket cannot say
ID: `january_preparation` · SAT  12 DEC     20:30 · Messages / Mizuki

**mizuki:** I made a list of places. Then crossed out half because I was designing an advertisement for my city instead of an afternoon with you.

**asahi:** I would like a place to sit down. Strong contender for first place.

**mizuki:** Revolutionary. I can offer several chairs.

**system:** You compare the actual travel confirmation and an agreed hotel. Neither booking changes relationship mode or implies physical intimacy.

**mizuki:** If we discover that we need more time, the trip can still be a good thing. I want us to be able to say that before it happens.

**asahi:** We can come home knowing more, instead of promising what the afternoon must mean.

**Later:** `conflict_check`.

### The question that stays
ID: `distance_agreement` · SAT  12 DEC     20:30 · Messages / Mizuki

**mizuki:** Someone asked me if I have met you. I said not yet, then wondered if I was promising something neither of us has promised.

**asahi:** Would "not so far" be more honest?

**mizuki:** Less pretty. More honest. I don't mind the distance tonight. I mind not knowing which parts I am meant to wait for.

**system:** Saved note: We have a plan for February: talk honestly about travel. Until then, the screen is where we meet. I need to know what we are each expecting from it.

**mizuki:** When we talk in February, can we let the answer be specific? Yes to a plan, no to one, or an honest uncertainty we both choose.

**asahi:** Yes. I will show up for the question, even if I don't know the answer in advance.

**Later:** `conflict_check`.

### The conversation we owe
ID: `conflict_check` · SUN  13 DEC     19:00 · Messages / Mizuki

**mizuki:** hey. can we talk about something? keep putting this off

**asahi:** Yeah. I'm here.

**mizuki:** let me finish first? please

**system:** Saved note: I scrolled back before answering. I had remembered the explanation I wanted to give more clearly than the words she actually sent.

**Later:** `expectations_talk`.
- When {'privacy': 'breach'}: `privacy_repair`.
- When {'work_broken': True}: `promise_repair`.

### Intent is the beginning of the explanation
ID: `privacy_repair` · SUN  13 DEC     19:15 · Messages / Mizuki

Major decision: **D06**

**mizuki:** client accepted the correction. spent most of yesterday sorting it out

**asahi:** I wanted people to see how good it was. I know. You asked me not to.

**mizuki:** i did. that's what i keep coming back to. i actually said it

**mizuki:** i'm not doing the workshop. even if we're okay later. please don't ask again

**system:** The canceled workshop remains canceled. Repair can open a different private activity; it cannot rewrite the public download.

- **Reply:** I crossed a clear boundary. I will ask before sharing, document what I removed, and accept that some things stay closed. → `repair_action`; records {'repair': 'action'}.
- **Reply:** I hear you. Can we take a few days, then talk Thursday? I will not share or contact the client in the meantime. → `agreed_space`; records {'repair': 'space'}.
- **Reply:** You should judge my intention. I am not discussing this again. → `last_repair_offer`; records {'repair': 'refused'}.

### The cost of being reassuring
ID: `promise_repair` · SUN  13 DEC     19:15 · Messages / Mizuki

Major decision: **D06**

**mizuki:** When you said the work weekend and our weekend were both fine, I made plans around it. Then someone else stayed late and I canceled an afternoon I could have used.

**asahi:** I wanted to be the person who could make both things work.

**mizuki:** I wanted an answer I could use. Those are not the same thing.

**mizuki:** I don't need you to be available all the time. I need you to tell me when you aren't, before I turn your guess into my plan.

- **Reply:** I will compare the actual times before agreeing, and tell you before changing an accepted plan. → `repair_action`; records {'repair': 'action'}.
- **Reply:** Can we pause planning until Thursday and look at both calendars then? I need time to stop promising out of panic. → `agreed_space`; records {'repair': 'space'}.
- **Reply:** I was busy. If that is not enough for you, I am not having this conversation. → `last_repair_offer`; records {'repair': 'refused'}.

### No villain in the conversation
ID: `expectations_talk` · SUN  13 DEC     19:15 · Messages / Mizuki

Major decision: **D06**

**mizuki:** nothing bad happened. sorry, that sounded ominous

**mizuki:** sometimes i open a message and then go do something. been feeling like i should explain every time

**asahi:** I do stare at the Read thing. More than I'd like to admit.

**mizuki:** sometimes it's literally just the kettle. or Misaki calling

**mizuki:** i want to talk to you. just can't always be a whole conversation right then. can that be okay?

- **Reply:** Let us confirm planned calls, and treat ordinary replies as something we send when we have room. → `repair_action`; records {'repair': 'action'}.
- **Reply:** Can we try a few quiet days and talk Thursday? I want to learn what space feels like without treating it as rejection. → `agreed_space`; records {'repair': 'space'}.
- **Reply:** If you care, you should always answer when I am waiting. I will not accept less. → `last_repair_offer`; records {'repair': 'refused'}.

### Thursday means Thursday
ID: `agreed_space` · THU  17 DEC     19:30 · Messages / Mizuki

**system:** Calendar reminder: Thursday, 19:30. The quiet days we agreed to are over. I want to return when I said I would.

**mizuki:** hi. Thursday

**asahi:** Hi. Almost messaged you yesterday. Didn't know what to do with the evening.

**mizuki:** what did you end up doing?

**asahi:** Cooked. Called Natsumi. Did the work I'd been avoiding. Pretty ordinary.

**mizuki:** ordinary sounds good. what did you cook?

**Later:** `repair_action`.

### Something smaller than a speech
ID: `repair_action` · FRI  18 DEC     20:00 · Messages / Mizuki

**system:** Asahi writes the agreement in Notes: confirm shared plans, ask before sharing, and let an ordinary reply arrive without treating its timing as proof of love.

**mizuki:** I read it. I want to add that either of us can revise it. We are not making a contract that punishes being human.

**asahi:** Agreed. When something changes, we talk instead of silently rewriting the rule.

**mizuki:** I am not promising I will never feel hurt again. I am saying I want to see what we do next.

**system:** They agree to a private exchange of ordinary photos. It is a new, limited invitation, not a way to erase an earlier evening.

**mizuki:** Here is today's cup. The tea was bad. You may tell absolutely no one about my sophisticated taste.

**asahi:** Private archive. Critically important evidence.

**Later:** `kept_agreement`.
- When {'privacy': 'permission'}: `licensed_update`.
- When {'privacy': 'private'}: `private_update`.
- When {'privacy': 'breach'}: `boundary_followthrough`.

### A second chance to hear it
ID: `last_repair_offer` · THU  17 DEC     19:30 · Messages / Mizuki

**mizuki:** I waited until Thursday because I didn't want this to be decided by the worst moment of a conversation.

**mizuki:** I will not agree to constant access to my time, or to a boundary counting only when you like the reason.

**mizuki:** If you want to talk about what you can change, I am willing to listen. If you don't, I am going to end this here.

**asahi:** You mean that.

**mizuki:** Yes. I don't want us to learn that saying something clearly only makes the other person explain it away more patiently.

- **Reply:** I heard a demand when you were explaining a need. I want to talk about what I can change. → `repair_action`; records {'repair': 'action'}.
- **Reply:** I still refuse. I expect you to accept this arrangement as it is. → `end_unsaid`; records {'relationship_mode': 'separated', 'resolution': 'refused_repair'}.

### A quiet answer
ID: `kept_agreement` · SUN  20 DEC     21:00 · Messages / Mizuki

**mizuki:** I missed the optional check-in yesterday. I sent a message beforehand and went to bed.

**asahi:** I saw it. I played one run and went out for groceries. The tomatoes were more expensive than my optimism.

**mizuki:** You didn't ask me to prove I was tired. That made it easier to come back today.

**asahi:** I missed you. I also managed to have a Saturday. Both survived.

**mizuki:** Good. I kept our little thing tonight, if we are still doing it. A page, a lantern, a cup. Whatever shape we started with.

**system:** They look at the small things they have chosen to share, and decide what they want to keep doing.

- **Reply:** I would like to keep it, when we both can. The right to say not tonight is part of it. (requires {'ritual': True}) → `natsumi_return`; records {'ritual_kept': True}.
- **Reply:** Tonight is enough. I would rather ask each time than keep a standing ritual. → `natsumi_return`; records {'ritual_kept': False}.

### A friend with her own January
ID: `natsumi_return` · TUE  22 DEC     18:30 · Messages / Natsumi

**natsumi:** I got a little residency for January. Not abroad. Two train stops away. I am still telling everyone as though I have been selected to live on the moon.

**asahi:** The moon has less convenient lunch.

**natsumi:** Exactly. I chose wisely.

**natsumi:** I want to hear about your life. I also want to tell you about mine before it turns into advice about the person on your phone.

**asahi:** Tell me what you are making.

**natsumi:** Bigger prints. I was going to pretend it was a grand artistic decision. Mostly I want to stop apologizing for how much wall they need.

**system:** Natsumi's next offer depends on the showcase agreement. A repaired friendship can support a new invitation; an unrepaired absence does not earn one automatically.

**Later:** `friend_update`.
- When {'friend_plan': 'renegotiated'}: `studio_lunch`.
- When {'friend_support': True}: `friend_confidant`.

### An invitation without a ladder
ID: `friend_confidant` · WED  23 DEC     19:00 · Messages / Natsumi

**natsumi:** Come see the studio when I get the key. No lifting required. I want you there because you are you.

**asahi:** I will check the date and answer properly. That sentence is becoming a personality trait.

**natsumi:** Better than disappearing optimistically.

**asahi:** I think I might be in love with someone far away. I am trying to work out what the sentence asks us to do.

**natsumi:** Ask her. I can listen, but I can't become the person who tells you what she means.

**natsumi:** And if you want something different, say it while there is still a conversation to have.

**Later:** `local_dinner`.

### News rather than a favor
ID: `friend_update` · WED  23 DEC     19:00 · Messages / Natsumi

**natsumi:** Studio key next week. I have found help with the move already, so this is news rather than a favor.

**asahi:** I am glad it is happening. I know I made it harder to ask me for things.

**natsumi:** Yes. I am not saying it to keep punishing you. I am telling you where we are.

**natsumi:** We can still get lunch. I am allowed to make a boundary without deciding you are a bad person.

**system:** Saved note: Natsumi has arranged the move without me. We still talk. She has stopped building her plans around my answer, and I know why.

**Later:** `relationship`.

### The name of this
ID: `relationship` · THU  24 DEC     20:00 · Messages / Mizuki

Major decision: **D07**

**mizuki:** Misaki asked who i was smiling at. said a friend

**asahi:** Natsumi's asked about you too.

**mizuki:** i like you, Asahi. as more than that. there. sent it

**mizuki:** you don't have to say it back. would rather know if we're imagining different things. might need a day though

**mizuki:** even if this is where we stop. i'm glad we met

- **Reply:** I like you too. More than friends. Can we try this? → `romantic_date`; records {'relationship_mode': 'romantic'}.
- **Reply:** I care about you. For me it is friendship. Sorry. I should say that clearly. → `friend_activity`; records {'relationship_mode': 'friends'}.
- **Reply:** I think we want different things. I should say goodbye instead of keeping you waiting. → `amicable_goodbye`; records {'relationship_mode': 'separated', 'resolution': 'amicable'}.

### A date, with a declared budget for awkwardness
ID: `romantic_date` · SAT  26 DEC     19:00 · Messages / Mizuki

**mizuki:** changed my shirt twice. you can't even see it. anyway. hi

**asahi:** Hi. Got dinner. Actual plate and everything.

**system:** Date transcript: We compare the views from our windows, put dinner beside the call, and start the same short film. I hear her laugh before I understand the joke.

**mizuki:** you still watching?

**asahi:** Is it meant to be this much corridor?

**mizuki:** oh thank god. thought it was just me

**mizuki:** terrible film. good date though

**system:** They agree to exclusivity and to discuss changes directly. Neither person promises constant availability or access to private accounts.

**Later:** `career_followup`.

### A different invitation
ID: `friend_activity` · SAT  26 DEC     19:00 · Messages / Mizuki

**mizuki:** I needed yesterday to be quiet. I wasn't trying to make you change your answer.

**asahi:** Thank you for telling me. What kind of invitation would feel good now?

**mizuki:** A game. No pretending the conversation never happened, no trying to turn friendship into a trial period.

**system:** Saved screenshot: two lanterns beside the safe bank. We played as friends, after saying that was what we both wanted.

**mizuki:** There is still a lot about my day I want to tell you. That was true before I knew what to call this.

**asahi:** I would like to keep hearing it. I will ask about the parts you want to share.

**mizuki:** Good. Also, I have finally learned which stones are safe. We are about to become intolerably competent.

**Later:** `career_followup`.

### The print on his wall
ID: `local_dinner` · WED  23 DEC     20:15 · Messages / Natsumi

**natsumi:** Photograph received. The print is nearly level. I am choosing to call that a creative decision.

**asahi:** I checked the wall with a book because I still do not own a spirit level.

**natsumi:** The same book that saved the noodles? Your library has an impressive practical career.

**system:** Dinner messages. Asahi puts the phone down while Natsumi describes the studio. Afterward he sends Mizuki the promised update, instead of trying to conduct both conversations at once.

**natsumi:** Thank you for the evening. You were here. I could tell.

**asahi:** I am trying to make that something people don't have to guess.

**Later:** `relationship`.

### The other side of an honest alternative
ID: `studio_lunch` · WED  23 DEC     12:30 · Messages / Natsumi

**natsumi:** I kept thinking about how you offered Saturday setup instead of saying you could do everything. Can we do that again with the studio?

**asahi:** Tell me what you need before I invent a heroic answer.

**natsumi:** One lunch break to choose which prints go in first. I will arrange the actual installation with the building. I want your opinion, not all your time.

**system:** She sends a contact sheet. Asahi marks two prints whose large empty spaces he likes; Natsumi rejects one and explains why. A friend asks for his eye rather than his constant availability.

**natsumi:** The installation preview is Friday. I will send the result. We made a useful small plan again.

**Later:** `studio_preview`.

### The room she chose
ID: `studio_preview` · THU  24 DEC     12:10 · Messages / Natsumi

**system:** Photos: a new studio wall, the selected large print hung over a battered table. The picture Asahi suggested and Natsumi chose is visible beside her own work.

**natsumi:** No ladder emergency. I have become dangerously organized.

**asahi:** I like the empty part of the wall. It looks as though you expect to make more things.

**natsumi:** I do. It took me a long time to admit that without apologizing for the space.

**natsumi:** You don't need to be at every event to be in my life. Knowing what you can actually offer has made it easier to ask for the right thing.

**Later:** `relationship`.

### A use she approved
ID: `licensed_update` · SAT  19 DEC     18:00 · Messages / Mizuki & Misaki

**mizuki:** Someone wants to print the guide for a small local event. That is a different use from pinning it in the game, so they asked.

**misaki:** I checked the wording because she asked me to. I have no authority over drawings that are not mine.

**asahi:** Do you want to approve it, decline it, or ask what they are actually printing?

**mizuki:** I asked for the layout and a credit. They sent both. I said yes to this version.

**system:** The approved print event happens without the private client draft. Mizuki sends a photograph of the credited guide; she chose the audience and the use.

**misaki:** These are the boring details people remember when they decide whether they want to work with someone again.

**Later:** `kept_agreement`.

### A collection with a door
ID: `private_update` · SAT  19 DEC     18:00 · Messages / Mizuki

**mizuki:** I cleaned up our little collection. I would like the early work draft removed from the shared view now that the paid version is finished.

**asahi:** Done. The postcard can stay if you still want it here.

**mizuki:** I do. Thank you for asking about the pictures separately. Keeping one thing did not have to mean keeping everything.

**system:** Photos: work draft withdrawn from the shared collection at Mizuki's request. The postcard remains in our private folder.

**mizuki:** It feels like we are learning how to keep something without owning every version of it.

**Later:** `kept_agreement`.

### The permission that is still not there
ID: `boundary_followthrough` · SAT  19 DEC     18:00 · Messages / Mizuki

**mizuki:** I saw the note confirming which posts were removed. I believe you have done what you can about those copies.

**asahi:** I won't ask you to send the next work file as proof we are okay.

**mizuki:** Good. I am not ready to share work drafts again. I can send a picture of my lunch. That is an invitation, not a test of whether you have changed enough.

**system:** Asahi accepts the limited photo exchange. The public workshop remains canceled, the shared work folder stays closed, and the conversation continues somewhere neither person has to pretend nothing happened.

**asahi:** Your lunch has a very confident amount of cabbage.

**mizuki:** It is the only project I am prepared to have critically reviewed tonight.

**Later:** `kept_agreement`.

## Act 6: The Next Hello

### The work that continued
ID: `career_followup` · TUE  05 JAN     18:30 · Work / Hoshino Studio

**team:** January planning. Your work record changes the next assignment; it does not disappear because a relationship has become important.

**asahi:** I have put my existing commitments in the availability sheet. I want to say what time is real before we fill it.

**team:** Good. We can build around a clear answer. We cannot build around someone silently hoping the week will get longer.

**system:** Saved note: I opened the work thread before answering another invitation. I want to know which hours are mine to offer.

**team:** Either way, the next week is not a verdict on the rest of your career. Finish the piece that is yours, ask where you need help, then go home.

**Later:** `supervised_review`.
- When {'career_offer': True}: `project_meeting`.

### A small project of his own
ID: `project_meeting` · WED  06 JAN     18:30 · Work / Hoshino Studio

**team:** The little print layout is yours to plan. You can ask for a review on Wednesday. I am not assigning you the right to stop sleeping.

**asahi:** Wednesday review, Friday delivery, two evenings unavailable. I have checked before offering the dates.

**team:** That is a project plan. Surprisingly rare and very welcome.

**system:** Draft after work: I have a little project of my own to plan. I want to tell you about it. I am excited in a way I had almost forgotten to be.

**asahi:** I used to think being wanted meant being immediately useful. I like having something to tell you after I finish it.

**Later:** `mizuki_offer`.

### The task he still has
ID: `supervised_review` · WED  06 JAN     18:30 · Work / Hoshino Studio

**team:** Review finished. The missing files are back where the next person can find them.

**asahi:** I know the small project is assigned elsewhere. I am not asking you to reopen it as proof you have forgiven me.

**team:** Thank you. There will be another project. This one needed a plan at the time.

**system:** Saved note: The review is done. The project went to someone else when it needed a plan. I cannot finish a different task and call that week undone.

**asahi:** I did something useful today. It wasn't the impressive version I imagined, but it happened.

**Later:** `mizuki_offer`.

### Her answer to her own question
ID: `mizuki_offer` · FRI  08 JAN     20:15 · Messages / Mizuki

Major decision: **D08**

**mizuki:** I accepted the illustration job. Two days a week in Otaru, the rest from here. I thought about it for a long time before answering.

**asahi:** How do you feel now that you have said yes?

**mizuki:** Glad. Frightened. Worried you will hear it as a decision about you instead of work I want to try.

**mizuki:** I am not asking you to choose it for me, or to prove you care by moving. I am asking whether the life I have chosen and the life you have can make room for what we are.

**system:** Calendar: her workdays beside mine. She has already chosen the job. The question she asked me is what I can offer alongside it.

**mizuki:** I don't want a beautiful answer that becomes somebody else's exhaustion. What can we actually offer?

- **Reply:** Let us keep our separate work and agree a realistic next plan together. I want us to choose what fits. → `future_agreed`; records {'future_plan': 'workable', 'ritual_renewed': False}.
- **Reply:** If you still want our small ritual, I want to give it a place in that plan, with room to cancel and return. (requires {'ritual': True, 'ritual_kept': True}) → `future_agreed`; records {'future_plan': 'workable', 'ritual_renewed': True}.
- **Reply:** I cannot promise the next step yet. Would you choose an honest uncertain future with me, without waiting on a hidden promise? → `open_conversation`; records {'future_plan': 'explicitly_undecided'}.
- **Reply:** I respect your choice. Our needs do not fit, and I would rather end this carefully than ask you to give up the job. → `amicable_goodbye`; records {'relationship_mode': 'separated', 'resolution': 'amicable'}.
- **Reply:** I will promise every weekend, take the extra work and never disappoint anyone again. Please do not ask me to choose. (requires {'work_broken': True}) → `burnout_warning`; records {'future_plan': 'incompatible'}.

### A plan with space around it
ID: `future_agreed` · SAT  09 JAN     19:30 · Messages / Mizuki

**mizuki:** Two planned evenings a month, other messages when we have room, and a travel discussion that includes money and leave. That sounds small until I imagine actually doing it.

**asahi:** My local life stays in the calendar too. So does yours. We don't have to conceal it to make the plan sound devoted enough.

**mizuki:** Yes. And a canceled evening comes with a message, not a debt we collect from each other later.

**system:** Saved note: We both confirmed the arrangement, including the evenings we need for ourselves. I read it again before putting it in Calendar.

**mizuki:** My first workday is Tuesday. I would like to tell you about it afterward. I may also be too tired to do anything but send a picture of my shoes.

**asahi:** I look forward to a rigorous review of the shoes, whenever it arrives.

**Later:** `end_distance`.
- When {'visit': 'late'}: `late_arrival`.
- When {'relationship_mode': 'friends'}: `end_friendship`.
- When {'relationship_mode': 'romantic', 'ritual_renewed': True}: `end_secret`.
- When {'meeting_plan': 'completed'}: `end_together`.

### The date becomes today
ID: `late_arrival` · SAT  16 JAN     13:55 · Messages / Mizuki

**mizuki:** I am at the exit we agreed. Gray coat. Very serious scarf. Do not confuse me with a vending machine; it has a better pension.

**asahi:** I am still on the platform. I have read this message three times. It has not stopped being real.

**mizuki:** We are allowed to be different in person. We have already agreed that.

**system:** Travel note: January 16. This is the first afternoon we will have stood in the same place. I checked the exit number again, although I know it now.

**mizuki:** You can come over slowly. I am not going anywhere for these next three minutes.

- **Reply:** Can I offer a hug when I get there? A hello is enough if you prefer. → `late_afternoon`; records {'greeting': 'offered hug'}.
- **Reply:** Let us start with hello. I would like to walk beside you for a while. → `late_afternoon`; records {'greeting': 'quiet hello'}.

### A chair without a screen between it
ID: `late_afternoon` · SAT  16 JAN     19:30 · Messages / Mizuki

**mizuki:** Home. I kept the receipt for the tea. Apparently that is the sort of person I am.

**asahi:** Someone who may need to return a deeply unremarkable beverage?

**mizuki:** Someone who liked the afternoon and wants a small, silly thing that proves it happened.

**system:** Saved note: We asked before touching. We got lost without making it a competition about whose map was wrong. We sat beside a wall and talked until our tea went cold. There is a photograph of our cups now.

**mizuki:** I liked the person who took a minute to answer. I already liked the person who could edit the answer before sending it. I am glad I have met both.

**asahi:** I am glad we let the day be a day instead of a verdict.

**Later:** `end_distance`.
- When {'relationship_mode': 'friends'}: `end_friendship`.
- When {'relationship_mode': 'romantic', 'ritual_renewed': True}: `end_secret`.
- When {'meeting_plan': 'completed'}: `end_together`.

### A question without a hidden yes
ID: `open_conversation` · SAT  09 JAN     19:30 · Messages / Mizuki

**mizuki:** I can choose uncertainty. I cannot choose a waiting room where you know the answer and need me not to ask.

**asahi:** I do not know. I want you to have that whole answer, even though it gives me less control over what happens next.

**mizuki:** Then no exclusivity promised by silence, no trip treated as a test, no saying "soon" when we mean "I hope."

**system:** Saved note: We agreed to leave the future open. We changed the plans that were still ahead of us together. I am trying to hear the whole answer we gave.

**mizuki:** We can keep an occasional ordinary message if we want. Either of us can also say that is not enough. This is not a promise to stay unchanged until one of us gets brave.

**Later:** `end_open`.

### The answer he has used before
ID: `burnout_warning` · SAT  09 JAN     19:30 · Messages / Mizuki

**mizuki:** You promised overlapping weekends before. Work did not get smaller because you wanted it to, and neither did the distance.

**asahi:** I can try harder.

**mizuki:** You already tried harder. People stayed late, plans collapsed, and you stopped telling me when you were tired because it sounded less devoted.

**mizuki:** I am offering a smaller plan. We can keep our jobs, have evenings apart, and decide what time is real. I am not asking you to earn me by becoming less of a person.

**system:** Saved note: She offered fewer promises and enough room to keep them. I recognized the answer I had used when two plans needed the same afternoon.

- **Reply:** You are right. I will choose the smaller plan and tell people what I cannot do. → `future_agreed`; records {'future_plan': 'workable', 'ritual_renewed': False}.
- **Reply:** I refuse to reduce any promise. I expect both of us to keep going like this. → `end_burnout`; records {'relationship_mode': 'separated', 'resolution': 'burnout'}.

### The conversation without a villain
ID: `amicable_goodbye` · SAT  09 JAN     19:30 · Messages / Mizuki

**mizuki:** I wanted another answer. I can still hear that this is the real one.

**asahi:** I don't want to turn the things you need into faults because I can't make them fit mine.

**mizuki:** Then let's not make a final promise to talk every day. I need some room to be sad without treating the quiet as a failure.

**asahi:** I can do that. Would you like the shared collection kept private, or removed from the shared view?

**mizuki:** Private for now. I will decide what I want to keep later. Thank you for asking instead of deciding it is more poetic to delete everything.

**system:** Saved note: We canceled the plans still ahead of us. I kept the photographs we agreed I could keep. The evenings that happened do not become mistakes because this is the last one.

**Later:** `end_goodbye`.

### A Place for Us
ID: `end_together` · SAT  20 FEB     19:30 · Messages / Mizuki

**system:** February. A confirmed next visit sits beside two work schedules in Calendar. The first meeting is a saved photograph, not a promise still waiting to be tested.

**mizuki:** I finished my first month. I drew a window today and did not think of it as an audition for the rest of my life.

**asahi:** I bought a second mug. I am not presenting it as a lease agreement.

**mizuki:** Good. I would like to use it. Then I would like to go back to the work I chose, and come again when we have agreed.

**asahi:** We can build something without pretending distance has become easy.

**mizuki:** I know what your hello sounds like in a room now. I still look forward to the one on the screen.

**system:** Saved note, April: She used the second mug. One evening I had work to finish, so she went out while I finished it. We ate dinner afterward and talked about the different afternoons we had had. I like that we are learning how to come back to each other without leaving everything else behind.

**mizuki:** Train ticket saved. Your mug is still ugly. See you Saturday.

**Ending:** Good / together.

### Same Sky, New Plan
ID: `end_distance` · SAT  20 FEB     19:30 · Messages / Mizuki

**system:** February. They have not met. Calendar contains an agreed March travel discussion and two planned evenings, with room around both.

**mizuki:** I am not going to pretend the screen is the same as sitting beside you. I am also not going to call what we have unreal because it happens here.

**asahi:** We can want the meeting without treating every week before it as wasted time.

**mizuki:** Tuesday was not wasted. You talked me through saving the wrong version of a file and then admitted you had done the same thing at work.

**asahi:** A relationship founded on version control errors. Very modern.

**mizuki:** A relationship with people in it. We have made a plan we can check, change, and actually keep.

**system:** Saved note, April: We had the March conversation. We checked leave and money before circling dates. Until then there are planned calls, ordinary messages, and pictures of lunches neither of us would show anyone else. I still wish she were nearer. I also know when we are going to talk next.

**mizuki:** A picture of my shoes, as promised. Terrible commute. Tell you about it after dinner?

**Ending:** Good / distance.

### Still in the Party
ID: `end_friendship` · SAT  20 FEB     19:30 · Messages / Mizuki

**mizuki:** Daichi has made a party description so strict it may qualify as a short constitution.

**asahi:** Does it mention waiting at bridges?

**mizuki:** Twice. I think you have influenced public policy.

**system:** The next invitation is explicitly a friend activity. The friendship plan includes room for new relationships and for evenings when either person is elsewhere.

**mizuki:** I was afraid friendship would mean keeping the conversation but removing every interesting part. It doesn't feel like that now.

**asahi:** We still know things about each other that matter. We can keep learning without waiting for the other person to change the answer.

**system:** Saved note, April: We still play. She tells me about work; I send pictures of things I have cooked badly. There are new people in both of our lives. I am glad we said friendship clearly enough that neither of us has to spend these evenings waiting for a different answer.

**mizuki:** New player at the bridge. Come on. Let's show them where to wait.

**Ending:** Neutral / friendship.

### Thank You for the Time
ID: `end_goodbye` · SAT  20 FEB     19:30 · Messages / Mizuki

**system:** February. The final exchange is reopened once, deliberately. Canceled plans are labeled canceled; memories are not relabeled mistakes.

**mizuki:** I am doing okay. Not beautifully every day. But okay. I wanted you to know that without turning it into another conversation we have to keep going.

**asahi:** I am glad. I have been putting things on my wall. Natsumi says the apartment looks less like a place I am waiting to leave.

**mizuki:** That sounds like something good.

**asahi:** Knowing you was something good too. Even though this is where it ends.

**mizuki:** Yes. Thank you for the time, Asahi. I mean the ordinary bits as well.

**system:** Saved note, April: I kept one photograph. Some evenings I look at it, and some I forget it is there. Work still needs doing. Natsumi still has news when we talk. I miss Mizuki without having an answer to send her. Tomorrow I have lunch with someone who is here.

**system:** Messages: conversation archived. The photographs we chose to keep remain private.

**Ending:** Neutral / goodbye.

### Words Left Unsaid
ID: `end_unsaid` · THU  17 DEC     19:45 · Messages / Mizuki

**mizuki:** I gave you another opportunity to hear the boundary. You answered by explaining why it should not apply to you.

**mizuki:** I am ending this. Please do not contact my sister, my client, or our game friends to ask them to change my mind.

**system:** Unsent note: I want to send another explanation.

**system:** Saved note, not a message sent to her: wanting to be understood is not permission to keep entering a conversation someone has ended.

**system:** Pending plans are canceled. Past choices remain in their history, and the last refusal stays in the thread beside the offered repair.

**system:** Unsent note, April: I wrote an apology that names what I did. I did not send it through another account. She asked me to stop contacting her. I can learn to hear that sentence without asking her to come back and watch me learn it.

**system:** Saved note: Her last message is still clear. I closed the composer.

**Ending:** Bad / unsaid.

### Nothing Left to Give
ID: `end_burnout` · SAT  20 FEB     19:30 · Messages / Mizuki

**system:** The following weeks repeat the pattern Asahi chose to preserve: overlapping promises, rushed apologies, and smaller lives built around avoiding the next disappointment.

**mizuki:** I accepted the smaller plan when I offered it. You kept replacing it with a bigger promise, then asking me to live with what was left.

**asahi:** I thought devotion meant finding a way to do everything.

**mizuki:** I wanted a person with a life. I do not want to keep becoming the reason you say yes to things you cannot do.

**system:** Saved note: I read the smaller plan she offered again. I had turned down the one arrangement that left us enough time to live inside it.

**system:** Saved note, April: I said no to an extra task before accepting another. Nothing dramatic happened. Someone made a different plan. The project I lost is still someone else's, and Mizuki is still gone. But one person knew which hours they could depend on me for today. I want to get better at that.

**system:** In Calendar, he leaves a Saturday empty without filling it with an apology.

**Ending:** Bad / burnout.

### Maybe, Someday
ID: `end_open` · SAT  20 FEB     19:30 · Messages / Mizuki

**mizuki:** I passed the station today and thought about the plan we didn't make. I wasn't angry. I wanted to tell you the thought was there.

**asahi:** I have those too. I am trying to let them be thoughts instead of promises I write on your behalf.

**mizuki:** I still don't know what this becomes. I do know I don't want to be held in place by an answer neither of us gave.

**asahi:** You are free to make your life. I want mine to keep moving too.

**system:** Saved note: No ticket booked. No promise of exclusivity. We said both things aloud before agreeing to keep an occasional conversation.

**system:** Saved note, April: Some weeks we talk. Some we do not. A rainy window arrived on my screen after a quiet month. I opened it after work and sat with it for a while. There are several things I could say. I want to choose the one I mean.

**mizuki:** Same rain here. How has your ordinary day been?

**Ending:** Open / open.

### The Everyday Hello
ID: `end_secret` · SAT  20 FEB     19:30 · Messages / Mizuki

**system:** The small ritual was proposed, kept, allowed to pause, and deliberately renewed. Today the final activity is not a grand announcement. Both people have kept an ordinary evening for it.

**mizuki:** Ready?

**asahi:** I have opened the window photo, found the page, and checked that the game is not updating. This is a rigorous cultural program.

**mizuki:** We only need the part we actually started with. The rest can be there because we like it.

**system:** Party transcript: they carry two lanterns to the old bridge. This time there is no newcomer to guide. Mizuki stops on the safe bank, and Asahi waits beside her until they both choose to go on. (only when {'path': 'guild'})

**system:** Reading transcript: they send each other one page and a window photo. Mizuki reads the same paragraph twice while Asahi eats. The quiet has no work to do except be shared. (only when {'path': 'private'})

**system:** Call transcript: a tap runs in Tokyo and a cupboard closes in Sapporo. Mizuki says "dishes" before stepping away. Asahi finishes dinner. When she returns, they pick up the same ordinary evening. (only when {'path': 'lives'})

**mizuki:** Tell me one thing that would not make a good story.

**asahi:** I put the right lid on the right pan. On the first attempt.

**mizuki:** Mine is that I had an ordinary Tuesday at a job I wanted. Nothing collapsed. I drew a window. I came home.

**asahi:** I would like to hear about another one.

**mizuki:** That is what I wanted to ask you too.

**system:** Saved note, April: We still keep our small thing when we can. Last Saturday she was too tired. This Saturday I was late back from the shop. We said so, and found another evening. I remember that first random garden run and how little I knew about the person beside the other lantern. I want to hear what she did on Tuesday.

**Ending:** Secret / everyday.

