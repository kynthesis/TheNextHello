"""Compile native Dialogue Manager sources, then rebuild the review manuscript and branch audit."""
import json
import subprocess
import shutil
import os
from pathlib import Path
root = Path(__file__).resolve().parents[1]
environment = dict(os.environ, APPDATA=str(root / '.local/qa/appdata'), LOCALAPPDATA=str(root / '.local/qa/localappdata'))
subprocess.run([shutil.which('godot') or 'godot', '--headless', '--path', str(root), '--script', 'res://tools/compile_dialogue.gd'], check=True, env=environment)
out = root / 'content' / 'opening.json'
data = json.loads(out.read_text(encoding='utf-8'))
nodes, strings = data['nodes'], data['strings']
# A reviewable, complete manuscript generated from the actual playable graph.
book = ['# The Next Hello: complete branching first draft', '',
        'Six acts, three activity paths, eight endings. This is the full playable first draft, with every authored line and choice; production pacing and final art remain to be reviewed.', '',
        'Read one branch at a time. Conditions below are authoring notes and never appear as scores in the interface. All scenes are presented as private messages, transcripts, photographs or saved notes.', '']
acts = {n["chapter"]: strings[n["chapter_title"]] for n in nodes.values()}
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
