# The Next Hello: complete branching first draft

Six acts, three activity paths, eight endings. This is the full playable first draft, with every authored line and choice; production pacing and final art remain to be reviewed.

Read one branch at a time. Conditions below are authoring notes and never appear as scores in the interface. All scenes are presented as private messages, transcripts, photographs or saved notes.

## Act 1: A Chance Encounter

### 01 / A chance encounter
ID: `invite` · FRI  23 OCT     23:08 · Messages / Mizuki

**system:** Random matchmaking pairs you with mizuki for a garden run. You have never met.

**mizuki:** hey :) first time in this garden?

**mizuki:** i can take the lantern if u watch the path?

- **Reply:** Deal. Slow and steady. I'd like to see the garden. → `bridge`; records {'role': 'lookout'}.
- **Reply:** I'll take the lantern. You can stop me walking into things. → `bridge`; records {'role': 'lantern'}.

### The crooked bridge
ID: `bridge` · FRI  23 OCT     23:08 · Messages / Mizuki

**system:** A stone bridge crosses the dark water. A second lantern flickers on the far bank.

**mizuki:** shortcut should be fine lol

**mizuki:** i did fall in last time. should probably mention that

- **Reply:** Let's light the stepping stones. I'll wait for you. → `first_dm`; records {'garden_memory': 'stones'}.
- **Reply:** Want to try the bridge together? We can be damp legends. → `splash`; records {'garden_memory': 'splash'}.

### A small detour
ID: `splash` · FRI  23 OCT     23:08 · Messages / Mizuki

**system:** The bridge folds into the water. Two tiny characters respawn under the same leaf.

**mizuki:** okay. nice leaf though

**system:** You save a screenshot of the two of you under the leaf.

- **Reply:** Next time, we take the stones. Keeping the screenshot though. → `first_dm`; records no new fact.

### A new conversation
ID: `first_dm` · FRI  23 OCT     23:08 · Messages / Mizuki

**system:** Lantern garden screenshot added to Photos. A private message arrives from mizuki.

**mizuki:** thanks for waiting btw. everyone else just runs off

**mizuki:** mizuki. sapporo. brb fighting a noodle lid

- **Reply:** Asahi. Tokyo. Put a book on it. My unread pile finally has a job. → `night`; records {'intro': 'books'}.
- **Reply:** Asahi. Tokyo. lol. Big evening for both of us. → `night`; records {'intro': 'heroic'}.

### A little after eleven
ID: `night` · FRI  23 OCT     23:08 · Messages / Mizuki

Major decision: **D01**

**mizuki:** back. lid defeated :) hi asahi

**mizuki:** i draw for work. six versions of the same window today. needed to look at something else

**mizuki:** you playing again this weekend? or we could do something else. if you want

- **Reply:** Another garden run this weekend? We could play together again. → `guild_agreed`; records {'path': 'guild'}.
- **Reply:** Want to swap window photos? Maybe make something small together. → `private_agreed`; records {'path': 'private'}.
- **Reply:** Want to call sometime? When neither of us is busy. → `lives_agreed`; records {'path': 'lives'}.

### One more party
ID: `guild_agreed` · FRI  23 OCT     23:08 · Messages / Mizuki

**mizuki:** yes. maybe open a small party? as long as we get to play together.

**system:** Saturday's garden run is in Calendar. You and Mizuki will open a public party together.

**Later:** `guild_plan`.

### Two windows
ID: `private_agreed` · FRI  23 OCT     23:08 · Messages / Mizuki

**mizuki:** i'd like that. two cities, two windows. maybe a little illustrated postcard?

**mizuki:** just between us for now. rough work makes me shy.

**system:** A private photo exchange is in Calendar. Mizuki will send her desk photo tomorrow.

**Later:** `private_photo`.

### Beyond the username
ID: `lives_agreed` · FRI  23 OCT     23:08 · Messages / Mizuki

**mizuki:** a call sounds good. sunday afternoon? my sister's helping me move a shelf saturday.

**mizuki:** fair warning: my everyday life contains a lot of arguing with furniture.

**system:** Sunday's call is in Calendar. Tomorrow, check your work schedule before confirming.

**Later:** `lives_work`.

## Act 2: A Place in the Day

### 02 / A garden for everyone
ID: `guild_plan` · SAT  24 OCT     16:42 · Messages / After Hours

**mossbyte:** hey, Daichi here. mossbyte in game :) got a few ppl asking to join. could you two take separate groups?

**mizuki:** aw i wanted to play with you. could we do one small group?

- **Reply:** One small group. We'll show them the safe route together. → `guild_event`; records {'guild_plan': 'small group'}.
- **Reply:** Let's make a route guide tonight, then let someone else lead. → `guild_guide`; records {'guild_plan': 'route guide'}.

### Lanterns in the rain
ID: `guild_event` · SAT  24 OCT     16:42 · Messages / After Hours

**system:** You and Mizuki bring three new players through the garden. At the bridge, everyone waits.

**mizuki:** look at that. a whole party that doesn't leave anyone behind.

**mossbyte:** I'm keeping the group small next week too. Thanks for saying something.

**Later:** `guild_callback`.

### A map with a warning
ID: `guild_guide` · SAT  24 OCT     16:42 · Messages / After Hours

**system:** You mark safe stones while Mizuki draws a tiny skull on the crooked bridge. A newcomer volunteers to guide.

**mizuki:** our first joint publication. please credit the skull artist.

**mossbyte:** guide's up. skull credited lol. you two go play

**Later:** `guild_callback`.

### 03 / The next invitation
ID: `guild_callback` · TUE  27 OCT     20:16 · Messages / Mizuki

**mizuki:** daichi asked before adding people this time. i think we started something.

**mizuki:** next saturday, same garden? i'd like a little time with just you after.

**system:** The conversation stays in your message history. There is another evening ahead, when you choose to continue.

**Later:** `party_evening`.

### 02 / The mug has a new job
ID: `private_photo` · SAT  24 OCT     16:42 · Messages / Mizuki

**system:** Mizuki shared a private desk photo. Read this description or open Shared attachments in Messages: pens in a mug, a half-finished illustration on a laptop, rain against the window.

**mizuki:** window attempt seven. application deadline monday. please keep this one between us.

- **Reply:** Want quiet company while we make the postcard? We can leave it unfinished. → `private_event`; records {'collaboration': 'quiet company'}.
- **Reply:** Let's move our postcard session until after your deadline. I'll send my photo now. → `private_rescheduled`; records {'collaboration': 'rescheduled'}.

### A room in two cities
ID: `private_event` · SAT  24 OCT     16:42 · Messages / Mizuki

**system:** A song plays softly in the background. You send your rainy Tokyo window; Mizuki sends a small line drawing in return. Neither of you posts it.

**mizuki:** i finished the corner i was stuck on. quiet company works, apparently.

**system:** A private postcard joins Shared attachments. Mizuki keeps working on her application.

**Later:** `private_callback`.

### Room to finish
ID: `private_rescheduled` · SAT  24 OCT     16:42 · Messages / Mizuki

**mizuki:** thanks. tuesday evening? i want to do this when i'm not watching a deadline.

**system:** You share the Tokyo window privately. The postcard session moves to Tuesday; tonight Mizuki works on her application.

**mizuki:** your window has good rain. keeping that photo.

**Later:** `private_callback`.

### 03 / After the deadline
ID: `private_callback` · TUE  27 OCT     20:16 · Messages / Mizuki

**mizuki:** submitted. i checked the attachment three times. four if we're being honest.

**mizuki:** can i show you the finished illustration? and i found a short story we could read together.

**system:** The conversation stays in your message history. There is another evening ahead, when you choose to continue.

**Later:** `illustration_evening`.

### 02 / Making room
ID: `lives_work` · SAT  24 OCT     16:42 · Messages / Hoshino Studio

**team:** Monday's handoff needs a check. You can finish Saturday afternoon or take the Sunday review. Both are fine; tell me which.

