# The Next Hello: soundtrack generation pack

Revised briefs for the 2009–2010 story. These replace the previous prompts. Keep the twelve titles and filenames so downloads remain easy to identify. Generate A and B from each brief: two candidates for the same song, sharing one unlock condition. A/B does not mean happy/sad or vocal/instrumental.

These are original generation prompts, lyrics and the soundtrack unlock specification. The supplied A/B WAVs and licenses are now cataloged in `content/music.json`, with normalized OGG playback copies prepared by `tools/prepare_music.py`. The Music header utility implements playback and scene-based availability.

## Availability and progression

Asahi starts with three songs already in his library. Later songs appear after he experiences the relevant scene. Chapter names and scene IDs match `content/story.json`. Complete a scene and commit its reply before unlocking; opening a screen or previewing a choice does not count. Any listed scene is sufficient. Internal `guild_*` IDs refer to a game party, not a guild in the fiction.

| Song | Available after | Why it fits |
|---|---|---|
| October 23 | New game | Asahi's familiar music for getting home and logging in. |
| Lunch Break | New game | His existing workday listening. |
| The Last Bus | New game | A commute favorite; he has a life and music collection before meeting Mizuki. |
| A Green Light | Chapter 1: complete `first_dm` | A stranger from a game becomes someone he might hear from again. |
| Four Players | Chapter 2: complete `guild_event`, `guild_guide`, `private_event`, `private_rescheduled`, `lives_call`, or `lives_reschedule` | Their first agreed activity actually happens. Every activity path qualifies. |
| Two Windows | Chapter 2: complete `after_game`, `party_rest`, `reading_evening`, `reading_once`, `small_call`, or `call_once` | A quieter conversation after spending time together. Every activity path has an equivalent scene. |
| Ink on the Table | Chapter 3: complete `showcase` or `showcase_setup`; later fallback: `studio_lunch` or `studio_preview` | Asahi attends Natsumi's creative work. Missing the event leaves it locked unless he later attends an actual studio scene. |
| Away for Dinner | Chapter 3: complete `natsumi_invite` | Familiar routines start competing for the same hours. Any chosen answer qualifies. |
| Missed the Last Train | Chapter 4: complete `work_adjusted`, `work_kept`, or `work_broken` | Work and the proposed visit become practical concerns. All work outcomes qualify. |
| The Long Way Back | Chapter 5: complete `privacy_repair`, `promise_repair`, or `expectations_talk` | They have spoken about the difficulty. Repair, space and refusal all qualify. |
| Your Coat | Chapter 5: complete `romantic_date` | They mutually choose romance. Friendship and separation do not unlock it in that run. |
| Same Time Next Week | Complete any of the eight ending scenes | A final library addition after the outcome is known. Its harmony leaves room for hope, uncertainty or loss. |

Unlocked tracks stay available in the current save even if the relationship changes. Availability and mood selection are separate: a previously unlocked happy song stays in the library during a difficult chapter. Hide locked titles, lyrics and unlock explanations during a first playthrough. A new game starts with the original three; a future optional collection mode may expose discoveries from completed runs.

Unlocking does not interrupt messages, start playback or invent a recommendation from a character. Show a small “New song added” notice after the scene. If both A and B ship, show one song row with a version selector. A second version is not another story reward.

For an optional automatic playlist, suggest October 23 for the opening, A Green Light for anticipation, Two Windows for private evenings, Away for Dinner for busy routines and The Long Way Back for strain. Respect manual track selection until the player resumes automatic selection. Use instrumentals under reading; vocal tracks require deliberate selection. Silence remains an option.

At the ending, use Two Windows, if earned, for `end_together`, `end_distance`, `end_friendship`, `end_goodbye`, `end_open` and `end_secret`. Keep The Long Way Back for `end_unsaid` and `end_burnout`. Same Time Next Week unlocks after every ending and is available for deliberate selection. The supplied A/B files are conservatively marked as vocal candidates following the lyrics-generation request; the automatic playlist excludes them until a separate instrumental arrangement is supplied. Never automatically select the romantic vocal song for friendship or separation. Follow the actual outcome, not an affection total.

## Generation and file setup

Use each prompt independently. BPM and duration are targets. Choose instrumental generation for the ten instrumental songs and leave the lyrics field empty. Your Coat includes a lyrics-generation prompt; Missed the Last Train includes original English lyrics. Same Time Next Week also offers an optional vocal arrangement and lyrics-generation prompt. Keep their phrasing conversational.

