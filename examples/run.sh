#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_forge_mastery info
PYTHONPATH=src python -m gbt_forge_mastery check --payload '{}'
PYTHONPATH=src python -m gbt_forge_mastery run   --payload '{}'