**system:** Mizuki's proposed call is Sunday afternoon. Friday work is available; taking Sunday means explicitly rescheduling the call.

- **Reply:** I'll do the Saturday check so Sunday stays free. → `lives_call`; records {'work': 'Saturday handoff', 'commitment': 'Sunday / Call with Mizuki (confirmed)'}.
- **Reply:** I'll take Sunday. I'll ask Mizuki about another call time before confirming. → `lives_reschedule`; records {'work': 'Sunday review', 'commitment': 'Monday / Call with Mizuki (confirmed)'}.

### A shelf, assembled
ID: `lives_call` · SUN  25 OCT     15:00 · Messages / Mizuki

**system:** Sunday afternoon. A call transcript opens after your completed Saturday handoff.

**mizuki:** can you hear me? sorry. my sister says hello. and that i put the shelf upside down.

**asahi:** I'd like the shelf's side of the story.

**mizuki:** it's staying silent. clever shelf.

**system:** You talk about ordinary weekends, and what a visit might look like. No travel is booked.

**Later:** `lives_callback`.

### A different evening
ID: `lives_reschedule` · MON  26 OCT     19:30 · Messages / Mizuki

**asahi:** I chose the Sunday review. Could we call Monday evening instead? I'd like to give it proper time.

**mizuki:** monday works. my sister will have gone home, so you'll miss the shelf assembly commentary.

**system:** Monday evening. After the work review, you and Mizuki talk over dinner on a call. No introduction to Misaki happened this time.

**mizuki:** tell me about tokyo on a normal day. not the postcard version.

**Later:** `lives_callback`.

### 03 / A possible journey
ID: `lives_callback` · TUE  27 OCT     20:16 · Messages / Mizuki

**mizuki:** if we ever meet, i'd rather have an ordinary afternoon than a perfect itinerary.

**system:** You compare a future leave window and agree to discuss it again. A visit is a possibility, not a promise.

**system:** The conversation stays in your message history. There is another evening ahead, when you choose to continue.

**Later:** `sister_intro`.

### The smallest party
ID: `party_evening` · SAT  31 OCT     19:40 · Messages / After Hours

**mossbyte:** party says FOUR. guy just asked if six was close enough lol

**mizuki:** it does not. i've spoken to mathematics.

**asahi:** Our guide says the bridge is safe if you don't stand on it. A difficult instruction for a bridge.

**mossbyte:** two new ppl are stuck with the lanterns. can you show them?

**mizuki:** only if we actually play together afterward. last week i spent more time explaining the game than playing it.

**mossbyte:** fair enough. closing it after this run. that's everyone

**system:** You light the first stepping stone. A new player waits for your second lantern instead of running ahead.

**mizuki:** hey he waited for us :)

- **Reply:** One for them, then one just us? → `after_game`; records {'ritual': True}.
- **Reply:** Can we just play tonight? Guide another day. → `party_rest`; records {'ritual': False}.

### After everyone leaves
ID: `after_game` · SAT  31 OCT     21:15 · Messages / Mizuki

**mizuki:** he actually closed the party lol

**asahi:** Someone give him a badge.

**mizuki:** don't. he'll organize a ceremony

**mizuki:** liked that last run. just us

**asahi:** Me too.

**mizuki:** next saturday? just a short one if we're around

**system:** Calendar: an optional Saturday check-in. Either person can cancel by saying so.

**mizuki:** and if we're not around that's fine. don't want to make it homework

**Later:** `natsumi_invite`.

### An evening that belongs to us
ID: `party_rest` · SAT  31 OCT     21:15 · Messages / Mizuki

**mizuki:** i didn't know i was tired until we said no to the extra run.

**asahi:** Daichi sent a picture of four empty party slots. I think he is learning restraint.

**mizuki:** good for him. better for us.

**mizuki:** can we just leave next saturday open? liked tonight. don't want to promise every week yet

**asahi:** We can let it be one nice evening.

**mizuki:** thanks. i'll ask when i'm around :)

**system:** You leave Saturday open. The next invitation will require a new agreement.

**Later:** `natsumi_invite`.

### The corner she kept
ID: `illustration_evening` · SAT  31 OCT     20:10 · Messages / Mizuki

**mizuki:** finished it! window still crooked. calling that a style choice

**asahi:** That is also how I describe my laundry pile.

**mizuki:** they accepted the sample. keep opening the email to check lol

**system:** In the attached drawing, one small rectangle of warm light sits beneath a gray sky. Your rainy-window photo is beside it in Photos.

**mizuki:** found that train story in a used bookshop. want to read a page with me?

**asahi:** Out loud? My dramatic voice is mostly my normal voice with worse posture.

**mizuki:** lol you don't have to perform it. just thought it'd be nice to read together

- **Reply:** A page and a window photo on Saturdays, when we can? No catching up required. → `reading_evening`; records {'ritual': True}.
- **Reply:** Let us just read this page tonight. We can decide next time when it comes. → `reading_once`; records {'ritual': False}.

### Two bookmarks
ID: `reading_evening` · SAT  31 OCT     21:00 · Messages / Mizuki

**mizuki:** the line i kept: the platform wasn't where she was going, but it was somewhere she could breathe.

**asahi:** I keep thinking she could also just go home. Then I remember the first apartment I rented in Tokyo.

**mizuki:** bad apartment?

**asahi:** Fine apartment. Very good walls. Nothing on either side I recognized yet.

**mizuki:** mine had a kettle that clicked so loudly i thought someone had come in. i liked the sound anyway.

**asahi:** A page and a window, then. Small enough for a bad week.

**mizuki:** yeah. can skip if we're tired though? don't want book homework

**system:** Saturday's optional reading check-in appears in Calendar. The finished drawing remains private.

**Later:** `natsumi_invite`.

### One page is enough
ID: `reading_once` · SAT  31 OCT     21:00 · Messages / Mizuki

**mizuki:** i reached the bottom. the character finally took her own train. character development through public transport.

**asahi:** I have eaten dinner while we read. That may also count as development.

**mizuki:** what did you have?

**asahi:** Leftover curry. Put too much rice on. Still ate it.

**mizuki:** lol. it's nice knowing what you had for dinner. makes you seem closer

**system:** You close the attachment without making a standing appointment. Tonight's conversation stays in history.

**Later:** `natsumi_invite`.

### A shelf with witnesses
ID: `sister_intro` · SAT  31 OCT     15:20 · Messages / Mizuki

**mizuki:** misaki asked if you are the person who recommended putting a book on the noodle lid.

**asahi:** The book gets all the credit. I just own it.

**mizuki:** she says thanks. shelf instructions weren't heavy enough. okay if i add her to a chat?

**mizuki:** or later's fine. promise this isn't an interview lol

- **Reply:** Sure. Tell her I take no responsibility for load-bearing books. → `family_chat`; records {'sister_contact': True}.
- **Reply:** Another time? I would like to know you a little better first. → `ordinary_call`; records {'sister_contact': False}.

### Three people and a shelf
ID: `family_chat` · SAT  31 OCT     15:30 · Messages / Mizuki & Misaki

**misaki:** Hi Asahi. You're the book-on-noodles person?

**asahi:** The book did most of the work.

**misaki:** OK. I'll thank the book.

**mizuki:** the team is a paperback with soup on it.

**misaki:** I'm moving next month. She's been helping every weekend. If she falls asleep mid-game, that's why.

**mizuki:** i can explain my own schedule, you know.

**misaki:** Fair. I'll stop. Please keep the shelf photo here. Mum will never let me hear the end of it.

**asahi:** Understood. Private archive, questionable carpentry.

**Later:** `ordinary_call`.

### What happens between calls
ID: `ordinary_call` · SAT  31 OCT     20:00 · Messages / Mizuki

**mizuki:** i was trying to think of something to tell you. bought detergent. that's about it

**asahi:** Renamed a file six times. Big day here too.

**mizuki:** could call anyway? don't have to do anything

**asahi:** I'd like that. Need to wash up though. If I go quiet it's the dishes.

**mizuki:** lol good. otherwise i would sit here wondering what i said

