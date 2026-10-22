"""Author the opening graph and stable English string IDs. No external dependencies."""
import json
from pathlib import Path

strings = {}
nodes = {}


def string(key, value):
    strings[key] = value
    return key


def node(key, title, app, day, lines, choices=(), later=None, facts=None):
    data = {"title": string(f"{key}.title", title), "app": app, "day": day,
            "lines": [{"speaker": who, "text": string(f"{key}.line.{i}", text)}
                      for i, (who, text) in enumerate(lines)], "choices": []}
    for i, (text, target, effects) in enumerate(choices):
        data["choices"].append({"id": f"{key}.choice.{i}",
                                "text": string(f"{key}.reply.{i}", text),
                                "to": target, "set": effects})
    if later:
        data["later"] = later
    if facts:
        data["set"] = facts
    nodes[key] = data


node("invite", "01 / A chance encounter", "Games", 1, [
    ("system", "Random matchmaking pairs you with mizuki for a garden run. You have never met."),
    ("mizuki", "oh hi. first time in this garden?"),
    ("mizuki", "i can carry the lantern. unless you want it?")], [
    ("Deal. Slow and steady. I'd like to see the garden.", "bridge", {"role": "lookout"}),
    ("I'll take the lantern. You can stop me walking into things.", "bridge", {"role": "lantern"})])

node("bridge", "The crooked bridge", "Games", 1, [
    ("system", "A stone bridge crosses the dark water. A second lantern flickers on the far bank."),
    ("mizuki", "shortcut should be fine"),
    ("mizuki", "i did fall in last time. should probably mention that")], [
    ("Let's light the stepping stones. I'll wait for you.", "first_dm", {"garden_memory": "stones"}),
    ("Want to try the bridge together? We can be damp legends.", "splash", {"garden_memory": "splash"})])

node("splash", "A small detour", "Games", 1, [
    ("system", "The bridge folds into the water. Two tiny characters respawn under the same leaf."),
    ("mizuki", "okay. nice leaf though"),
    ("system", "You save a screenshot of the two of you under the leaf.")], [
    ("Next time, we take the stones. Keeping the screenshot though.", "first_dm", {})])

node("first_dm", "A new conversation", "Messages", 1, [
    ("system", "Lantern garden screenshot added to Photos. A private message arrives from mizuki."),
    ("mizuki", "thanks for waiting btw. most people just go"),
    ("mizuki", "Mizuki. Sapporo. currently holding a noodle lid shut with my elbow")], [
    ("Asahi. Tokyo. Put a book on it. Finally, a use for my unread pile.", "night", {"intro": "books"}),
    ("Asahi. Tokyo. Glad I'm not the only one having a heroic evening.", "night", {"intro": "heroic"})], facts={"screenshot": True})

node("night", "A little after eleven", "Messages", 1, [
    ("mizuki", "lid defeated. hi Asahi"),
    ("mizuki", "i draw for work. six versions of the same window today. needed to look at something else"),
    ("mizuki", "you playing again this weekend? or we could do something else. if you want")], [
    ("Another garden run this weekend? We could play together again.", "guild_agreed", {"path": "guild"}),
    ("Want to swap window photos? Maybe make something small together.", "private_agreed", {"path": "private"}),
    ("I'd like to know your everyday life. A call, when we're both free?", "lives_agreed", {"path": "lives"})])

node("guild_agreed", "One more party", "Messages", 1, [
    ("mizuki", "Yes. Maybe open a small party? As long as we get to play together."),
    ("system", "Saturday's garden run is in Calendar. You and Mizuki will open a public party together.")], later="guild_plan", facts={"commitment": "Saturday / Garden run with Mizuki", "memory": "A second party invite"})

node("private_agreed", "Two windows", "Messages", 1, [
    ("mizuki", "I'd like that. Two cities, two windows. Maybe a little illustrated postcard?"),
    ("mizuki", "Just between us for now. Rough work makes me shy."),
    ("system", "A private photo exchange is in Calendar. Mizuki will send her desk photo tomorrow.")], later="private_photo", facts={"commitment": "Saturday / Private postcard session", "memory": "Two cities, two windows", "photo_permission": "private"})

node("lives_agreed", "Beyond the username", "Messages", 1, [
    ("mizuki", "A call sounds good. Sunday afternoon? My sister's helping me move a shelf Saturday."),
    ("mizuki", "Fair warning: my everyday life contains a lot of arguing with furniture."),
    ("system", "Sunday's call is in Calendar. Tomorrow, check your work schedule before confirming.")], later="lives_work", facts={"commitment": "Sunday / Call with Mizuki (proposed)", "memory": "A voice beyond the game"})