The collection belongs on a personal MP3 player in 2009–2010. Let the genres differ, with guitars, small-band performances, drum machines and early home recording. Avoid contemporary festival drops, trap rolls and extreme vocal processing. Reading tracks need restrained dynamics and room between melodic phrases. Generate A and B with the same brief and lyrics, then compare them.

Download WAV masters. Example: `assets/audio/music/october_23/october_23_a.wav` and `october_23_b.wav`. Keep original license files in `licenses/music/october_23/`, with `a/` and `b/` subfolders if each version has a separate license. Prepare OGG playback copies after choosing versions and checking levels. Generated endings still need editing and listening checks before they can loop cleanly.

## 01. October 23

Available from the start. Indietronica / soft synth-pop. Instrumental. Target: 84 BPM, 3 minutes.

Files: `october_23_a.wav`, `october_23_b.wav`.

Prompt:
> A warm instrumental from a small independent electronic release in 2009. Rounded electric piano, a modest analog synth hook, soft drum-machine kicks and a gently moving bass line. Someone gets home from work, heats dinner and logs in out of habit. Familiar and slightly lonely, with a little curiosity in the chord changes. Introduce a four-bar melody early, then let it disappear while the rhythm continues. Keep the synth soft enough for reading. Short intro, even dynamics, eight-bar closing groove. No vocals, humming, speech or notification sounds. Target 84 BPM, three minutes.

## 02. A Green Light

Chapter 1, after the first DM. Jangle pop. Instrumental. Target: 104 BPM, 3 minutes.

Files: `a_green_light_a.wav`, `a_green_light_b.wav`.

Prompt:
> Instrumental jangle pop with a believable 2009 bedroom-band recording. Two clean electric guitars, melodic bass, a compact live drum kit and occasional tambourine. The mood is a good conversation with someone you barely know, followed by checking whether they are still online. A bright little guitar phrase returns with a slightly hesitant final chord. Leave the verses sparse and let the refrain pick up naturally. Light amplifier texture, comfortable cymbals and no dramatic build. No singing or vocal samples. Target 104 BPM, three minutes, with a short instrumental outro.

## 03. Four Players

Chapter 2, after the first shared activity. Chiptune / indie electronic. Instrumental. Target: 112 BPM, 2:45.

Files: `four_players_a.wav`, `four_players_b.wav`.

Prompt:
> Friendly late-2000s chiptune mixed with a small indie-electronic arrangement. Soft square-wave melody, triangle bass, dry drum-machine percussion and electric-piano chords. A little tune you might keep playing after a casual online game has ended. Use two short melodies that take turns, with a quiet middle section before they play together. Cheerful, a little clumsy and easy on headphones. Keep high notes rounded and percussion modest. No arcade effects, combat sounds, victory fanfare, vocals or spoken samples. Target 112 BPM, two minutes forty-five seconds, ending on the opening groove.

## 04. Two Windows

Chapter 2, after a quiet follow-up conversation. Acoustic folk. Instrumental. Target: 74 BPM, 3:15.

Files: `two_windows_a.wav`, `two_windows_b.wav`.

Prompt:
> Fingerpicked acoustic folk instrumental recorded in a small room around 2009. Steel-string guitar carries a modest melody; a second guitar answers occasionally, with a few upright-piano notes later. Two people leave their conversation open while each does something else at home. Comfortable pauses, audible fingers on strings and a performance that breathes slightly around the beat. Keep the harmony warm with occasional unfinished phrases. No percussion is needed. No singing, humming, rain samples or cinematic strings. Target 74 BPM, three minutes fifteen seconds. Let the last guitar chord ring out.

## 05. Ink on the Table

Chapter 3 or a later studio visit; conditional on attending. Japanese indie rock. Instrumental. Target: 116 BPM, 3 minutes.

Files: `ink_on_the_table_a.wav`, `ink_on_the_table_b.wav`.

Prompt:
> Instrumental Japanese indie rock from a small venue in 2009. Interlocking clean guitars, a melodic picked bass and a live drummer playing a loose, lively groove. Friends are putting up prints before a modest exhibition opens; there is work to do and someone keeps moving the tape. Give the main guitar a memorable uneven phrase. A lightly overdriven refrain adds energy without swallowing the bass. Keep room sound and a few small performance imperfections. No vocals, applause or electronic drops. Target 116 BPM, three minutes, with an eight-bar band outro.

## 06. Lunch Break

Available from the start. Jazzy instrumental hip-hop. Target: 86 BPM, 3 minutes.

Files: `lunch_break_a.wav`, `lunch_break_b.wav`.