- **Reply:** Saturdays, if we can? "Dishes" means back in a bit. → `small_call`; records {'ritual': True}.
- **Reply:** Tonight, yes. Can we ask each time though? Saturdays get messy. → `call_once`; records {'ritual': False}.

### Dishes
ID: `small_call` · SAT  31 OCT     21:00 · Messages / Mizuki

**system:** Call transcript. A tap runs in Tokyo; a cupboard closes in Sapporo.

**mizuki:** brb dishes

**asahi:** I'll be here. Trying to find the lid that fits this pan.

**system:** Three minutes later, Mizuki returns to describe a mug whose handle gets hot. Asahi admits he owns a pan lid with no matching pan.

**mizuki:** i don't know why this is nice.

**asahi:** Don't mind it. Nice just hearing you there.

**mizuki:** same. saturday again if we're both around? just say if you're busy

**Later:** `natsumi_invite`.

### A plan for tonight
ID: `call_once` · SAT  31 OCT     21:00 · Messages / Mizuki

**mizuki:** tonight works :) let's sort next time out later

**asahi:** My calendar is mostly guesses. I'm trying to label them.

**mizuki:** mine includes a box called "probably tired." it is the most accurate one.

**system:** You eat dinner with the call open. Neither person fills every silence. When Mizuki says she wants to draw alone, the call ends without an argument.

**mizuki:** liked this :) gtg draw for a bit. talk later?

**Later:** `natsumi_invite`.

## Act 3: What We Carry

### The invitation that was already there
ID: `natsumi_invite` · WED  04 NOV     18:15 · Messages / Natsumi

Major decision: **D02**

**natsumi:** Sunday. Prints. You. Still coming? I FINALLY found hooks that fit.

**asahi:** The famous hooks. I was starting to think they were a metaphor.

**natsumi:** They were a week of my life. Please respect the medium.

**system:** Calendar: the showcase overlaps with the Sunday afternoon Mizuki offered for a longer session. Both people are waiting for an answer.

**natsumi:** Tell me now if you can't. I can find someone. Five minutes after we open is too late.

**natsumi:** And stay for a bit, yeah? I want my friend there. You can put the ladder down.

- **Reply:** I said I would be there. I will keep Sunday and ask Mizuki for another time. → `showcase`; records {'friend_plan': 'kept', 'commitment': 'Sunday / Natsumi showcase; Mizuki rescheduled'}.
- **Reply:** Can I hang the prints Saturday and stop by briefly Sunday? Would that help? → `showcase_setup`; records {'friend_plan': 'renegotiated', 'commitment': 'Saturday setup / Sunday brief showcase'}.
- **Reply:** I can do both. Keep me on the full Sunday shift; I will make the other plan fit. → `showcase_missed`; records {'friend_plan': 'missed', 'overpromise': True, 'commitment': 'Two knowingly overlapping Sunday promises'}.

### The person on this side of the screen
ID: `showcase` · SUN  08 NOV     16:40 · Messages / Natsumi

**system:** In Photos: Natsumi on a step stool, one print held sideways. Caption: "Do not let the artist measure things."

**natsumi:** We sold two. Two whole people walked in and wanted something I made in their houses.

**asahi:** Three, if your mother is allowed to buy the same print twice.

**natsumi:** She is. I run a generous institution.

**natsumi:** Glad you stayed. You looked about a mile away when you came in. Then you were here.

**system:** Mizuki's message arrives after the showcase: "Thanks for moving our plan instead of disappearing from one. How did it go?"

**natsumi:** Tell her hi. Now help me get these stupid hooks back out.

**Later:** `privacy_request`.

### The alternative that happened
ID: `showcase_setup` · SUN  08 NOV     12:20 · Messages / Natsumi

**natsumi:** Saturday setup was the right call. I could sleep last night instead of arguing with the hanging wire.

**asahi:** That is the first positive review of my knot work.

**natsumi:** Thanks for coming back today too. Half an hour worked. I just needed to know.

**system:** In the photo Natsumi sends, your jacket is visible behind the first visitor. Later, you join Mizuki at the time you agreed together.

**natsumi:** Kept a print for you. Your walls are depressing me.

**asahi:** My walls are frightened and grateful.

**Later:** `privacy_request`.

### An empty square on the floor
ID: `showcase_missed` · SUN  08 NOV     18:30 · Messages / Natsumi

**natsumi:** I waited for forty minutes before asking the shop owner to help. I couldn't leave the table.

**asahi:** I lost track of the other session. I thought I could get across town faster.

**natsumi:** You knew the times clashed. You could've said no. I thought you were coming.

**system:** The showcase goes ahead without you. Its photograph arrives after closing; someone else stands where your ladder was meant to be.

**natsumi:** Can you pick up the boxes tomorrow? Please check first. I can't do this twice.

- **Reply:** Yes. Send me the collection time. I will decline the other plan before agreeing to this one. → `friend_repair`; records {'friend_repair': True}.
- **Reply:** I am not going to be available. I will pay the delivery fee and stop promising to turn up. → `friend_distance`; records {'friend_repair': False}.

### The boxes
ID: `friend_repair` · MON  09 NOV     19:10 · Messages / Natsumi

**system:** You collect the boxes at the agreed time. Natsumi sends a photo of the empty storage corner.

**natsumi:** Thanks. Boxes are in. Still annoyed about yesterday, but that helped.

**asahi:** I was trying to be available to everyone without telling anyone what I could actually do.

**natsumi:** Well, it was a crap plan. You know that now.

**natsumi:** We're okay. Next time just tell me you can't come. I'll survive.

**system:** She sends a photo of one print leaning against my door. I still need to buy a hook.

**Later:** `privacy_request`.

### A smaller circle
ID: `friend_distance` · MON  09 NOV     19:10 · Messages / Natsumi

**natsumi:** Delivery is arranged. Thank you for paying the fee.

**asahi:** I don't want this to be the end of us talking.

**natsumi:** It doesn't have to be. But I'm not asking you to help with the next event. I need to know I can run it without waiting.

**system:** Natsumi keeps sending occasional ordinary messages. She stops asking you to share responsibility for her work. That change remains true later.

**natsumi:** Go talk to her. Ring me sometime too, okay? I miss the idiot I used to get lunch with.

**Later:** `privacy_request`.

### The picture without permission
ID: `privacy_request` · SAT  14 NOV     20:15 · Messages / Mizuki

Major decision: **D03**

**mizuki:** here's the draft. finally got it far enough to show someone

**system:** Image description: a tram window reflected over a drawing of a small print shop. A client's draft name appears in one corner.

**mizuki:** please don't post this anywhere. client's name is still on it. they haven't announced it yet

**mizuki:** and that includes game chat, okay? i know daichi asked. this file's just for you

**system:** Daichi has asked whether Mizuki might contribute an illustration to a public route guide. Sharing with a group would be publication, not a private compliment.

- **Reply:** Could you make a separate version for the guide? This one stays private. Happy to check the caption with you and Misaki. → `permission_granted`; records {'privacy': 'permission', 'rupture': False}.
- **Reply:** I will keep it private. We can make the postcard just for ourselves. → `private_collection`; records {'privacy': 'private', 'rupture': False}.
- **Reply:** I will post this draft in the public game chat anyway. People should see how good it is. → `privacy_breach`; records {'privacy': 'breach', 'rupture': True}.

### The version she chose
ID: `permission_granted` · SUN  15 NOV     16:00 · Messages / Mizuki & Misaki

**mizuki:** use this one for the guide. client stuff's gone, different window. put my name on it pls :)

**misaki:** Hi Asahi. She asked me to check the caption. Which file are you posting?

**asahi:** Hello properly. I have also been checking that I understand which file is which.

**misaki:** Good. Easy to mix them up.

**system:** You publish only the approved image. The game guide credits Mizuki; the private draft remains in the private message attachments.

**mizuki:** someone wants another drawing. told them maybe after my paid stuff. thanks for letting me answer

**misaki:** She's got a deadline. Another drawing can wait.

