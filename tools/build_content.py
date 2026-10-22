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


node("invite", "01 / Party invite", "Lantern Quest", 1, [
    ("mossbyte", "One spot left for the garden run. asahi, meet mizuki. She knows the way. Mostly."),
    ("mizuki", "That was ONE bridge."),
    ("mizuki", "Hey, asahi. I'll carry the lantern if you keep an eye on the path?")], [
    ("Deal. Slow and steady. I'd like to see the garden.", "bridge", {"role": "lookout"}),
    ("I'll take the lantern. You can stop me walking into things.", "bridge", {"role": "lantern"})])

node("bridge", "The crooked bridge", "Lantern Quest", 1, [
    ("system", "A stone bridge crosses the dark water. A second lantern flickers on the far bank."),
    ("mizuki", "The shortcut is probably safe. Which is what I said last time."),
    ("mossbyte", "Can confirm. Very damp evening.")], [
    ("Let's light the stepping stones. I'll wait for you.", "first_dm", {"garden_memory": "stones"}),
    ("Want to try the bridge together? We can be damp legends.", "splash", {"garden_memory": "splash"})])

node("splash", "A small detour", "Lantern Quest", 1, [
    ("system", "The bridge folds into the water. Two tiny characters respawn under the same leaf."),
    ("mizuki", "Well. The leaf is nice."),
    ("mossbyte", "Screenshot saved. For historical purposes.")], [
    ("Next time, we take the stones. Keeping the screenshot though.", "first_dm", {})])

node("first_dm", "A new conversation", "Messages", 1, [
    ("system", "Lantern garden screenshot added to Gallery. A private message arrives from mizuki."),
    ("mizuki", "Thanks for waiting back there. Most people just run to the reward."),
    ("mizuki", "I'm Mizuki, by the way. In Sapporo. Currently losing a fight with a cup noodle lid.")], [
    ("Asahi. Tokyo. Put a book on it. Finally, a use for my unread pile.", "night", {"intro": "books"}),
    ("Asahi. Tokyo. Glad I'm not the only one having a heroic evening.", "night", {"intro": "heroic"})], facts={"screenshot": True})

node("night", "A little after eleven", "Messages", 1, [
    ("mizuki", "The lid has surrendered. Nice to meet you, Asahi."),
    ("mizuki", "I draw for work. Today I drew the same window six times. The garden was a good change."),
    ("mizuki", "I'd like to do something again, if you would. Doesn't have to be the game.")], [
    ("Let's help with Daichi's guild garden this weekend. Together?", "guild_agreed", {"path": "guild"}),
    ("Want to swap window photos? Maybe make something small together.", "private_agreed", {"path": "private"}),
    ("I'd like to know your everyday life. A call, when we're both free?", "lives_agreed", {"path": "lives"})])

node("guild_agreed", "One more party", "Messages", 1, [
    ("mizuki", "Yes. But if Daichi asks us to lead all twelve people, we're negotiating."),
    ("system", "Saturday's guild garden is in Calendar. Daichi will open a planning thread tomorrow.")], later="guild_plan", facts={"commitment": "Saturday / Guild garden with Mizuki", "memory": "A second party invite"})

node("private_agreed", "Two windows", "Messages", 1, [
    ("mizuki", "I'd like that. Two cities, two windows. Maybe a little illustrated postcard?"),
    ("mizuki", "Just between us for now. Rough work makes me shy."),
    ("system", "A private photo exchange is in Calendar. Mizuki will send her desk photo tomorrow.")], later="private_photo", facts={"commitment": "Saturday / Private postcard session", "memory": "Two cities, two windows", "photo_permission": "private"})

node("lives_agreed", "Beyond the username", "Messages", 1, [
    ("mizuki", "A call sounds good. Sunday afternoon? My sister's helping me move a shelf Saturday."),
    ("mizuki", "Fair warning: my everyday life contains a lot of arguing with furniture."),
    ("system", "Sunday's call is in Calendar. Tomorrow, check your work schedule before confirming.")], later="lives_work", facts={"commitment": "Sunday / Call with Mizuki (proposed)", "memory": "A voice beyond the game"})

node("guild_plan", "02 / A garden for everyone", "Lantern Quest", 2, [
    ("mossbyte", "Slight complication. New players signed up. Could you two lead separate groups?"),
    ("mizuki", "I was looking forward to playing together. Could we guide one small group instead?")], [
    ("One small group. We'll show them the safe route together.", "guild_event", {"guild_plan": "small group"}),
    ("Let's make a route guide tonight, then let someone else lead.", "guild_guide", {"guild_plan": "route guide"})])
