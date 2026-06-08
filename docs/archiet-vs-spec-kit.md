# Archiet / archiet-microcodegen vs GitHub Spec Kit

**Last updated: June 2026**

This is an honest comparison. [GitHub Spec Kit](https://github.com/github/spec-kit) is excellent at what it does. Archiet does something different — not better, not worse, **different layer of the stack**.

## One-sentence summary

| Tool | Role |
|------|------|
| **Spec Kit** | Teaches AI agents to implement from markdown specs **inside your repo** |
| **archiet-microcodegen** | **Compiles** a spec into a complete bootable application ZIP (deterministic, no LLM in codegen) |
| **Archiet (platform)** | Full PRD → genome → 15 stacks + frontend + mobile + compliance + delivery gates |

## Side-by-side

| Dimension | GitHub Spec Kit | archiet-microcodegen | Archiet platform |
|-----------|-----------------|----------------------|------------------|
| **Primary output** | Agent-edited files in your project | New app directory / ZIP | Multi-stack ZIP + handoff pack |
| **LLM in generation** | Yes (agent implements) | **No** | LLM only in PRD-parsing zone |
| **Reproducibility** | Agent-dependent | Byte-identical on regen | Deterministic lowering + gates |
| **IDE / agent required** | Yes (30+ agents) | No — pure CLI | Web UI + API |
| **Stacks** | Your existing stack | 10 CLIs (NestJS, Go, Java, …) | 15+ backend + Next.js + Expo |
| **Brownfield** | Yes (modify existing code) | No (greenfield regen) | Greenfield-first |
| **Compliance docs** | You write / agent drafts | Basic ARCHITECTURE.md | SOC 2, GDPR, HIPAA, ADRs, traceability |
| **Install** | `uv tool install specify-cli` | `pip install archiet-microcodegen` etc. | [archiet.com](https://archiet.com) |
| **License** | MIT | MIT | Commercial + free tier |
| **Stars / momentum** | 110k+ | Early | Early |

## When to use Spec Kit

- You have an **existing codebase** and want structured agent workflows
- You're adding features incrementally with Copilot, Claude Code, or Gemini CLI
- You want slash commands (`/speckit.specify`, `/speckit.plan`, …) in your editor
- You accept agent non-determinism in exchange for flexibility

## When to use archiet-microcodegen

- You're **starting a new product** and want a running app from a PRD file
- You need **reproducible** output (CI, audit, regulated environment)
- You want **offline / air-gapped** generation (no API keys)
- You want to **compare stacks** — same spec → NestJS vs Go vs FastAPI

## When to use Archiet (full platform)

- You need **frontend + mobile + compliance** in one ZIP
- Your PRD is messy prose (LLM extraction → customer-reviewed genome)
- You need **delivery gates** (shippability audit, boot test, consulting-grade docs)
- Enterprise: multi-tenant workspaces, billing, team collaboration

## Complementary workflow (not either/or)

Many teams will use **both**:

```
1. archiet-microcodegen or Archiet  →  greenfield app from PRD
2. Spec Kit + Cursor in that repo   →  iterate features with agents
3. Spec change in genome            →  regen affected layers (Archiet)
```

Spec Kit doesn't replace a compiler. A compiler doesn't replace agent-assisted iteration.

## Maturity placement

See [maturity-levels.md](./maturity-levels.md). Spec Kit is **Level 2 (Spec-Anchored)**. archiet-microcodegen is **Level 4 (Spec-to-Application)**.

## Links

- [Spec Kit repo](https://github.com/github/spec-kit)
- [Spec Kit docs](https://github.github.io/spec-kit/)
- [archiet-microcodegen (PyPI)](https://pypi.org/project/archiet-microcodegen/)
- [microcodegen.py algorithm](https://github.com/aniekanasuquookono-web/archiet/blob/main/scripts/microcodegen.py)
- [Archiet vs Kiro](https://archiet.com/archiet-vs-kiro)