**Later:** `approved_workshop`.

### A room she agreed to enter
ID: `approved_workshop` · WED  18 NOV     20:00 · Messages / After Hours

**mossbyte:** right version's up. checked the credit too. we did it ppl :)

**mizuki:** an historic day for file management.

**asahi:** I will try not to let our success change me.

**system:** You and Mizuki run a small drawing-and-route workshop. New players add their own warning symbols to dangerous stones.

**mizuki:** lol the skulls are getting worse. glad i came

**mossbyte:** next one's up to you. won't put you down for it unless you say yes

**Later:** `work_decision`.

### An audience of one
ID: `private_collection` · SUN  15 NOV     16:00 · Messages / Mizuki

**mizuki:** thank you for not making me justify it twice.

**asahi:** Daichi can make the guide without this picture. It is still a good picture if no one else sees it.

**mizuki:** sometimes i forget that. work makes everything feel like a thing that should be posted when it is finished.

**system:** In Messages, the draft remains marked Private. No public workshop is scheduled. Instead, you exchange one unfinished page each.

**mizuki:** your page has a rice stain.

**asahi:** That is a separate collaboration with dinner.

**mizuki:** i like the part you drew before you tried to make it presentable. can we keep that too?

**Later:** `private_second_page`.

### The things that do not get posted
ID: `private_second_page` · WED  18 NOV     20:00 · Messages / Mizuki

**system:** You open a shared call while Mizuki finishes the paid file. The unfinished pages stay in a two-person collection.

**mizuki:** thought i'd feel bad about not posting it. kinda like having a drawing that's just ours

**asahi:** We can open it when we want. Or not.

**mizuki:** exactly. tell me one thing you made today that no one is going to applaud.

**asahi:** A mostly successful lunch. A folder I can actually find things in. This time.

**mizuki:** lol. told someone no today. then burnt the tea. one out of two

**Later:** `work_decision`.

### Where the file went
ID: `privacy_breach` · SUN  15 NOV     16:00 · Messages / Mizuki

**mizuki:** daichi sent me the link. i asked you not to post that file.

**asahi:** I wanted people to see your work. I wasn't trying to hurt you.

**mizuki:** someone downloaded it. the client's name is on it, asahi. i have to email them now

**system:** The public workshop is canceled. Misaki does not join the planning chat. Deleting your message does not remove the copy someone saved.

**mizuki:** please don't contact the client. let me deal with this

**mizuki:** we'll talk later. i can't do both right now

**Later:** `canceled_workshop`.

### The evening that did not happen
ID: `canceled_workshop` · WED  18 NOV     20:00 · Messages / Daichi

**mossbyte:** took it down. asked the guy to delete his copy. can't tell if he did

**asahi:** Can I join the workshop to explain?

**mossbyte:** there isn't a workshop. she canceled. don't put her in front of everyone to explain this

**system:** The game stays available, but the collaborative event does not. You run the garden alone; the route guide uses plain arrows instead of her drawing.

**mossbyte:** she said keep it private. i should've checked with her before pinning it too

**asahi:** I understand that more clearly now.

**mossbyte:** tell her what you've taken down. then give her some room

**Later:** `work_decision`.

## Act 4: The Distance Between Us

### The days have edges
ID: `work_decision` · MON  23 NOV     18:05 · Messages / Hoshino Studio

Major decision: **D04**

**team:** Need final layout checks on the 28th. You're asking for leave, so let's work this out now.

**team:** You can take the check and use January leave. You can ask for a Friday handoff if you finish the draft by Thursday. Or you can tell me you are still deciding.

**asahi:** If I promise Friday and miss Thursday, who has to pick it up?

**team:** Whoever is still here. They have weekend plans too.

**system:** Mizuki has offered the following weekend for an early visit. A completed Friday handoff would make it feasible; accepting the weekend check means proposing a later visit.

**team:** Check your dates and tell me which option. I need to put a name on the sheet.

- **Reply:** I'll finish the draft Thursday and do the handoff Friday. Please confirm the leave before I book. → `work_adjusted`; records {'leave': 'approved', 'work_broken': False, 'work': 'Friday handoff; early December leave approved'}.
- **Reply:** I'll take the weekend check. I'll ask Mizuki about January. → `work_kept`; records {'leave': 'deferred', 'work_broken': False, 'work': 'Weekend check kept; January leave available'}.
- **Reply:** Put me on the weekend check. I'll make the early visit work too. → `work_broken`; records {'leave': 'deferred', 'work_broken': True, 'work': 'Overlapping work and travel promises; leave not approved'}.

### The handoff
ID: `work_adjusted` · FRI  27 NOV     18:00 · Messages / Hoshino Studio

**team:** Draft received Thursday. Friday checks are done. Your leave is approved.

**asahi:** I am still finding errors in files I already checked.

**team:** Put the remaining errors in the handoff notes. We'll check them Monday.

**system:** Calendar records the approved dates. Nothing has been booked for either person yet.

**team:** The January project needs someone to plan the layouts. Interested? Your handoff notes were useful.

**asahi:** Let us talk about the actual workload before I say yes.

**team:** Fine. We'll go through the hours on Monday.

**Later:** `visit_plan`.

### The weekend he stayed
ID: `work_kept` · SAT  28 NOV     18:00 · Messages / Hoshino Studio

**team:** Thanks for the check. You found the missing export before it went out.

**asahi:** I wanted to be somewhere else today. I also agreed to do this.

**team:** Get the January leave request in today. Nothing else is booked yet.

**system:** You send Mizuki the available dates rather than a photograph of a booked ticket. She sends back three evenings she can actually keep.

**team:** Want to run the next review? We can go over the hours first.

**asahi:** Yeah. Let's look at the dates.

**Later:** `visit_plan`.

### Someone else stayed late
ID: `work_broken` · SAT  28 NOV     19:30 · Messages / Hoshino Studio

**team:** You said the check would be done before leaving. It wasn't. Someone else missed their train to finish it.

**asahi:** I thought I could do it on the way. The connection dropped and the export was wrong.

**team:** I am not arguing about the connection. You accepted two plans that needed the same hours.

**system:** Leave is deferred. The early visit is not booked. You complete a supervised handoff on Monday; the optional January project goes to someone else.

**team:** Tell me earlier next time. I could have found cover.

**asahi:** I'll apologize to them. I'll have the corrected handoff ready Monday.

**Later:** `visit_plan`.

### A date is not a feeling
ID: `visit_plan` · SUN  29 NOV     20:10 · Messages / Mizuki

Major decision: **D05**

**mizuki:** so. about coming here

**asahi:** I'd get a hotel. We could just meet for an afternoon?

**mizuki:** yes. want to see you. just a bit scared of planning a whole weekend

**system:** Calendar shows Asahi's confirmed work commitments. A ticket will be booked only after both people have agreed to the visit.

**mizuki:** january works too. or we can wait. please don't buy a ticket just because i brought it up

**mizuki:** what do you want to do?

- **Reply:** Leave's approved. December 5? An afternoon in Sapporo, and I'll get a hotel. (requires {'leave': 'approved', 'rupture': False}) → `early_arrival`; records {'visit': 'early', 'meeting_plan': 'confirmed', 'commitment': '5 December / First Sapporo afternoon'}.
- **Reply:** January 16? Gives us time to sort things out before I come. → `late_anticipation`; records {'visit': 'late', 'meeting_plan': 'confirmed', 'commitment': '16 January / First Sapporo afternoon'}.
- **Reply:** Could we keep this online for now? I still want to know you. Just not ready to book a trip. → `online_weekend`; records {'visit': 'online', 'meeting_plan': 'postponed', 'commitment': 'Online for now; travel discussion in February'}.

### The last three minutes
ID: `early_arrival` · SAT  05 DEC     13:57 · Messages / Mizuki

**system:** Travel folder: hotel confirmation, return ticket, and the station exit Mizuki suggested.

**mizuki:** by the exit. gray coat. enormous scarf. tea

**asahi:** There are three gray coats. Think I just waved at a vending machine.

