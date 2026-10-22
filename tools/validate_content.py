"""Exhaustive decision-state audit; emits compact paths for the Godot runner."""
import json
from collections import deque
from pathlib import Path


def audit(book, output):
    nodes, strings = book['nodes'], book['strings']
    graph = {}
    needed = {}
    for key, n in nodes.items():
        graph[key] = set()
        needed[key] = {"path"}
        assert n['app'] in ['Messages','Games','Work','Photos','Calendar','Notes','Settings'], key
        assert n['objective'] in strings and n['chapter_title'] in strings
        for rule in n.get('fact_rules', []): needed[key].update(rule.get('if', {}))
        for line in n['lines']:
            assert line['text'] in strings
            needed[key].update(line.get('if', {}))
        for item, field in [(c, 'to') for c in n['choices']] + ([(n, 'later')] if n.get('later') else []):
            graph[key].add(item[field])
            needed[key].update(item.get('if', {}) if field == 'to' else {})
            for branch in item.get('routes' if field == 'to' else 'later_routes', []):
                graph[key].add(branch['to'])
                needed[key].update(branch.get('if', {}))
        assert all(target in nodes for target in graph[key]), key
        assert n['choices'] or n.get('later') or n.get('ending'), f'Non-ending dead end: {key}'
    while True:
        changed = False
        for key in nodes:
            expanded = needed[key].union(*(needed[c] for c in graph[key]))
            if expanded != needed[key]: needed[key] = expanded; changed = True
        if not changed: break
    def matches(facts, conditions): return all(facts.get(k) == v for k,v in conditions.items())
    def target(item, field, facts):
        return next((r['to'] for r in item.get('routes' if field == 'to' else 'later_routes', []) if matches(facts,r.get('if',{}))), item[field])
    queue = deque([('invite', {}, [])])
    visited, seen_nodes, fixtures, endings, transitions = set(), set(), [], {}, set()
    while queue:
        key, facts, steps = queue.popleft()
        n = nodes[key]
        facts = {**facts, **n.get('set', {})}
        for rule in n.get('fact_rules', []):
            if matches(facts, rule['if']): facts.update(rule['set']); break
        signature = key, tuple((k, json.dumps(facts.get(k),sort_keys=True)) for k in sorted(needed[key]))
        if signature in visited: continue
        visited.add(signature)
        if key not in seen_nodes:
            fixtures.append({'name': 'node:' + key, 'steps': steps, 'node': key})
            seen_nodes.add(key)
        if n.get('ending'):
            ending, path = n['ending']['id'], facts['path']
            assert not (ending in ['together','distance','everyday','friendship'] and facts.get('rupture')), (ending,facts)
            assert ending != 'together' or facts.get('meeting_plan') == 'completed'
            assert ending != 'distance' or facts.get('meeting_plan') == 'postponed'
            assert ending not in ['together','distance','everyday','friendship'] or facts.get('future_plan') == 'workable'
            assert ending != 'friendship' or facts.get('relationship_mode') == 'friends'
            assert ending != 'open' or facts.get('future_plan') == 'explicitly_undecided'
            assert ending != 'burnout' or (facts.get('work_broken') and facts.get('resolution') == 'burnout')
            assert ending != 'unsaid' or facts.get('resolution') == 'refused_repair'
            assert ending != 'everyday' or all(facts.get(k) for k in ['ritual','ritual_kept','ritual_renewed'])
            if (ending,path) not in endings:
                fixture={'name': f'ending:{ending}:{path}', 'steps':steps, 'node':key, 'ending':ending}
                fixtures.append(fixture); endings[ending,path]=fixture
            continue
        offered = [c for c in n['choices'] if matches(facts,c.get('if',{}))]
        assert offered or n.get('later'), f'Conditional dead end: {key} {facts}'
        for c in offered:
            updated={**facts, **c.get('set',{})}
            dest=target(c,'to',updated)
            transitions.add((key,c['id'],dest))
            queue.append((dest,updated,steps+[c['id']]))
        if n.get('later'):
            dest=target(n,'later',facts)
            transitions.add((key,'later',dest))
            queue.append((dest,facts,steps+['later']))
    assert seen_nodes == set(nodes), f'Unreachable nodes: {set(nodes)-seen_nodes}'
    expected={'together','distance','friendship','goodbye','unsaid','burnout','open','everyday'}
    for path in ['guild','private','lives']:
        assert {ending for ending,p in endings if p==path} == expected, f'Missing endings on {path}'
    # Real later-event differences for the privacy and friendship commitments.
    for key in ['approved_workshop','private_second_page','canceled_workshop','licensed_update','private_update','boundary_followthrough',
                'friend_confidant','local_dinner','studio_lunch','studio_preview','friend_update','early_arrival','return_tokyo','late_arrival','distance_agreement']:
        assert key in seen_nodes
    output.write_text(json.dumps(fixtures,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    return {'decision_states':len(visited), 'nodes':len(seen_nodes), 'transitions':len(transitions), 'ending_paths':len(endings), 'fixtures':len(fixtures)}

if __name__ == '__main__':
    root=Path(__file__).resolve().parents[1]
    print(json.dumps(audit(json.loads((root/'content/opening.json').read_text(encoding='utf-8')),root/'tests/story_paths.json')))