node("guild_event", "Lanterns in the rain", "Lantern Quest", 2, [
    ("system", "You and Mizuki bring three new players through the garden. At the bridge, everyone waits."),
    ("mizuki", "Look at that. A whole party that doesn't leave anyone behind."),
    ("mossbyte", "I'm keeping the group small next week too. Thanks for saying something.")], later="guild_callback", facts={"guild_event": "guided newcomers"})
node("guild_guide", "A map with a warning", "Lantern Quest", 2, [
    ("system", "You mark safe stones while Mizuki draws a tiny skull on the crooked bridge. A newcomer volunteers to guide."),
    ("mizuki", "Our first joint publication. Please credit the skull artist."),
    ("mossbyte", "Pinned the guide. You two can just play tonight.")], later="guild_callback", facts={"guild_event": "published route guide"})
node("guild_callback", "03 / The next invitation", "Messages", 3, [
    ("mizuki", "Daichi asked before adding people this time. I think we started something."),
    ("mizuki", "Next Saturday, same garden? I'd like a little time with just you after."),
    ("system", "Opening complete. Your shared guild activity has opened a small-party invitation and a private after-game conversation. The collaboration and visit-preparation scenes belong to other paths.")], facts={"available_events": ["small_party", "after_game_chat"]})

node("private_photo", "02 / The mug has a new job", "Messages", 2, [
    ("system", "Mizuki shared a private desk photo. Open Gallery to inspect it or read this description: pens in a mug, a half-finished illustration on a laptop, rain against the window."),
    ("mizuki", "Window attempt seven. Application deadline Monday. Please keep this one between us.")], [
    ("Want quiet company while we make the postcard? We can leave it unfinished.", "private_event", {"collaboration": "quiet company"}),
    ("Let's move our postcard session until after your deadline. I'll send my photo now.", "private_rescheduled", {"collaboration": "rescheduled"})], facts={"desk_photo": True})
node("private_event", "A room in two cities", "Messages", 2, [
    ("system", "Resonance plays softly. You send your rainy Tokyo window; Mizuki sends a small line drawing in return. Neither of you posts it."),
    ("mizuki", "I finished the corner I was stuck on. Quiet company works, apparently."),
    ("system", "A private postcard joins Gallery. Mizuki keeps working on her application.")], later="private_callback", facts={"postcard": True})
node("private_rescheduled", "Room to finish", "Messages", 2, [
    ("mizuki", "Thank you. Tuesday evening? I want to do this when I'm not watching a deadline."),
    ("system", "You share the Tokyo window privately. The postcard session moves to Tuesday; tonight Mizuki works on her application."),
    ("mizuki", "Your window has good rain. Keeping that photo.")], later="private_callback", facts={"commitment": "Tuesday / Private postcard session"})
node("private_callback", "03 / After the deadline", "Messages", 3, [
    ("mizuki", "Submitted. I checked the attachment three times. Four if we're being honest."),
    ("mizuki", "Can I show you the finished illustration? And I found a short story we could read together."),
    ("system", "Opening complete. Your private activity has opened an illustration follow-up and a buddy-read invitation. The guild leadership and visit-preparation scenes belong to other paths.")], facts={"available_events": ["illustration_followup", "buddy_read"]})

node("lives_work", "02 / Making room", "Desk", 2, [
    ("team", "Monday's handoff needs a check. You can finish Friday afternoon or take the Sunday review. Both are fine; tell me which."),
    ("system", "Mizuki's proposed call is Sunday afternoon. Friday work is available; taking Sunday means explicitly rescheduling the call.")], [
    ("I'll do the Friday check so Sunday stays free.", "lives_call", {"work": "Friday handoff", "commitment": "Sunday / Call with Mizuki (confirmed)"}),
    ("I'll take Sunday. I'll ask Mizuki about another call time before confirming.", "lives_reschedule", {"work": "Sunday review", "commitment": "Monday / Call with Mizuki (confirmed)"})])
node("lives_call", "A shelf, assembled", "Messages", 2, [
    ("system", "Sunday afternoon. A call transcript opens after your completed Friday handoff."),
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
    ("system", "Opening complete. Your call has opened a leave discussion and an everyday-friends introduction. The guild project and private postcard scenes belong to other paths.")], facts={"available_events": ["leave_discussion", "friends_introduction"], "meeting_plan": "discussing"})

out = Path(__file__).resolve().parents[1] / "content" / "opening.json"
out.parent.mkdir(exist_ok=True)
out.write_text(json.dumps({"strings": strings, "nodes": nodes}, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
print(f"Wrote {len(nodes)} nodes and {len(strings)} strings")