**mizuki:** good choice. very dependable

**asahi:** Wait. Think I see you.

**mizuki:** yeah. hi. sorry i'm still texting. come over?

- **Reply:** Me too. Can I hug you when I get there, if you still want that? → `early_afternoon`; records {'greeting': 'offered hug'}.
- **Reply:** Hello first? We can walk a bit. I'm nervous too. → `early_afternoon`; records {'greeting': 'quiet hello'}.

### A photograph with no landmark
ID: `early_afternoon` · SAT  05 DEC     19:45 · Messages / Mizuki

**mizuki:** home. your receipt's in my pocket lol. why did i keep that

**asahi:** Evidence that I can buy a drink in person, after weeks of describing drinks by text.

**system:** Saved note: We asked before moving closer. Then we walked, took a wrong turn, and found a shop where neither of us knew what to order. I liked hearing her decide out loud.

**mizuki:** sorry i went quiet so much. easier to type than talk sometimes

**asahi:** I was trying not to explain every silence. I liked walking with you.

**system:** A shared photo is added to Photos: two cups on a scratched table, a scarf on the empty chair, no famous landmark.

**mizuki:** could do that again. just an afternoon. maybe longer next time?

**Later:** `return_tokyo`.

### A weekend with a future date
ID: `late_anticipation` · SAT  05 DEC     19:45 · Messages / Mizuki

**mizuki:** the station was full today. i caught myself looking for someone i know is not arriving until january.

**asahi:** Is that nice or awful?

**mizuki:** a little of both. i didn't want to send only the nice half.

**system:** Calendar: January 16. In Photos, our pictures still come from separate cities. I keep wondering what we will choose to photograph together.

**mizuki:** i asked for the afternoon off work. approved. have you checked your leave before we buy anything?

**asahi:** Yes. We can compare confirmations instead of treating the tickets like a surprise gift.

**mizuki:** okay good. send me yours and i'll send mine

**Later:** `january_preparation`.

### An afternoon without a ticket
ID: `online_weekend` · SAT  05 DEC     19:45 · Messages / Mizuki

**mizuki:** no station today. i wondered if i would be disappointed all afternoon. then i bought bread and thought i could tell you about that instead.

**asahi:** I would like the bread report.

**mizuki:** extremely detailed. potentially several paragraphs.

**system:** Call transcript: we compare photographs from our kitchens, argue amiably about bread, then play one short garden encounter before dinner.

**mizuki:** i still want to know if we will meet. i can live with not deciding today. i can't live with never being allowed to ask.

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

**mizuki:** i made a list of places. then crossed out half because i was designing an advertisement for my city instead of an afternoon with you.

**asahi:** I would like a place to sit down. Strong contender for first place.

**mizuki:** revolutionary. i can offer several chairs.

**system:** You compare the actual travel confirmation and an agreed hotel. Neither booking changes relationship mode or implies physical intimacy.

**mizuki:** what if we meet and it's weird? still glad we tried. just wanted to say that now

**asahi:** Same. We can figure out what we think afterward.

**Later:** `conflict_check`.

### The question that stays
ID: `distance_agreement` · SAT  12 DEC     20:30 · Messages / Mizuki

**mizuki:** someone asked me if i've met you. i said not yet, then wondered if i was promising something neither of us has promised.

**asahi:** Would "not so far" be more honest?

**mizuki:** less pretty. more honest. i don't mind the distance tonight. i mind not knowing which parts i'm meant to wait for.

**system:** Saved note: We have a plan for February: talk honestly about travel. Until then, the screen is where we meet. I need to know what we are each expecting from it.

**mizuki:** in february can we actually talk about dates? even if the answer's still no. just don't want to keep guessing

**asahi:** Yeah. I'll make time for it.

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

- **Reply:** You told me not to share it. I did anyway. I'll send you the list of what I removed, and ask first from now on. → `repair_action`; records {'repair': 'action'}.
- **Reply:** Can we talk Thursday? I won't share anything or contact the client while we take a break. → `agreed_space`; records {'repair': 'space'}.
- **Reply:** I was trying to help. I'm done apologizing for it. → `last_repair_offer`; records {'repair': 'refused'}.

### The cost of being reassuring
ID: `promise_repair` · SUN  13 DEC     19:15 · Messages / Mizuki

Major decision: **D06**

**mizuki:** when you said the work weekend and our weekend were both fine, i made plans around it. then someone else stayed late and i canceled an afternoon i could have used.

**asahi:** I wanted to be the person who could make both things work.

**mizuki:** but i cleared the afternoon. i thought you'd checked

**mizuki:** just tell me if you can't. before i turn down something else, please

- **Reply:** I'll check the times before saying yes. If something changes, I'll tell you before I change the plan. → `repair_action`; records {'repair': 'action'}.
- **Reply:** Can we stop planning till Thursday? I keep saying yes before I've checked anything. → `agreed_space`; records {'repair': 'space'}.
- **Reply:** I was busy. I've explained it. I'm not doing this again. → `last_repair_offer`; records {'repair': 'refused'}.

### No villain in the conversation
ID: `expectations_talk` · SUN  13 DEC     19:15 · Messages / Mizuki

Major decision: **D06**

**mizuki:** nothing bad happened. sorry, that sounded ominous

**mizuki:** sometimes i open a message and then go do something. been feeling like i should explain every time

**asahi:** I do stare at the Read thing. More than I'd like to admit.

**mizuki:** sometimes it's literally just the kettle. or misaki calling

**mizuki:** i want to talk to you. just can't always be a whole conversation right then. can that be okay?

- **Reply:** Let's confirm calls. Normal messages can wait till we're free. I'll stop chasing the Read thing. → `repair_action`; records {'repair': 'action'}.
- **Reply:** Could we take a few quiet days and talk Thursday? Need to get used to this without checking every five minutes. → `agreed_space`; records {'repair': 'space'}.
- **Reply:** If you care, you can answer when I'm waiting. That's what I need. → `last_repair_offer`; records {'repair': 'refused'}.

### Thursday means Thursday
ID: `agreed_space` · THU  17 DEC     19:30 · Messages / Mizuki

**system:** Calendar reminder: Thursday, 19:30. The quiet days we agreed to are over. I want to return when I said I would.

**mizuki:** hi. thursday

**asahi:** Hi. Almost messaged you yesterday. Didn't know what to do with the evening.

**mizuki:** what did you end up doing?

**asahi:** Cooked. Called Natsumi. Did the work I'd been avoiding. Pretty ordinary.

**mizuki:** ordinary sounds good. what did you cook?

**Later:** `repair_action`.

### Something smaller than a speech
ID: `repair_action` · FRI  18 DEC     20:00 · Messages / Mizuki

**system:** Asahi writes the agreement in Notes: confirm shared plans, ask before sharing, and let an ordinary reply arrive without treating its timing as proof of love.

**mizuki:** read it. okay. can we change it if it doesn't work? don't want to make another thing to argue about

**asahi:** Yeah. Say so if it stops working. I will too.

**mizuki:** still a bit upset. i do want to try though

**system:** She sends a cup of tea. I put the photo in our private attachments. The canceled workshop stays off the calendar.

**mizuki:** here is today's cup. the tea was bad. you may tell absolutely no one about my sophisticated taste.

**asahi:** Private archive. Critically important evidence.

**Later:** `kept_agreement`.
- When {'privacy': 'permission'}: `licensed_update`.
- When {'privacy': 'private'}: `private_update`.
- When {'privacy': 'breach'}: `boundary_followthrough`.

### A second chance to hear it
ID: `last_repair_offer` · THU  17 DEC     19:30 · Messages / Mizuki

**mizuki:** waited till thursday. didn't want to leave it how we left it

**mizuki:** i meant what i said. i need you to listen when i say no. and i can't be here every time you want to talk

**mizuki:** if you want to talk about what you can change, i'm willing to listen. if you don't, i'm going to end this here.

**asahi:** You mean that.

**mizuki:** yes. i'm tired, asahi. i can't keep explaining it