node("guild_plan", "02 / A garden for everyone", "Games", 2, [
    ("mossbyte", "Hi, I'm Daichi. Thanks for opening the party. A few more new players want to join. Could you lead separate groups?"),
    ("mizuki", "I was looking forward to playing together. Could we guide one small group instead?")], [
    ("One small group. We'll show them the safe route together.", "guild_event", {"guild_plan": "small group"}),
    ("Let's make a route guide tonight, then let someone else lead.", "guild_guide", {"guild_plan": "route guide"})])
node("guild_event", "Lanterns in the rain", "Games", 2, [
    ("system", "You and Mizuki bring three new players through the garden. At the bridge, everyone waits."),
    ("mizuki", "Look at that. A whole party that doesn't leave anyone behind."),
    ("mossbyte", "I'm keeping the group small next week too. Thanks for saying something.")], later="guild_callback", facts={"guild_event": "guided newcomers"})
node("guild_guide", "A map with a warning", "Games", 2, [
    ("system", "You mark safe stones while Mizuki draws a tiny skull on the crooked bridge. A newcomer volunteers to guide."),
    ("mizuki", "Our first joint publication. Please credit the skull artist."),
    ("mossbyte", "Pinned the guide. You two can just play tonight.")], later="guild_callback", facts={"guild_event": "published route guide"})
node("guild_callback", "03 / The next invitation", "Messages", 3, [
    ("mizuki", "Daichi asked before adding people this time. I think we started something."),
    ("mizuki", "Next Saturday, same garden? I'd like a little time with just you after."),
    ("system", "Opening complete. Your shared game activity has opened a small-party invitation and a private after-game conversation. The collaboration and visit-preparation scenes belong to other paths.")], facts={"available_events": ["small_party", "after_game_chat"]})

node("private_photo", "02 / The mug has a new job", "Messages", 2, [
    ("system", "Mizuki shared a private desk photo. Read this description or open Shared attachments in Messages: pens in a mug, a half-finished illustration on a laptop, rain against the window."),
    ("mizuki", "Window attempt seven. Application deadline Monday. Please keep this one between us.")], [
    ("Want quiet company while we make the postcard? We can leave it unfinished.", "private_event", {"collaboration": "quiet company"}),
    ("Let's move our postcard session until after your deadline. I'll send my photo now.", "private_rescheduled", {"collaboration": "rescheduled"})], facts={"desk_photo": True})
node("private_event", "A room in two cities", "Messages", 2, [
    ("system", "A song plays softly in the background. You send your rainy Tokyo window; Mizuki sends a small line drawing in return. Neither of you posts it."),
    ("mizuki", "I finished the corner I was stuck on. Quiet company works, apparently."),
    ("system", "A private postcard joins Photos. Mizuki keeps working on her application.")], later="private_callback", facts={"postcard": True})
node("private_rescheduled", "Room to finish", "Messages", 2, [
    ("mizuki", "Thank you. Tuesday evening? I want to do this when I'm not watching a deadline."),
    ("system", "You share the Tokyo window privately. The postcard session moves to Tuesday; tonight Mizuki works on her application."),
    ("mizuki", "Your window has good rain. Keeping that photo.")], later="private_callback", facts={"commitment": "Tuesday / Private postcard session"})
node("private_callback", "03 / After the deadline", "Messages", 3, [
    ("mizuki", "Submitted. I checked the attachment three times. Four if we're being honest."),
    ("mizuki", "Can I show you the finished illustration? And I found a short story we could read together."),
    ("system", "Opening complete. Your private activity has opened an illustration follow-up and a buddy-read invitation. The group activity and visit-preparation scenes belong to other paths.")], facts={"available_events": ["illustration_followup", "buddy_read"]})

node("lives_work", "02 / Making room", "Work", 2, [
    ("team", "Monday's handoff needs a check. You can finish Saturday afternoon or take the Sunday review. Both are fine; tell me which."),
    ("system", "Mizuki's proposed call is Sunday afternoon. Friday work is available; taking Sunday means explicitly rescheduling the call.")], [
    ("I'll do the Saturday check so Sunday stays free.", "lives_call", {"work": "Saturday handoff", "commitment": "Sunday / Call with Mizuki (confirmed)"}),
    ("I'll take Sunday. I'll ask Mizuki about another call time before confirming.", "lives_reschedule", {"work": "Sunday review", "commitment": "Monday / Call with Mizuki (confirmed)"})])
