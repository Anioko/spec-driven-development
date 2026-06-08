#!/usr/bin/env bash
# demo.sh — PRD → bootable FastAPI app in under 2 minutes (no LLM, no API key)
# Usage: ./demo.sh
# Requires: Python 3.10+, pip, Docker (optional — for docker compose up)

set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
PRD="${ROOT}/examples/sample-prd.md"
OUT="${ROOT}/.demo-output"

echo "==> Spec-driven development demo"
echo "    PRD: ${PRD}"
echo ""

# Prefer pip package; fall back to monorepo script if cloned alongside archiet
if command -v archiet-microcodegen >/dev/null 2>&1; then
  GEN="archiet-microcodegen"
elif python3 -c "import archiet_microcodegen" 2>/dev/null; then
  GEN="python3 -m archiet_microcodegen"
elif [ -f "${ROOT}/../scripts/microcodegen.py" ]; then
  GEN="python3 ${ROOT}/../scripts/microcodegen.py"
else
  echo "Installing archiet-microcodegen from PyPI..."
  pip install -q archiet-microcodegen
  GEN="archiet-microcodegen"
fi

rm -rf "${OUT}"
mkdir -p "${OUT}"

echo "==> Stage 1–4: parse_prd → genome → render → pack"
${GEN} "${PRD}" --out "${OUT}/"

echo ""
echo "==> Generated $(find "${OUT}" -type f | wc -l | tr -d ' ') files"
echo "    Key outputs:"
ls -1 "${OUT}" | head -12 | sed 's/^/      /'
echo ""

if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
  echo "==> Starting docker compose (Postgres + API)..."
  (cd "${OUT}" && docker compose up -d --build 2>/dev/null || docker compose up -d)
  echo ""
  echo "    Open http://localhost:8000/docs when healthy"
  echo "    Stop: cd ${OUT} && docker compose down"
else
  echo "==> Docker not available — inspect files in: ${OUT}"
  echo "    Manual run: cd ${OUT} && pip install -r requirements.txt && uvicorn main:app --reload"
fi

echo ""
echo "Done. Same PRD → same files every time (deterministic M2T)."