- **Reply:** I heard a demand when you were explaining a need. I want to talk about what I can change. → `repair_action`; records {'repair': 'action'}.
- **Reply:** No. I'm not changing this. You need to accept it. → `end_unsaid`; records {'relationship_mode': 'separated', 'resolution': 'refused_repair'}.

### A quiet answer
ID: `kept_agreement` · SUN  20 DEC     21:00 · Messages / Mizuki

**mizuki:** i missed the optional check-in yesterday. i sent a message beforehand and went to bed.

**asahi:** I saw it. I played one run and went out for groceries. The tomatoes were more expensive than my optimism.

**mizuki:** thanks for not making it a thing. i just needed sleep

**asahi:** I missed you. I also managed to have a Saturday. Both survived.

**mizuki:** still up for our usual thing tonight? if you're around

**system:** They look at the small things they have chosen to share, and decide what they want to keep doing.

- **Reply:** Yeah. Keep it when we can. Just say if you're tired. (requires {'ritual': True}) → `natsumi_return`; records {'ritual_kept': True}.
- **Reply:** Tonight is enough. I would rather ask each time than keep a standing ritual. → `natsumi_return`; records {'ritual_kept': False}.

### A friend with her own January
ID: `natsumi_return` · TUE  22 DEC     18:30 · Messages / Natsumi

**natsumi:** I got a little residency for January. Not abroad. Two train stops away. I am still telling everyone as though I have been selected to live on the moon.

**asahi:** The moon has less convenient lunch.

**natsumi:** Exactly. I chose wisely.

**natsumi:** Tell me about her in a minute. Let me have my big news first lol.

**asahi:** Tell me what you are making.

**natsumi:** Bigger prints. I was going to pretend it was a grand artistic decision. Mostly I want to stop apologizing for how much wall they need.

**system:** Natsumi's next offer depends on the showcase agreement. A repaired friendship can support a new invitation; an unrepaired absence does not earn one automatically.

**Later:** `friend_update`.
- When {'friend_plan': 'renegotiated'}: `studio_lunch`.
- When {'friend_support': True}: `friend_confidant`.

### An invitation without a ladder
ID: `friend_confidant` · WED  23 DEC     19:00 · Messages / Natsumi

**natsumi:** Come see it when I get the key. No ladder this time. Just lunch.

**asahi:** I will check the date and answer properly. That sentence is becoming a personality trait.

**natsumi:** Better than disappearing optimistically.

**asahi:** Think I'm in love with her. Don't really know what to do about the distance.

**natsumi:** Ask her. I can listen, but I can't read her mind for you.

**natsumi:** And if you want something different, say it while there is still a conversation to have.

**Later:** `local_dinner`.

### News rather than a favor
ID: `friend_update` · WED  23 DEC     19:00 · Messages / Natsumi

**natsumi:** Got the studio key next week. Already booked help with the boxes. Wanted to tell you anyway.

**asahi:** I am glad it is happening. I know I made it harder to ask me for things.

**natsumi:** Yeah. I booked someone else because I needed it sorted.

**natsumi:** We can still get lunch. You can tell me how to hang the menu straight.

**system:** Saved note: Natsumi has arranged the move without me. We still talk. She has stopped building her plans around my answer, and I know why.

**Later:** `relationship`.

### The name of this
ID: `relationship` · THU  24 DEC     20:00 · Messages / Mizuki

Major decision: **D07**

**mizuki:** misaki asked who i was smiling at. said a friend

**asahi:** Natsumi's asked about you too.

**mizuki:** i like you, asahi. as more than that. there. sent it

**mizuki:** you don't have to say it back. would rather know if we're imagining different things. might need a day though

**mizuki:** even if this is where we stop. i'm glad we met

- **Reply:** I like you too. More than friends. Can we try this? → `romantic_date`; records {'relationship_mode': 'romantic'}.
- **Reply:** I care about you. But for me it's friendship. Sorry. Should've said that sooner. → `friend_activity`; records {'relationship_mode': 'friends'}.
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

**mizuki:** i needed yesterday to be quiet. i wasn't trying to make you change your answer.

**asahi:** Okay. Want to do something, or leave it another day?

**mizuki:** a game? as friends. need you to mean that bit too

**system:** Saved screenshot: two lanterns beside the safe bank. We played as friends, after saying that was what we both wanted.

**mizuki:** anyway. bought a new sketchbook. same paper i always buy. exciting news here lol

**asahi:** Very exciting. What colour this time?

**mizuki:** pink again. obviously. cmon, new player's about to fall in

**Later:** `career_followup`.

### The print on his wall
ID: `local_dinner` · WED  23 DEC     20:15 · Messages / Natsumi

**natsumi:** Photograph received. The print is nearly level. I am choosing to call that a creative decision.

**asahi:** I checked the wall with a book because I still do not own a spirit level.

**natsumi:** The same book that saved the noodles? Your library has an impressive practical career.

**system:** Dinner messages. Asahi puts the phone down while Natsumi describes the studio. Afterward he sends Mizuki the promised update, instead of trying to conduct both conversations at once.

**natsumi:** Thanks for dinner. Forgot how much you hate my sweet coffee lol.

**asahi:** That was coffee? Thought you'd found a way to melt a biscuit.

**Later:** `relationship`.

### The other side of an honest alternative
ID: `studio_lunch` · WED  23 DEC     12:30 · Messages / Natsumi

**natsumi:** Free for lunch? Want you to pick some prints with me. Just an hour.

**asahi:** Tell me what you need before I invent a heroic answer.

**natsumi:** Pick the first ones to go up. Building's doing the hanging. You can eat and have opinions.

**system:** She sends the contact sheet. I choose two prints with big empty spaces. She crosses one out and circles another. We argue about it over lunch.

**natsumi:** Preview's Friday. I'll send a photo. Thanks, that helped.

**Later:** `studio_preview`.

### The room she chose
ID: `studio_preview` · THU  24 DEC     12:10 · Messages / Natsumi

**system:** Photos: a new studio wall, the selected large print hung over a battered table. The picture Asahi suggested and Natsumi chose is visible beside her own work.

**natsumi:** No ladder emergency. I have become dangerously organized.

**asahi:** I like the empty part of the wall. It looks as though you expect to make more things.

**natsumi:** I do. It took me a long time to admit that without apologizing for the space.

**natsumi:** Photo's crooked because I took it. Before you say anything.

**Later:** `relationship`.

### A use she approved
ID: `licensed_update` · SAT  19 DEC     18:00 · Messages / Mizuki & Misaki

**mizuki:** someone wants to print the guide for an event. asked if that's okay. nice to be asked first lol

**misaki:** She asked me to check the caption again. I have apparently got a job.

**asahi:** Do you want to approve it, decline it, or ask what they are actually printing?

**mizuki:** i asked for the layout and a credit. they sent both. i said yes to this version.

**system:** The approved print event happens without the private client draft. Mizuki sends a photograph of the credited guide; she chose the audience and the use.

**misaki:** Credit's there. Picture is the right one. Looks fine to me.

**Later:** `kept_agreement`.

### A collection with a door
ID: `private_update` · SAT  19 DEC     18:00 · Messages / Mizuki

**mizuki:** paid version's finished. can you take the early work draft out of our folder now?

**asahi:** Done. The postcard can stay if you still want it here.

**mizuki:** yes, keep the postcard :) just wanted the work file out

**system:** Shared attachments: work draft withdrawn from the shared collection at Mizuki's request. The postcard remains in our private folder.

**mizuki:** looked at that postcard again. think the rice stain's grown on me

**Later:** `kept_agreement`.

### The permission that is still not there
ID: `boundary_followthrough` · SAT  19 DEC     18:00 · Messages / Mizuki

**mizuki:** saw the list. thanks for checking those posts were gone

**asahi:** Okay. Won't ask for more work pictures.

**mizuki:** good. no work files for now. can send my lunch if you want

**system:** I leave the work folder closed and open her lunch photo. The workshop is still canceled.

