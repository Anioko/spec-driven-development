# Spec-Driven Development in 2026: From Agent Prompts to Compiled Applications

> **Last updated: June 2026**  
> A practical guide to SDD maturity levels, how [GitHub Spec Kit](https://github.com/github/spec-kit) fits the landscape, and when you need a **spec compiler** instead of an **agent workflow**.

**Topics:** `spec-driven-development` · `spec-driven` · `prd` · `codegen` · `archimate` · `model-driven` · `opensource`

---

## What is spec-driven development?

**Spec-driven development (SDD)** is a methodology where every implementation decision traces back to a **formal or structured specification** — not a chat log, not "whatever the agent wrote last," and not tribal knowledge in someone's head.

The specification declares:

- **What** the system does (entities, workflows, APIs)
- **How** it must behave under constraints (auth, tenancy, compliance)
- **Why** key decisions were made (ADRs, architecture notes)

Code is an **output of the spec**, not the source of truth.

GitHub popularised the current wave in September 2025 with [Spec Kit](https://github.com/github/spec-kit) and their [blog post on SDD with AI](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/). Amazon's Kiro, Andrej Karpathy's "post-vibe-coding" thesis, and a flood of comparison articles followed. The term is ranking on Google, Perplexity, and GitHub search because teams hit a wall: **prompt-only AI is fast for demos and fragile for production.**

This guide explains **two tiers of SDD** most articles conflate, maps **four maturity levels**, and shows how to go from a PRD file to a **bootable application in one command** — no LLM in the generation step.

---

## Two tiers of SDD (don't conflate them)

| Tier | What it does | Best for | Example |
|------|--------------|----------|---------|
| **Agent workflow** | Spec files guide an AI agent to edit **your repo** | Features in existing codebases | GitHub Spec Kit, Kiro, BMad |
| **Spec compiler** | Spec is compiled into a **new application** | Greenfield products, reproducible scaffolds | archiet-microcodegen, Archiet |

**GitHub's line:** *"Specifications become executable."*  
**This repo's line:** *Executable specifications that **compile** to shippable apps — not agent edits in your repo.*

Both are spec-driven. They are not interchangeable.

→ [Full comparison: Archiet vs Spec Kit](docs/archiet-vs-spec-kit.md)

---

## SDD maturity levels (1–4)

| Level | Name | LLM writes code? | Examples |
|-------|------|------------------|----------|
| 1 | Spec-First | Yes | Ad-hoc PRDs + Cursor |
| 2 | Spec-Anchored | Yes | **Spec Kit**, Kiro, BMad |
| 3 | Spec-as-Source | Yes (regen) | Tessl, OpenSpec |
| 4 | **Spec-to-Application** | **No** | **archiet-microcodegen** |

Level 4 treats the spec as a **formal model** (genome). Code is emitted by deterministic **model-to-text (M2T)** transformation — the same discipline MDA, AUTOSAR, and SCADE have used for decades, now applied to web apps.

→ [Deep dive: maturity levels](docs/maturity-levels.md)

---

## Try it now (90 seconds)

```bash
git clone https://github.com/Anioko/spec-driven-development.git
cd spec-driven-development
chmod +x demo.sh && ./demo.sh          # FastAPI (default)
./demo.sh flask                        # Flask + SQLAlchemy
./demo.sh django                       # Django + DRF
./demo.sh nestjs                       # NestJS + TypeORM (requires Node 18+)
```

Or with PyPI only:

```bash
pip install archiet-microcodegen
archiet-microcodegen examples/sample-prd.md --out ./myapp/
cd myapp && docker compose up
# → http://localhost:8000/docs
```

**Input:** [`examples/sample-prd.md`](examples/sample-prd.md) — a 30-line task-manager PRD.  
**Output:** FastAPI + SQLAlchemy + Alembic + JWT auth + tests + `ARCHITECTURE.md` + `docker-compose.yml`.

Same PRD → same files. Every time. No API key.

---

## The four-stage pipeline

archiet-microcodegen implements Archiet's core algorithm (documented in [`scripts/microcodegen.py`](https://github.com/aniekanasuquookono-web/archiet/blob/main/scripts/microcodegen.py) in the main monorepo):

```
PRD text
  │
  ▼ parse_prd()              regex + heuristics → manifest (entities, stories, auth)
manifest
  │
  ▼ manifest_to_genome()     formal IR with ArchiMate 3.2 element typing
genome
  │
  ▼ render_genome()          string templates → {path: content}
files
  │
  ▼ pack()                   ZIP or --out directory
bootable app
```

**LLMs are allowed upstream** (turning messy prose into a manifest). **LLMs are forbidden in the lowering step** — once you have a genome, emission is deterministic. That boundary is what makes output auditable.

---

## Multi-stack: same spec, different ecosystems

The FastAPI package is one entry point. The same pipeline ships per ecosystem:

| Stack | Install |
|-------|---------|
| FastAPI | `pip install archiet-microcodegen` |
| Flask | `pip install archiet-microcodegen-flask` |
| Django | `pip install archiet-microcodegen-django` |
| NestJS | `npx archiet-microcodegen-nestjs` |
| Go (Chi) | `go install github.com/aniekanasuquookono-web/archiet-microcodegen-go@latest` |
| Laravel | `composer global require archiet/microcodegen-laravel` |
| Spring Boot | `java -jar archiet-microcodegen-java.jar` |
| Rails | `gem install archiet-microcodegen-rails` |
| .NET | `dotnet tool install archiet-microcodegen-dotnet -g` |
| Tauri + Rust | `cargo install archiet-microcodegen-tauri` |

Generate the same PRD in three stacks. Compare structure. Pick one. No vendor IDE required.

---

## Spec Kit vs archiet-microcodegen (honest)

| | GitHub Spec Kit | archiet-microcodegen |
|---|-----------------|----------------------|
| **You get** | Agent implements tasks in your project | New app directory / ZIP |
| **Determinism** | Agent-dependent | Same spec → same output |
| **Offline** | Needs agent + network | Runs air-gapped |
| **Brownfield** | ✅ | ❌ (greenfield regen) |
| **Compliance pack** | DIY | Basic ARCHITECTURE.md; full pack on [Archiet](https://archiet.com) |

**Use Spec Kit** when you live in Cursor/Copilot and ship incremental features.  
**Use archiet-microcodegen** when you need a **reproducible greenfield app** from a requirements file.

Many teams use both: compile the scaffold, then Spec Kit for iteration.

---

## When you need the full Archiet platform

[archiet.com](https://archiet.com/spec-driven-development?utm_source=github&utm_medium=readme&utm_campaign=sdd-guide) adds:

- **LLM PRD extraction** with customer-reviewed genome
- **15+ backend stacks** + Next.js + Expo from one spec
- **Delivery gates** — shippability audit, synthetic boot test, consulting-grade `ARCHITECTURE.md`
- **Compliance artifacts** — SOC 2, GDPR, HIPAA, PCI, DORA, NIS2 derived from the same model
- **Traceability matrix** — requirement → entity → route → test → ADR

The open-source CLIs are the **algorithm**. The platform is the **efficiency layer** on top.

---

## FAQ

### Is this the same as GitHub Spec Kit?

No. Spec Kit structures **agent workflows** in your repo (`/speckit.specify`, `/speckit.plan`, …). archiet-microcodegen **compiles** a spec into a new application without an LLM in the codegen path. Complementary, not competing.

### Does spec-driven development require AI?

No. Level 4 SDD is **deterministic**. AI helps parse messy PRDs (Level 1–2). The generation step can be pure M2T.

### Can I use this in regulated environments?

Level 4 is designed for reproducibility and air-gapped use. No LLM API in the critical path. Full compliance narratives require the [Archiet platform](https://archiet.com).

### What about vibe coding?

Vibe coding optimises for speed-to-demo. SDD optimises for **speed-to-production** — migrations, auth patterns, architecture docs, traceability. Karpathy's Feb 2026 post marked the cultural shift; Spec Kit gave it tooling.

### Where does ArchiMate fit?

The genome uses ArchiMate 3.2 element typing (ApplicationComponent, DataObject, ApplicationService, …). Every generated `ARCHITECTURE.md` maps code artifacts back to the formal model.

### How is this different from JHipster / Nest CLI scaffolds?

Scaffolds emit empty structure. This pipeline emits **entity-specific** CRUD, auth, migrations, tests, and OpenAPI from your PRD content — and regenerates when the spec changes.

---

## Repository map

| Path | Purpose |
|------|---------|
| [`examples/sample-prd.md`](examples/sample-prd.md) | Copy-paste PRD for demos |
| [`demo.sh`](demo.sh) | One-command PRD → running app |
| [`docs/what-is-spec-driven-development.md`](docs/what-is-spec-driven-development.md) | Short canonical explainer |
| [`docs/archiet-vs-spec-kit.md`](docs/archiet-vs-spec-kit.md) | Comparison page |
| [`docs/maturity-levels.md`](docs/maturity-levels.md) | Levels 1–4 framework |

---

## Links

- **Compliance guide:** [github.com/Anioko/compliance-from-architecture](https://github.com/Anioko/compliance-from-architecture) — three layers (Vanta/Drata vs codegen), EU AI Act
- **Full platform:** [archiet.com/spec-driven-development](https://archiet.com/spec-driven-development?utm_source=github&utm_medium=readme&utm_campaign=sdd-guide)
- **Algorithm source:** [github.com/aniekanasuquookono-web/archiet](https://github.com/aniekanasuquookono-web/archiet) (`scripts/microcodegen.py`)
- **PyPI:** [archiet-microcodegen](https://pypi.org/project/archiet-microcodegen/)
- **Dev.to walkthrough:** [Spec-Driven Development Without an IDE](https://dev.to/anioko1/spec-driven-development-without-an-ide-i-generated-nestjs-go-spring-boot-laravel-and-rust-3p26)
- **Community comparison:** [cameronsjo/spec-compare](https://github.com/cameronsjo/spec-compare)
- **Spec Kit:** [github.com/github/spec-kit](https://github.com/github/spec-kit)

---

## License

MIT — see [LICENSE](LICENSE).

---

*Maintained by [Aniekan Asuquo Okono](https://archiet.com). Contributions welcome: comparison corrections, new ecosystem packages, maturity-level examples.*