node("lives_call", "A shelf, assembled", "Messages", 2, [
    ("system", "Sunday afternoon. A call transcript opens after your completed Saturday handoff."),
    ("mizuki", "Can you hear me? Sorry. My sister says hello. And that I put the shelf upside down."),
    ("asahi", "I'd like the shelf's side of the story."),
    ("mizuki", "It's staying silent. Clever shelf."),
    ("system", "You talk about ordinary weekends, and what a visit might look like. No travel is booked.")], later="lives_callback", facts={"call": "Sunday with sister introduction"})
node("lives_reschedule", "A different evening", "Messages", 2, [
    ("asahi", "I chose the Sunday review. Could we call Monday evening instead? I'd like to give it proper time."),
    ("mizuki", "Monday works. My sister will have gone home, so you'll miss the shelf assembly commentary."),
    ("system", "Monday evening. After the work review, you and Mizuki talk over dinner on a call. No introduction to Misaki happened this time."),
    ("mizuki", "Tell me about Tokyo on a normal day. Not the postcard version.")], later="lives_callback", facts={"call": "Monday dinner call"})
node("lives_callback", "03 / A possible journey", "Calendar", 3, [
    ("mizuki", "If we ever meet, I'd rather have an ordinary afternoon than a perfect itinerary."),
    ("system", "You compare a future leave window and agree to discuss it again. A visit is a possibility, not a promise."),
    ("system", "Opening complete. Your call has opened a leave discussion and an everyday-friends introduction. The game project and private postcard scenes belong to other paths.")], facts={"available_events": ["leave_discussion", "friends_introduction"], "meeting_plan": "discussing"})

goals = {
    "invite": "Random matchmaking put me with mizuki. I need to pick a role for our garden run.",
    "bridge": "I should check with Mizuki before we cross that bridge.",
    "splash": "That bridge didn't go to plan. I still owe everyone a reply.",
    "first_dm": "Mizuki sent me a private message. I should introduce myself properly.",
    "night": "I'd like to spend more time with Mizuki. What should I suggest?",
    "guild_agreed": "Another game session with Mizuki. The plan is in Calendar; I'll pick this up later.",
    "private_agreed": "A postcard, just between us. I've kept the plan in Calendar for later.",
    "lives_agreed": "We might have a call. I need to check my work schedule first.",
    "guild_plan": "Our public party is making plans. Mizuki and I need to decide how to help.",
    "guild_event": "I've kept the messages from our small party. I'll check back later.",
    "guild_guide": "Our route guide is in the party thread. I'll check back later.",
    "private_photo": "Mizuki sent a photo and asked about working together. I should reply; I've kept her photo in Photos.",
    "private_event": "I've saved our postcard session. I'll check in after her deadline.",
    "private_rescheduled": "The new postcard date is in Calendar. I'll check in later.",
    "lives_work": "I need to arrange my handoff before confirming the call.",
    "lives_call": "Our first call. I want to remember this. We can talk about next time later.",
    "lives_reschedule": "We found time for that call after all. I'll check in later.",
    "guild_callback": "Mizuki suggested another game session. I've kept her message for later.",
    "private_callback": "Mizuki got back to me after her deadline. I've kept her message for later.",
    "lives_callback": "A possible trip. I should look over the dates in Calendar; nothing is booked yet.",
}
chapters = {1: "A Chance Encounter", 2: "How We Spend Our Time", 3: "Beyond the Username"}
for key, data in nodes.items():
    data["objective"] = string(f"{key}.objective", goals[key])
    data["chapter"] = data["day"]
    data["chapter_title"] = string(f"chapter.{data['day']}.title", chapters[data["day"]])

# Extend the stable opening into a complete six-act first draft.
from story_chapters import extend
acts = extend(nodes, strings, node, string)

# Sending commits an intention. A separate Later action enters any later-date scene.
from datetime import datetime
for key, data in list(nodes.items()):
    today = datetime.strptime('2026 ' + data['timestamp'], '%Y %a  %d %b     %H:%M').strftime('%m-%d')
    for i, choice in enumerate(data['choices']):
        destinations = [choice['to']] + [r['to'] for r in choice.get('routes', [])]
        if any(datetime.strptime('2026 ' + nodes[target]['timestamp'], '%Y %a  %d %b     %H:%M').strftime('%m-%d') != today for target in destinations):
            gate = f'wait__{key}__{i}'
            node(gate, 'A reply, then a little time', data['app'], data['day'],
                 [('system', 'Reply saved. The next scene takes place later. You can browse the site before choosing Later.')], later=choice['to'])
            nodes[gate].update(chapter=data['chapter'], chapter_title=data['chapter_title'],
                               thread=data['thread'], timestamp=data['timestamp'], interlude=True,
                               objective=string(f'{gate}.objective', 'I sent my reply. I can keep browsing before continuing to the next scene.'))
            if 'routes' in choice: nodes[gate]['later_routes'] = choice.pop('routes')
            choice['to'] = gate