**asahi:** Your lunch has a very confident amount of cabbage.

**mizuki:** lol. fine. review my cabbage. leave the drawings alone tonight

**Later:** `kept_agreement`.

## Act 6: The Next Hello

### The work that continued
ID: `career_followup` · TUE  05 JAN     18:30 · Messages / Hoshino Studio

**team:** January schedule's ready. Have a look before I assign the next layouts.

**asahi:** I have put my existing commitments in the availability sheet. I want to say what time is real before we fill it.

**team:** Good. I'll work around those evenings.

**system:** Saved note: I opened the work thread before answering another invitation. I want to know which hours are mine to offer.

**team:** Finish your current piece first. Ask if you need another pair of eyes.

**Later:** `supervised_review`.
- When {'career_offer': True}: `project_meeting`.

### A small project of his own
ID: `project_meeting` · WED  06 JAN     18:30 · Messages / Hoshino Studio

**team:** You're planning the print layouts. Review Wednesday, if you want it. Keep the evenings you booked off.

**asahi:** Wednesday review, Friday delivery, two evenings unavailable. I have checked before offering the dates.

**team:** Fine. Put it on the sheet.

**system:** Draft after work: I have a little project of my own to plan. I want to tell you about it. I am excited in a way I had almost forgotten to be.

**asahi:** Actually excited about this one. I'll show you when I've got something.

**Later:** `mizuki_offer`.

### The task he still has
ID: `supervised_review` · WED  06 JAN     18:30 · Messages / Hoshino Studio

**team:** Review finished. The missing files are back where the next person can find them.

**asahi:** Got it. I know the other project went to someone else.

**team:** Thank you. There will be another project. This one needed a plan at the time.

**system:** Saved note: The review is done. The project went to someone else when it needed a plan. I cannot finish a different task and call that week undone.

**asahi:** I did something useful today. It wasn't the impressive version I imagined, but it happened.

**Later:** `mizuki_offer`.

### Her answer to her own question
ID: `mizuki_offer` · FRI  08 JAN     20:15 · Messages / Mizuki

Major decision: **D08**

**mizuki:** said yes to the otaru job. two days there, rest from home. just sent the email

**asahi:** How do you feel now that you have said yes?

**mizuki:** happy. scared lol. hope you're not upset i decided before we talked

**mizuki:** i do want the job. don't want you moving here just to make it work either. can we figure out the time?

**system:** Calendar: her workdays beside mine. She has already chosen the job. The question she asked me is what I can offer alongside it.

**mizuki:** what can we actually manage? please check before saying every weekend

- **Reply:** Keep the job. I want to keep mine too. Let's work out some dates we can manage. → `future_agreed`; records {'future_plan': 'workable', 'ritual_renewed': False}.
- **Reply:** I'd like to keep our Saturday thing in the plan. When we're both free, same as before. (requires {'ritual': True, 'ritual_kept': True}) → `future_agreed`; records {'future_plan': 'workable', 'ritual_renewed': True}.
- **Reply:** I still don't know what I can promise. Could we leave it open? You don't have to wait for me. → `open_conversation`; records {'future_plan': 'explicitly_undecided'}.
- **Reply:** Take the job. I don't think I can make this work, and I shouldn't keep you waiting. → `amicable_goodbye`; records {'relationship_mode': 'separated', 'resolution': 'amicable'}.
- **Reply:** I'll take the extra work. And every weekend with you. I can do both this time. Trust me. (requires {'work_broken': True}) → `burnout_warning`; records {'future_plan': 'incompatible'}.

### A plan with space around it
ID: `future_agreed` · SAT  09 JAN     19:30 · Messages / Mizuki

**mizuki:** two evenings a month. message when we can. check money and leave before booking. got all that in events

**asahi:** Same here. Left the other evenings clear for work and people here.

**mizuki:** okay :) just say if you need to cancel. i'll do the same

**system:** Saved note: We both confirmed the arrangement, including the evenings we need for ourselves. I read it again before putting it in Calendar.

**mizuki:** my first workday is tuesday. i'd like to tell you about it afterward. i may also be too tired to do anything but send a picture of my shoes.

**asahi:** I look forward to a rigorous review of the shoes, whenever it arrives.

**Later:** `end_distance`.
- When {'visit': 'late'}: `late_arrival`.
- When {'relationship_mode': 'friends'}: `end_friendship`.
- When {'relationship_mode': 'romantic', 'ritual_renewed': True}: `end_secret`.
- When {'meeting_plan': 'completed'}: `end_together`.

### The date becomes today
ID: `late_arrival` · SAT  16 JAN     13:55 · Messages / Mizuki

**mizuki:** i am at the exit we agreed. gray coat. very serious scarf. do not confuse me with a vending machine; it has a better pension.

**asahi:** I am still on the platform. I have read this message three times. It has not stopped being real.

**mizuki:** we are allowed to be different in person. we have already agreed that.

**system:** Travel note: January 16. This is the first afternoon we will have stood in the same place. I checked the exit number again, although I know it now.

**mizuki:** you can come over slowly. i'm not going anywhere for these next three minutes.

- **Reply:** Can I offer a hug when I get there? A hello is enough if you prefer. → `late_afternoon`; records {'greeting': 'offered hug'}.
- **Reply:** Let's start with hello. Want to walk for a bit? → `late_afternoon`; records {'greeting': 'quiet hello'}.

### A chair without a screen between it
ID: `late_afternoon` · SAT  16 JAN     19:30 · Messages / Mizuki

**mizuki:** home. kept the tea receipt. apparently i do that now lol

**asahi:** Someone who may need to return a deeply unremarkable beverage?

**mizuki:** someone who liked the afternoon and wants a small, silly thing that proves it happened.

**system:** Saved note: We asked before touching. We got lost without making it a competition about whose map was wrong. We sat beside a wall and talked until our tea went cold. There is a photograph of our cups now.

**mizuki:** you take longer to answer in person. liked that too

**asahi:** Me too. Really glad I came.

**Later:** `end_distance`.
- When {'relationship_mode': 'friends'}: `end_friendship`.
- When {'relationship_mode': 'romantic', 'ritual_renewed': True}: `end_secret`.
- When {'meeting_plan': 'completed'}: `end_together`.

### A question without a hidden yes
ID: `open_conversation` · SAT  09 JAN     19:30 · Messages / Mizuki

**mizuki:** okay if you really don't know. please don't say maybe just because it's easier

**asahi:** I don't know. Sorry. Wish I had a better answer.

**mizuki:** then no exclusivity promised by silence, no trip treated as a test, no saying "soon" when we mean "i hope."

**system:** Saved note: We agreed to leave the future open. We changed the plans that were still ahead of us together. I am trying to hear the whole answer we gave.

**mizuki:** we can still talk sometimes. but if it starts hurting, either of us can say stop. okay?

**Later:** `end_open`.

### The answer he has used before
ID: `burnout_warning` · SAT  09 JAN     19:30 · Messages / Mizuki

**mizuki:** you promised overlapping weekends before. work did not get smaller because you wanted it to, and neither did the distance.

**asahi:** I can try harder.

**mizuki:** you already tried harder. people stayed late, plans collapsed, and you stopped telling me when you were tired because it sounded less devoted.

**mizuki:** we could just do less. keep our jobs. have nights off. i'd still want to see you

**system:** Saved note: She offered fewer promises and enough room to keep them. I recognized the answer I had used when two plans needed the same afternoon.

- **Reply:** You are right. I will choose the smaller plan and tell people what I cannot do. → `future_agreed`; records {'future_plan': 'workable', 'ritual_renewed': False}.
- **Reply:** No. I'm not canceling either plan. We just need to keep going. → `end_burnout`; records {'relationship_mode': 'separated', 'resolution': 'burnout'}.

### The conversation without a villain
ID: `amicable_goodbye` · SAT  09 JAN     19:30 · Messages / Mizuki

**mizuki:** oh. okay. need a minute

**asahi:** I'm sorry. I care about you. I just can't keep promising this.

