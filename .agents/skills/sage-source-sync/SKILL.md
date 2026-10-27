---
name: sage-source-sync
description: >-
  Re-verify the documentation tree against a new Sage revision (tag or mirror HEAD): diff the
  recorded currency baseline in SAGE_CURRENCY.md against fresh Sage source, route changed files
  to affected pages via the source map, and update the affected pages plus the currency record.
  Uncommitted output only. USE WHEN sage source sync, sync docs with sage, new sage release,
  sage tag released, docs out of date with source, verify docs against new version, refresh
  currency. NOT FOR writing brand-new pages from scratch (propose those through the normal
  outline flow), style or link checking in isolation (see STYLE.md and scripts/check-links.sh),
  or production decisions about Sage itself.
---

# Sage Source Sync

Keeps the documentation tree honest against Sage source across releases. The currency baseline
lives in tracked `SAGE_CURRENCY.md`; the skill reads it, diffs fresh Sage source against it, and
produces uncommitted edits for review.

## Step 1: Resolve the Sage mirror

In order; stop at the first that works:

1. `SAGE_REPO_PATH` environment variable, if set and valid.
2. The path documented in this host's `AGENTS.local.md` (maintainer hosts only).

Never guess a checkout location by directory name. If neither resolves, stop and report that
`SAGE_REPO_PATH` is unset: the docs tree cannot be verified on a host without the Sage mirror
(public GitHub alone is not a substitute; the mirror is the working reference). Offer the exact
step: clone the Sage repo and export `SAGE_REPO_PATH` pointing at it.

## Step 2: Refresh and diff

1. `git -C <mirror> status --porcelain`. If the working tree is dirty, note it in the report and
   proceed only against committed state.
2. `git -C <mirror> fetch --tags --quiet`, then `git -C <mirror> tag --sort=creatordate` and
   `git -C <mirror> log --oneline -5`.
3. Read `SAGE_CURRENCY.md` for the baseline commit.
4. Compute the delta:
   - If one or more new tags landed after the baseline: `git log --stat <baseline>..<new_tag>`
     (or `..HEAD` when HEAD is between tags, and record that fact).
   - If HEAD is unchanged and no new tags exist, the currency is current; report that in one line
     and stop.
5. Keep the diff bounded: `--stat` first, then full diffs only for files that hit the source map
   or plausibly touch documented behavior.

## Step 3: Route changes to pages

Use the source map in `SAGE_CURRENCY.md`. Changed file → candidate pages. When a changed file is
not covered by the map, read it and decide: is this documentation-visible (a command, flag,
config key, prompt text, scope, version qualifier, or security boundary)? If yes, add it to the
map row and the affected page; if no, record it in the "What changed" section as not-doc-visible.

Prefer errs incoming: a tag line that adds new files inside mapped directories counts as a hit.

## Step 4: Verify and edit affected pages

For each affected page:

1. Reread the changed source at the new ref, then reread the page.
2. Diff every factual claim in the page against the source. Claims about commands, config,
   approvals, ledger behavior, and security boundaries are the highest risk.
3. Re-verify the posture content first and on any README change: authorized-use-only, beta status,
   the Mythic version pin, and the autonomous-agent risk language. If the Sage README changed
   these, the public-doc equivalents in `index.mdx`, `understand/security-and-data-handling.mdx`,
   and the Callouts must change in the same pass. Do not soften or drop them.
4. Edit pages with uncommitted changes only. For meaningful additions, propose the page outline
   before writing prose (per `AGENTS.md` "Start and scope").
5. Apply `STYLE.md` (`STYLE.md` checks) to everything touched.

## Step 5: Update the currency record

Update `SAGE_CURRENCY.md`: new commit SHA, closest tag, verified date, and a one-paragraph entry
in "What changed since the last full pass" (tags landed, commits reviewed, pages touched, pages
confirmed untouched). If the mirror sits between tags, say so explicitly and name the exact HEAD.

## Step 6: Validate and report

1. `scripts/check-links.sh` from this repo.
2. `scripts/preview.sh`; confirm every touched page returns HTTP 200; stop the preview.
3. Report: baseline → new ref, tags seen, pages edited/confirmed-untouched, any claim you dropped
   because it could not be verified, and the full `git status` for review. Nothing is committed;
   the user commits.

## Rules

- Never invent a version: use only refs the mirror actually reports.
- Never edit pages by assumption: every edit cites the diff hunk or source lines it is based on.
- Never update `SAGE_CURRENCY.md` to a ref whose affected pages were not verified; the record
  asserts verification, so the verification has to happen (or be rescheduled and stated as such).
- Mirror is read-only in this skill: no checkouts, no builds, no commits inside the Sage repo.