Prompt:
> Instrumental hip-hop with the feel of a 2008–2009 beat tape. Warm Rhodes chords, loose swung drum breaks, rounded bass and brief jazz-guitar phrases. A familiar album playing through cheap earbuds during a short weekday lunch. Let the drum pocket carry the track, with a small piano idea that develops over changing chords. Relaxed, mildly distracted and pleasant enough to replay. Clear production with light saturation and very little background noise. No rapping, singing, vocal chops, producer tags or heavy vinyl crackle. Target 86 BPM, three minutes. End with the main beat thinning out.

## 07. Away for Dinner

Chapter 3, as schedules begin to overlap. Downtempo / trip-hop. Instrumental. Target: 90 BPM, 3:15.

Files: `away_for_dinner_a.wav`, `away_for_dinner_b.wav`.

Prompt:
> A restrained downtempo instrumental that fits a personal music collection in 2009. Dry drum machine, deep rounded bass, muted electric piano and a few delayed guitar notes. Dinner is getting cold while two conversations wait for replies. Keep an ordinary domestic warmth, with a slightly restless syncopation underneath. Introduce small changes in the bass and leave the upper register mostly empty. The middle section loses the drums briefly before the groove returns. No suspense effects, grand crescendo, singing or speech. Target 90 BPM, three minutes fifteen seconds, with a steady closing phrase.

## 08. The Last Bus

Available from the start. Liquid drum and bass. Instrumental. Target: 166 BPM, 3:30.

Files: `the_last_bus_a.wav`, `the_last_bus_b.wav`.

Prompt:
> Melodic liquid drum and bass with a 2008–2010 independent-label sound. Rolling breakbeats, smooth sub-bass, warm Rhodes harmony and a small washed-out guitar motif. A tired commuter watches the city pass through a bus window; the fast drums make the ride feel easier. Give the chords enough space to feel calm above the rhythm. Gentle cymbals, a short atmospheric middle passage and a return to the first bass line. No aggressive wobble bass, festival drop, singing or spoken samples. Target 166 BPM, three minutes thirty seconds. Keep the ending smooth.

## 09. The Long Way Back

Chapter 5, after a difficult conversation. Instrumental emo / post-rock. Target: 78 BPM, 3:30.

Files: `the_long_way_back_a.wav`, `the_long_way_back_b.wav`.

Prompt:
> Late-2000s instrumental emo with a restrained post-rock arrangement. Clean arpeggiated electric guitars, warm bass and sparse live drums in a small rehearsal room. After a difficult conversation, someone takes a longer walk home and keeps putting their phone away. Let one guitar phrase trail off before the other finishes it. Unresolved chords, a modest swell halfway through and a quieter final passage. Leave the outcome uncertain; the music should also fit a careful attempt to repair things. No huge crescendo, orchestral strings, vocals or speech. Target 78 BPM, three minutes thirty seconds.

## 10. Same Time Next Week

After any ending. Ambient piano / chamber folk. Instrumental. Target: 68 BPM, 3:15.

Files: `same_time_next_week_a.wav`, `same_time_next_week_b.wav`.

Prompt:
> A quiet instrumental from a modest 2009 independent-film soundtrack. Close upright piano, occasional acoustic-guitar harmonics and a faint cello entering in the second half. The room is quiet after a long conversation. Use a small recurring melody whose last note hangs over a different chord each time. There is warmth in the recording and uncertainty in the harmony. Leave generous pauses and keep the performance intimate. No triumphant resolution, funeral march, percussion, singing or humming. Target 68 BPM, three minutes fifteen seconds. Let the final piano chord decay fully.

Optional vocal arrangement: soft male midrange, English. Use the same intimate piano-and-guitar arrangement, with an unforced vocal and sparse harmonies. Generate the lyrics with the prompt below before generating the song. This arrangement is for deliberate playlist listening or credits; keep the existing instrumental for automatic reading playback. Files: `same_time_next_week_vocal_a.wav`, `same_time_next_week_vocal_b.wav`. It shares the base song's ending unlock.

Lyrics-generation prompt:
> Write original English lyrics for a quiet 2009 chamber-folk song titled "Same Time Next Week," sung by a man in a close, unforced voice. A familiar weekly conversation has ended, and he is clearing up his room afterward. Show what the calls meant through small details: two cups even though he is alone, a clock he forgot to check, a book left open, something ordinary he saved to tell the other person. The phrase "same time next week" first appears as a remembered habit. By the final chorus it becomes a gentle question whose answer remains unstated. Leave room for the listener to hear continued friendship, a relationship at a distance, or a goodbye. Do not confirm a reunion, breakup, death, booked visit or romantic commitment. Keep the tone tired, affectionate and a little uncertain. Use simple singable language, natural contractions, breathing room and loose rhymes. Structure: [Verse 1], [Chorus], [Verse 2], [Chorus], [Bridge], [Final Chorus]. Around 180–230 words. Keep any technology plausible for 2009–2010. Avoid fate, stars, forever, healing speeches and named game characters. Return only the title and finished lyrics with section tags.