**mizuki:** please don't say we'll talk every day. need a bit of space first

**asahi:** I can do that. Would you like the shared collection kept private, or removed from the shared view?

**mizuki:** private for now. i'll sort them later. thanks for asking

**system:** Saved note: We canceled the plans still ahead of us. I kept the photographs we agreed I could keep. The evenings that happened do not become mistakes because this is the last one.

**Later:** `end_goodbye`.

### A Place for Us
ID: `end_together` · SAT  20 FEB     19:30 · Messages / Mizuki

**system:** February. Our first meeting photo is in the folder. Beside it, another visit we have both booked leave for.

**mizuki:** i finished my first month. i drew a window today and did not think of it as an audition for the rest of my life.

**asahi:** Bought a second mug. Before you ask, yes, another ugly one.

**mizuki:** lol. i'll use it. then get my train back so i still have a job

**asahi:** I'll check my leave before we book the next one.

**mizuki:** i know what your hello sounds like in a room now. i still look forward to the one on the screen.

**system:** Saved note, April: She used the second mug. One evening I had work to finish, so she went out while I finished it. We ate dinner afterward and talked about the different afternoons we had had. I like that we are learning how to come back to each other without leaving everything else behind.

**mizuki:** train ticket saved. your mug is still ugly. see you saturday.

**Ending:** Good / together.

### Same Sky, New Plan
ID: `end_distance` · SAT  20 FEB     19:30 · Messages / Mizuki

**system:** February. They have not met. Calendar contains an agreed March travel discussion and two planned evenings, with room around both.

**mizuki:** wish you were sitting here. still glad we can do this though

**asahi:** Me too. Tuesday was good.

**mizuki:** tuesday was not wasted. you talked me through saving the wrong version of a file and then admitted you had done the same thing at work.

**asahi:** A relationship founded on version control errors. Very modern.

**mizuki:** lol. events says tuesday again. don't forget dinner this time

**system:** Saved note, April: We had the March conversation. We checked leave and money before circling dates. Until then there are planned calls, ordinary messages, and pictures of lunches neither of us would show anyone else. I still wish she were nearer. I also know when we are going to talk next.

**mizuki:** a picture of my shoes, as promised. terrible commute. tell you about it after dinner?

**Ending:** Good / distance.

### Still in the Party
ID: `end_friendship` · SAT  20 FEB     19:30 · Messages / Mizuki

**mizuki:** daichi put the bridge warning in twice lol. four players and no rushing in caps

**asahi:** Does it mention waiting at bridges?

**mizuki:** twice. man is serious about bridges

**system:** The next invitation is explicitly a friend activity. The friendship plan includes room for new relationships and for evenings when either person is elsewhere.

**mizuki:** thought this would get awkward. glad we still do this

**asahi:** Me too. Want to tell me about the sketchbook while we wait?

**system:** Saved note, April: We still play. She tells me about work; I send pictures of things I have cooked badly. There are new people in both of our lives. I am glad we said friendship clearly enough that neither of us has to spend these evenings waiting for a different answer.

**mizuki:** new player at the bridge. come on. let's show them where to wait.

**Ending:** Neutral / friendship.

### Thank You for the Time
ID: `end_goodbye` · SAT  20 FEB     19:30 · Messages / Mizuki

**system:** February. The final exchange is reopened once, deliberately. Canceled plans are labeled canceled; memories are not relabeled mistakes.

**mizuki:** doing okay. mostly. just wanted you to know. don't think i'm ready for a long chat

**asahi:** Okay. Natsumi helped put some prints up. Flat looks different now.

**mizuki:** that sounds like something good.

**asahi:** I'm glad I met you, Mizuki.

**mizuki:** me too. take care of yourself, okay?

**system:** Saved note, April: I kept one photograph. Some evenings I look at it, and some I forget it is there. Work still needs doing. Natsumi still has news when we talk. I miss Mizuki without having an answer to send her. Tomorrow I have lunch with someone who is here.

**system:** Messages: conversation archived. The photographs we chose to keep remain private.

**Ending:** Neutral / goodbye.

### Words Left Unsaid
ID: `end_unsaid` · THU  17 DEC     19:45 · Messages / Mizuki

**mizuki:** asked you again. you still won't listen. i can't keep doing this

**mizuki:** please stop contacting me. don't ask misaki or daichi to talk me round either. or the client

**system:** Unsent note: I want to send another explanation.

**system:** Unsent note: Her last message says stop. I close the draft.

**system:** Pending plans are canceled. Past choices remain in their history, and the last refusal stays in the thread beside the offered repair.

**system:** Unsent note, April: I wrote an apology. Left it here. She asked me to stop contacting her, so I haven't sent it from another account.

**system:** Saved note: Her last message is still clear. I closed the composer.

**Ending:** Bad / unsaid.

### Nothing Left to Give
ID: `end_burnout` · SAT  20 FEB     19:30 · Messages / Mizuki

**system:** The following weeks repeat the pattern Asahi chose to preserve: overlapping promises, rushed apologies, and smaller lives built around avoiding the next disappointment.

**mizuki:** we talked about doing less. then you promised all of it again. i can't keep clearing my evenings and hoping

**asahi:** I thought devotion meant finding a way to do everything.

**mizuki:** i miss when we could just talk. now you're tired, i'm upset, and we're apologizing all the time

**system:** Saved note: I read the smaller plan she offered again. I had turned down the one arrangement that left us enough time to live inside it.

**system:** Saved note, April: I said no to an extra task before accepting another. Nothing dramatic happened. Someone made a different plan. The project I lost is still someone else's, and Mizuki is still gone. But one person knew which hours they could depend on me for today. I want to get better at that.

**system:** In Calendar, he leaves a Saturday empty without filling it with an apology.

**Ending:** Bad / burnout.

### Maybe, Someday
ID: `end_open` · SAT  20 FEB     19:30 · Messages / Mizuki

**mizuki:** went past the station. thought about you for a bit. wasn't expecting that

**asahi:** Do that too. Still don't have an answer about coming.

**mizuki:** i know. still figuring things out here too

**asahi:** Hope the job's going okay. Been busy here.

**system:** Saved note: No ticket booked. No promise of exclusivity. We said both things aloud before agreeing to keep an occasional conversation.

**system:** Saved note, April: Some weeks we talk. Some we do not. A rainy window arrived on my screen after a quiet month. I opened it after work and sat with it for a while. There are several things I could say. I want to choose the one I mean.

**mizuki:** same rain here. how has your ordinary day been?

**Ending:** Open / open.

### The Everyday Hello
ID: `end_secret` · SAT  20 FEB     19:30 · Messages / Mizuki

**system:** After dinner, I open our conversation. We have kept this evening free.

**mizuki:** ready?

**asahi:** Ready. Dinner's done. Didn't burn anything.

**mizuki:** lol. ready here too. don't mind if you're still eating

**system:** Party transcript: they carry two lanterns to the old bridge. This time there is no newcomer to guide. Mizuki stops on the safe bank, and Asahi waits beside her until they both choose to go on. (only when {'path': 'guild'})

**system:** Reading transcript: they send each other one page and a window photo. Mizuki reads the same paragraph twice while Asahi eats. The quiet has no work to do except be shared. (only when {'path': 'private'})

**system:** Call transcript: a tap runs in Tokyo and a cupboard closes in Sapporo. Mizuki says "dishes" before stepping away. Asahi finishes dinner. When she returns, they pick up the same ordinary evening. (only when {'path': 'lives'})

**mizuki:** so what did you do today? anything exciting?

**asahi:** I put the right lid on the right pan. On the first attempt.

**mizuki:** drew a window. came home. forgot the milk in my tea. average tuesday lol

**asahi:** Did you remember dinner?

**mizuki:** ...brb toast

**system:** Saved note, April: We still keep our small thing when we can. Last Saturday she was too tired. This Saturday I was late back from the shop. We said so, and found another evening. I remember that first random garden run and how little I knew about the person beside the other lantern. I want to hear what she did on Tuesday.

**Ending:** Secret / everyday.