out = Path(__file__).resolve().parents[1] / 'content' / 'opening.json'
out.parent.mkdir(exist_ok=True)
photos = {
 'finished_window': {'title': 'The corner she kept', 'copy': 'Mizuki\'s finished crooked-window illustration, kept privately beside Asahi\'s rainy Tokyo photograph.', 'kind': 'desk'},
 'showcase': {'title': 'Natsumi\'s showcase', 'copy': 'Prints on a shop wall, a step stool and a packet of hooks. The day and Asahi\'s actual participation remain in the message history.', 'kind': 'desk'},
 'approved_guide': {'title': 'The approved guide image', 'copy': 'A separate illustration, cleared of client details, credited to Mizuki. She explicitly approved this version for the route guide.', 'kind': 'lantern'},
 'private_pages': {'title': 'Two unfinished pages', 'copy': 'An imperfect drawing and a page with a rice stain. The collection is private; neither person approved publication.', 'kind': 'desk'},
 'first_afternoon': {'title': 'An afternoon in Sapporo', 'copy': 'Two tea cups on a scratched table, a scarf on an empty chair. Saved only after the first physical meeting actually happened.', 'kind': 'city'},
 'repair_cup': {'title': 'A smaller invitation', 'copy': 'A photograph of an ordinary cup. This limited private exchange does not reopen permission to share work drafts.', 'kind': 'desk'},
 'credited_print': {'title': 'The use she approved', 'copy': 'A printed route guide bearing Mizuki\'s credit, using only the image and layout she chose to approve.', 'kind': 'lantern'}
}
out.write_text(json.dumps({'strings': strings, 'nodes': nodes, 'photos': photos}, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')

# A reviewable, complete manuscript generated from the actual playable graph.
book = ['# The Next Hello: complete branching first draft', '',
        'Six acts, three activity paths, eight endings. This is the full playable first draft, with every authored line and choice; production pacing and final art remain to be reviewed.', '',
        'Read one branch at a time. Conditions below are authoring notes and never appear as scores in the interface. All scenes are presented as private messages, transcripts, photographs or saved notes.', '']
for act in range(1, 7):
    book += [f'## Act {act}: {acts[act]}', '']
    for key, data in nodes.items():
        if data['chapter'] != act or data.get('interlude'): continue
        book += [f'### {strings[data["title"]]}', f'ID: `{key}` · {data["timestamp"]} · {data["app"]} / {data["thread"]}', '']
        if data.get('decision'): book += [f'Major decision: **{data["decision"]}**', '']
        for line in data['lines']:
            book += [f'**{line["speaker"]}:** {strings[line["text"]]}' + (f' (only when {line["if"]})' if line.get('if') else ''), '']
        for choice in data['choices']:
            target = choice['to']
            if nodes[target].get('interlude'): target = nodes[target]['later']
            condition = f' (requires {choice["if"]})' if choice.get('if') else ''
            book += [f'- **Reply:** {strings[choice["text"]]}{condition} → `{target}`; records {choice["set"] or "no new fact"}.']
            for branch in choice.get('routes', []): book += [f'  - When {branch["if"]}: `{branch["to"]}`.']
        if data.get('later'): book += [f'**Later:** `{data["later"]}`.']
        for branch in data.get('later_routes', []): book += [f'- When {branch["if"]}: `{branch["to"]}`.']
        if data.get('ending'): book += [f'**Ending:** {data["ending"]["category"]} / {data["ending"]["id"]}.']
        book += ['']
root = out.parents[1]
(root / 'design' / 'STORY-SCRIPT.md').write_text('\n'.join(book) + '\n', encoding='utf-8')
authored = sum(not n.get('interlude') for n in nodes.values())
words = sum(len(v.split()) for v in strings.values())
print(f'Wrote {authored} authored scenes, {len(nodes) - authored} explicit time gates, {len(strings)} strings, {words} words, 8 endings')

from validate_content import audit
coverage = audit({'nodes': nodes, 'strings': strings}, root / 'tests' / 'story_paths.json')
(root / 'tests' / 'story_coverage.json').write_text(json.dumps(coverage, indent=2) + '\n', encoding='utf-8')
print(json.dumps(coverage))