## 11. Your Coat

Chapter 5, after a mutually chosen romantic date. Indie pop / acoustic pop. Female voice, intimate midrange. English. Target: 102 BPM, about 3 minutes. Optional player selection; keep vocals out of automatic reading playback.

Files: `your_coat_a.wav`, `your_coat_b.wav`.

Style prompt:
> A 2009 acoustic indie-pop song with an intimate female midrange voice. Fingerpicked acoustic guitar in the verse, clean electric guitar and a small live rhythm section joining the chorus. Someone keeps finding ordinary excuses for the person she likes to visit again. Sing the supplied English lyrics with a little embarrassment and a smile in a few words. Natural phrasing, restrained harmonies on the final chorus and no belting. Keep the band warm and the vocal lightly produced. Target 102 BPM, about three minutes, ending with a short guitar outro.

Lyrics-generation prompt:
> Write original English lyrics for a 2009 acoustic indie-pop song titled "Your Coat," sung by a woman in an intimate, conversational voice. Someone she likes left a coat at her apartment, and she keeps finding small excuses to delay returning it because she wants another visit. Show affection through ordinary details: a ticket in the pocket, coffee she bought for him, dinner for two, checking when his train arrives. Give the singer a little awkward humor and let her gradually become more direct. Make "come and get your coat" the chorus hook. Use short singable lines, natural contractions and occasional loose rhymes. Structure: [Verse 1], [Chorus], [Verse 2], [Chorus], [Bridge], [Final Chorus]. Change a few lines in the final chorus so she actually asks him to come over. Around 200–260 words. Keep technology plausible for 2009–2010. Avoid grand declarations, destiny, forever promises, ornate metaphors and named game characters. This is a fictional artist's song, not a literal account of Asahi and Mizuki. Return only the title and finished lyrics with section tags.

This is a song by an artist in Asahi's library. The coat and visit belong to the singer's story. Unlocking it does not claim Asahi and Mizuki have met or booked travel.

## 12. Missed the Last Train

Chapter 4, after the work decision. Pop-punk / emo-pop. Male voice, youthful tenor with some roughness. English. Target: 148 BPM, about 3 minutes. Optional player selection.

Files: `missed_the_last_train_a.wav`, `missed_the_last_train_b.wav`.

Style prompt:
> A melodic 2009 pop-punk song with a slightly rough male tenor. Palm-muted verse guitars, open chorus chords, melodic bass and a natural live drum kit. A man stays late at work, misses his train and tries to admit he has promised more time than he has. Sing the supplied English lyrics clearly, with tired humor in the verses and frustration in the chorus. Catchy band hook, restrained backing vocals and a half-time bridge. Keep guitars warm and vocal processing light. Target 148 BPM, about three minutes, with a brief ringing guitar ending.

Lyrics:

```text
[Verse 1]
The cleaner asked if I was leaving
I said, yeah, another minute
The screen went black at half past ten
I saw my own face in it

[Verse 2]
You sent a picture of your dinner
I said I'd call you after mine
I've got a sandwich from the station
And a pretty bad idea of time

[Chorus]
I missed the last train
I'm walking home again
Saying twenty minutes
When I know it's forty-five
If you're tired, go to bed
I'll call tomorrow like I said
I keep telling you I'm on my way
I should tell you where I am

[Verse 3]
The arcade shutters rattle
There's a light on down the street
I stop to buy a can of coffee
That I probably don't need

[Bridge]
I put my keys beside my lunch
Set the alarm before I sleep
I write down what I've promised
There's a lot to fit next week

[Final Chorus]
I missed the last train
I'm walking home again
It's another forty minutes
You don't have to stay awake
Leave a message when you're up
Tell me if your day was rough
I keep telling you I'm on my way
I'm still learning when to stop
```

## First generation batch

Generate the opening three first: October 23, Lunch Break and The Last Bus. Then make A Green Light and The Long Way Back to check the range from anticipation to strain. Generate the others once those feel like they could belong to the same person's music collection. Both versions must fit the same scene; use different song titles for different moods.

For each export, check for accidental voices in instrumentals, a comfortable opening under text and a usable ending. Listen to both vocal songs against their supplied lyrics. Label any instrumental companion separately, for example `your_coat_instrumental_a.wav`. A/B alone always refers to generation candidates.
