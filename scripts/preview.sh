#!/usr/bin/env bash
# Start the Mintlify local preview for this repository.
#
#   ./scripts/preview.sh
#
# Serves the working tree as-is at http://localhost:3000 (or the next free
# port). Nothing needs to be committed to preview. Hot-reloads on save.
set -euo pipefail

cd "$(dirname "$0")/.."

command -v node >/dev/null 2>&1 || { echo "node is required (https://nodejs.org)"; exit 1; }

# Pin the Mintlify CLI version. A floating @latest tag breaks whenever a release ships
# with a dependency the registry has not fully propagated yet (observed 2026-10-27:
# mint@latest demanded @mintlify/og@0.0.106 before it was resolvable). Bump this pin
# deliberately, after checking the new version boots.
exec npx --yes mint@4.2.1131 dev
