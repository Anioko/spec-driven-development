#!/usr/bin/env bash
# demo.sh — PRD → bootable app in under 2 minutes (no LLM, no API key)
# Usage:
#   ./demo.sh              # FastAPI (default)
#   ./demo.sh fastapi
#   ./demo.sh flask
#   ./demo.sh django
#   ./demo.sh nestjs
# Requires: Python 3.10+ (flask/django/fastapi), Node 18+ (nestjs), pip, Docker (optional)

set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
PRD="${ROOT}/examples/sample-prd.md"
OUT="${ROOT}/.demo-output"
STACK="${1:-fastapi}"

ensure_pip_pkg() {
  local pkg="$1"
  local cmd="$2"
  if command -v "${cmd}" >/dev/null 2>&1; then
    echo "${cmd}"
  elif python3 -c "import ${pkg//-/_}" 2>/dev/null; then
    echo "python3 -m ${pkg//-/_}"
  else
    echo "Installing ${pkg} from PyPI..."
    pip install -q "${pkg}"
    echo "${cmd}"
  fi
}

resolve_generator() {
  case "${STACK}" in
    fastapi)
      if command -v archiet-microcodegen >/dev/null 2>&1; then
        echo "archiet-microcodegen"
      elif python3 -c "import archiet_microcodegen" 2>/dev/null; then
        echo "python3 -m archiet_microcodegen"
      elif [ -f "${ROOT}/../scripts/microcodegen.py" ]; then
        echo "python3 ${ROOT}/../scripts/microcodegen.py"
      else
        ensure_pip_pkg "archiet-microcodegen" "archiet-microcodegen"
      fi
      ;;
    flask)
      ensure_pip_pkg "archiet-microcodegen-flask" "archiet-microcodegen-flask"
      ;;
    django)
      ensure_pip_pkg "archiet-microcodegen-django" "archiet-microcodegen-django"
      ;;
    nestjs)
      if command -v archiet-microcodegen-nestjs >/dev/null 2>&1; then
        echo "archiet-microcodegen-nestjs"
      elif command -v npx >/dev/null 2>&1; then
        echo "npx --yes archiet-microcodegen-nestjs"
      else
        echo "ERROR: nestjs stack requires Node 18+ and npx" >&2
        exit 1
      fi
      ;;
    *)
      echo "ERROR: unknown stack '${STACK}'. Supported: fastapi, flask, django, nestjs" >&2
      exit 1
      ;;
  esac
}

GEN="$(resolve_generator)"

echo "==> Spec-driven development demo (stack: ${STACK})"
echo "    PRD: ${PRD}"
echo "    Generator: ${GEN}"
echo ""

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
  echo "==> Starting docker compose (if present)..."
  if [ -f "${OUT}/docker-compose.yml" ]; then
    (cd "${OUT}" && docker compose up -d --build 2>/dev/null || docker compose up -d)
    case "${STACK}" in
      fastapi) echo "    Open http://localhost:8000/docs when healthy" ;;
      flask)   echo "    Open http://localhost:5000 when healthy" ;;
      django)  echo "    Open http://localhost:8000 when healthy" ;;
      nestjs)  echo "    Open http://localhost:3000/api when healthy" ;;
    esac
    echo "    Stop: cd ${OUT} && docker compose down"
  else
    echo "    No docker-compose.yml in output — inspect files in: ${OUT}"
  fi
else
  echo "==> Docker not available — inspect files in: ${OUT}"
  case "${STACK}" in
    fastapi)
      echo "    Manual run: cd ${OUT} && pip install -r requirements.txt && uvicorn main:app --reload"
      ;;
    flask)
      echo "    Manual run: cd ${OUT} && pip install -r requirements.txt && flask run"
      ;;
    django)
      echo "    Manual run: cd ${OUT} && pip install -r requirements.txt && python manage.py runserver"
      ;;
    nestjs)
      echo "    Manual run: cd ${OUT} && npm install && npm run start:dev"
      ;;
  esac
fi

echo ""
echo "Done. Same PRD → same files every time (deterministic M2T)."
