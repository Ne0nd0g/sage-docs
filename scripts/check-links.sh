#!/usr/bin/env bash
# check-links.sh: verify every link in the documentation tree.
#
# Internal links (relative or root-absolute) must resolve to a file on disk and appear in
# docs.json navigation. External http(s) links must return a 2xx or 3xx response.
#
# Usage:  scripts/check-links.sh [--external-only|--internal-only] [--quick]
#         --quick skips the slow external probes (anchors and file existence still checked)
#
# Exit codes: 0 clean, 1 broken or unresolvable link found. Broken links are printed to stderr.
set -uo pipefail
cd "$(dirname "$0")/.."

# temp/ is git-ignored scratch (held-back drafts, screenshots under review), not part of the site.
pages="$(find . -name '*.mdx' -not -path './assets/*' -not -path './temp/*' | sort)"
if [ -z "$pages" ]; then
  echo "no MDX pages found" >&2; exit 1
fi

mode="${1:-all}"
fail=0
declare -a problems=()

# Strip fenced code blocks so links quoted as examples are not probed.
strip_fences() { awk '/^```/{f=!f; next} !f' "$1"; }

# Collect unique link targets: markdown ](...) plus href="..." from Mintlify components.
targets="$( { for p in $pages; do strip_fences "$p" | grep -ohE '\]\([!]?[^)]*\)' ; strip_fences "$p" | grep -ohE 'href="[^"]*"'; done; } \
  | sed -e 's/^\](//' -e 's/)$//' -e 's/^href="//' -e 's/"$//' \
  | sed -e 's/^!\[//' \
  | grep -v '^$' | sort -u )"

in_docs_json() {
  # "$1": repo-relative .mdx path without leading "./"
  local key="${1#./}"; key="${key%.mdx}"
  grep -q "\"${key}\"" docs.json
}

for t in $targets; do
  case "$t" in
    '#'*|'http://localhost'*|'{{'*|'{'*) continue ;;
    'mailto:'*) continue ;;
    http://*|https://*)
      [ "$mode" = --internal-only ] && continue
      if [ "$mode" = --quick ]; then continue; fi
      code=$(curl -sS -o /dev/null --max-time 20 -L -A 'sage-docs-linkcheck/1.0' -w '%{http_code}' "$t" 2>/dev/null)
      if [ "${code:0:1}" != 2 ] && [ "${code:0:1}" != 3 ]; then
        problems+=("external $code  $t"); fail=1
      fi
      ;;
    /*) # root-absolute: page anchors or asset paths
      path="${t%%#*}"
      resolved=""
      if [ -f ".$path" ]; then resolved=".$path"
      elif [ -f ".$path.mdx" ]; then resolved=".$path.mdx"
      elif [ -f ".$path/index.mdx" ]; then resolved=".$path/index.mdx"
      fi
      if [ -z "$resolved" ]; then
        problems+=("internal unresolved  $t"); fail=1
      elif [[ "$resolved" == *.mdx ]] && ! in_docs_json "${resolved#./}"; then
        problems+=("internal not in navigation  $t -> $resolved"); fail=1
      fi
      ;;
    *) # relative to the linking file's directory
      path="${t%%#*}"
      [ -n "$path" ] || continue
      target=""
      hits="$( { for p in $pages; do strip_fences "$p" | grep -qF "](${t})" && echo "$p"; done; } | head -1 )"
      [ -n "$hits" ] || hits="$( { for p in $pages; do strip_fences "$p" | grep -qF "href=\"$t\"" && echo "$p"; done; } | head -1 )"
      if [ -n "$hits" ]; then
        dir="$(dirname "$hits")"
        for cand in "$dir/$path" "$dir/$path.mdx" "$dir/$path/index.mdx"; do
          [ -f "$cand" ] && target="$cand" && break
        done
      fi
      if [ -z "$target" ]; then
        problems+=("relative unresolved  $t"); fail=1
      elif [[ "$target" == *.mdx ]] && ! in_docs_json "${target#./}"; then
        problems+=("relative not in navigation  $t -> $target"); fail=1
      fi
      ;;
  esac
done

if [ ${#problems[@]} -gt 0 ]; then
  printf '%s\n' "${problems[@]}" >&2
fi
if [ "$fail" -eq 1 ]; then
  echo "check-links: FAILED (${#problems[@]} problem(s))" >&2
else
  echo "check-links: OK ($(printf '%s\n' "$targets" | wc -l | tr -d ' ') links checked)"
fi
exit $fail
