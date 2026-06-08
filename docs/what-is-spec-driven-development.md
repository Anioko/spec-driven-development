# What is Spec-Driven Development?

**Last updated: June 2026**

Spec-driven development (SDD) is a software methodology where **the specification is the source of truth** — not the prompt history, not the current codebase, and not an agent's memory of what you asked for last Tuesday.

In SDD you:

1. **Declare** what the system must do (requirements, entities, workflows, constraints).
2. **Encode** that declaration in a structured, version-controlled artifact (markdown spec, formal model, or genome).
3. **Generate or implement** from that artifact so every line of code traces back to a requirement.

The goal is predictable outcomes: when compliance changes, you change the spec and regenerate. When a new engineer joins, they read the spec — not reverse-engineer the repo.

## SDD vs vibe coding

| | Vibe coding | Spec-driven development |
|---|---|---|
| Input | Natural-language prompts | Formal or structured specification |
| Memory | Conversation context | Version-controlled spec file |
| Reproducibility | Low — re-prompt gives different code | High — same spec → same structure |
| Compliance | Usually omitted | Declared in spec, emitted in output |
| Best for | Fast prototypes | Systems you maintain and audit |

## SDD vs "just write good prompts"

Better prompts help. SDD goes further: the spec **outlives** the session. Agents forget; specs don't.

[GitHub Spec Kit](https://github.com/github/spec-kit) popularised this for AI-assisted feature work: constitution → specify → plan → tasks → implement. That is SDD **inside your repository**, with an agent as the implementer.

**archiet-microcodegen** represents a different layer: the spec is compiled into a **complete bootable application** via deterministic model-to-text transformation — no LLM in the generation step.

Both are spec-driven. They solve different problems.

## Who coined the current wave?

- **GitHub** (Sept 2025): [Spec Kit + SDD blog post](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)
- **Amazon Kiro** (2025): IDE-native spec workflows
- **Andrej Karpathy** (Feb 2026): argued the vibe-coding era is giving way to spec-first engineering

The term is having a moment because teams hit the ceiling of prompt-only AI: fast demos, fragile production.

## Further reading

- [SDD maturity levels](./maturity-levels.md)
- [Archiet vs GitHub Spec Kit](./archiet-vs-spec-kit.md)
- [Main guide (README)](../README.md)
- [Archiet platform](https://archiet.com/spec-driven-development?utm_source=github&utm_medium=docs&utm_campaign=sdd-guide)
