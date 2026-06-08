# Spec-Driven Development Maturity Levels

**Last updated: June 2026**

Not all "spec-driven" tools work the same way. This framework (extended from [cameronsjo/spec-compare](https://github.com/cameronsjo/spec-compare) and community SDD discussions) helps you pick the right layer.

## The four levels

### Level 1 — Spec-First (prompt discipline)

**Idea:** Write a spec before you prompt the agent.

| | |
|---|---|
| **LLM in codegen?** | Yes |
| **Spec persistence** | Often ephemeral (chat) |
| **Examples** | Superpowers, ad-hoc PRDs in Cursor |
| **Risk** | Spec drifts from code immediately |

### Level 2 — Spec-Anchored (agent workflow)

**Idea:** Spec files live in the repo; agents implement from them.

| | |
|---|---|
| **LLM in codegen?** | Yes |
| **Spec persistence** | `.speckit/`, `specs/`, constitution files |
| **Examples** | [GitHub Spec Kit](https://github.com/github/spec-kit), Kiro, BMad, GSD |
| **Strength** | Structured phases: specify → plan → tasks → implement |
| **Risk** | Agent variance — same spec, different implementations |

### Level 3 — Spec-as-Source (regeneration)

**Idea:** The spec is canonical; code is regenerated when the spec changes.

| | |
|---|---|
| **LLM in codegen?** | Yes (regen step) |
| **Spec persistence** | Formal spec store, often with versioning |
| **Examples** | Tessl, some OpenSpec workflows |
| **Strength** | Spec-code alignment enforced by regen |
| **Risk** | Still non-deterministic; regen can surprise |

### Level 4 — Spec-to-Application (deterministic compile)

**Idea:** The spec is a formal model; code is a **compiled artifact** via M2T (model-to-text).

| | |
|---|---|
| **LLM in codegen?** | **No** (LLM may parse prose → model upstream) |
| **Spec persistence** | Genome / manifest IR, version-controlled |
| **Examples** | **archiet-microcodegen**, MDA tooling, SCADE (embedded) |
| **Strength** | Same spec → same output; auditable; offline |
| **Trade-off** | Greenfield regen; ambiguous specs → simpler output, not guesses |

## Visual

```
Level 1   prompt + vague spec     →  agent writes code (varies)
Level 2   markdown spec in repo   →  agent writes code (varies)
Level 3   versioned spec          →  agent regens code (varies)
Level 4   formal model (genome)   →  compiler emits code (deterministic)
```

## Decision guide

| Your situation | Start at |
|----------------|----------|
| Solo dev, existing app, Copilot user | Level 2 — Spec Kit |
| New SaaS, need reproducible scaffold | Level 4 — archiet-microcodegen |
| Enterprise, compliance + multi-stack | Level 4 + [Archiet platform](https://archiet.com) |
| Exploring an idea in an afternoon | Level 1 is fine — just don't call it production |

## Why Level 4 matters for regulated teams

SOC 2, HIPAA, and DoD environments often require:

- **Reproducible builds** from declared inputs
- **Traceability** from requirement → code → test
- **Air-gapped** tooling (no LLM API in the critical path)

Level 2–3 tools struggle here because the LLM is in the generation path. Level 4 removes it.

## Related

- [What is spec-driven development?](./what-is-spec-driven-development.md)
- [Archiet vs Spec Kit](./archiet-vs-spec-kit.md)
- [spec-compare matrix](https://github.com/cameronsjo/spec-compare) (community tool comparison)
