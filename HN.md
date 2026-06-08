# Hacker News — Show HN playbook

Use this for the **relaunch**. Do not repost the flagged Ask HN.

## Title (submit exactly)

```
Show HN: Same PRD → bootable FastAPI app, zero LLM calls (600-line Python)
```

Alternative if multi-stack is the hook:

```
Show HN: Same PRD → 9 bootable apps, zero LLM calls (deterministic M2T)
```

## URL

```
https://github.com/Anioko/spec-driven-development
```

Not archiet.com. Not Ask HN.

## First comment (post within 2 minutes)

```
Hi HN — I'm Aniekan, author.

I kept getting different code every time I re-prompted LLM codegen tools on the
same requirements. For production work that's a bug, not a feature.

So I extracted Archiet's core algorithm into a single deterministic pipeline:
  PRD text → manifest → genome → FastAPI app → ZIP
No LLM in the generation step. Same file in, same files out.

Try it:
  pip install archiet-microcodegen
  git clone https://github.com/Anioko/spec-driven-development
  cd spec-driven-development && ./demo.sh

The repo also documents where this sits vs GitHub Spec Kit — Spec Kit teaches
agents to follow specs in your repo; this compiles the spec into a new app.

Happy to answer questions on the pipeline, why I banned LLMs from M2T, or the
ArchiMate genome IR.
```

## Second comment (only if asked about SaaS)

```
Full platform (15 stacks, frontend, mobile, compliance gates) is at archiet.com —
the open-source CLI is the algorithm slice, not a teaser.
```

## Timing

- **Tuesday or Wednesday, 8–9am Pacific**
- Block 2 hours for comments
- Do not cross-post Ask HN the same week

## Pre-launch karma (3–5 days before)

Leave 5–8 substantive comments on Spec Kit / SDD / vibe-coding threads. No links in early comments.

## Demo asset

Record asciinema before launch:

```bash
asciinema rec demo.cast -c "./demo.sh"
```

Embed in README: `[![Demo](https://asciinema.org/a/XXXXXX.svg)](https://asciinema.org/a/XXXXXX)`

## What failed before (do not repeat)

| Post | Problem |
|------|---------|
| Ask HN: Is SDD fixing vibe coding? | Flagged — market-research bait, no artifact |
| Show HN: microcodegen.py one file | 3 pts — no instant demo, buried hook |
