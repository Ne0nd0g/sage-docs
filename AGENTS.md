# Sage Docs Session Guide

This repository contains the public Mintlify documentation for
[Sage](https://github.com/MythicAgents/Sage), an AI operator inside the Mythic command and control
framework. Everything in this repo is public: write every tracked file as if it will be read by
anyone, including an adversary.

## Git ground rules (non-negotiable)

- Never commit, push, tag, sign, amend, reset, or publish on the user's behalf. The user makes every
  commit, and every commit is GPG-signed with the user's YubiKey.
- Never do work on `main`. The minimum working branch is `dev` or a branch created from `dev`.
  Before starting work, verify the branch is based on an up-to-date `dev`.
- Stage completed work and draft a ready-to-use commit message for it. Never run `git commit`
  yourself: the user makes every commit, and every commit is GPG-signed with the user's YubiKey.
  When the user prefers to stage one combined batch (normal for large setup work), leave the tree
  unstaged for them and still provide the suggested single message.
- Host-specific notes live in `AGENTS.local.md`, which is excluded from git via `.git/info/exclude`
  so it never appears in the public tree or `.gitignore`. Never move host-local or personal content
  into tracked files.

## Start and scope

- Ground all factual claims about Sage in its source. The local mirror of the Sage repository is
  the reference; do not write from memory or marketing language. If a claim seems wrong upstream,
  flag it instead of quietly disagreeing with the source docs or writing around it.
- Track source currency in `SAGE_CURRENCY.md`: it records the exact Sage mirror commit every page
  has been verified against, the tag nearest that commit, and a source map from Sage files to the
  pages that draw on them. After a new Sage tag or when asked to sync, run the repo-local
  `sage-source-sync` skill (`.agents/skills/sage-source-sync/`); it diffs the recorded baseline
  against fresh source and produces uncommitted page updates. Never move the recorded ref forward
  without actually re-verifying the pages mapped to the changed files.
- For meaningful additions, propose the page outline (heading tree and which Sage docs/source
  sections it draws from) before writing full prose.
- Prefer porting the Sage repository's existing docs over recreating content from scratch. When
  porting, adapt to MDX and Mintlify components rather than pasting raw Markdown that renders
  poorly or not at all.

## Agent skills

- The canonical home for this repo's agent skills is `.agents/skills/`, the neutral location of the
  Agent Skills open standard (agentskills.io): one directory per skill containing a `SKILL.md` with
  YAML frontmatter (`name`, `description`) plus optional support files.
- `.opencode/skills`, `.claude/skills`, and `.codex/skills` are symlinks into `.agents/skills`, so
  one set of skill files serves OpenCode, Claude Code, Codex, and any other harness that reads the
  standard. Write and edit skills under `.agents/skills/` only; never create a divergent copy under
  a harness directory.
- Skill `name` values are kebab-case per the standard (`sage-docs-video`, `sage-source-sync`), and
  `description` values must parse as plain YAML, so put them in folded block scalars (`>-`) when
  they contain colons. The Mintlify preview validates these frontmatter files too; a bad
  description fails the whole build.
- Current skills: `sage-source-sync` (re-verify pages against new Sage revisions) and
  `sage-docs-video` (produce docs videos through the host-local hyperframes pipeline, with a brief
  mode for hosts without it).

## Mintlify conventions

- Every page is an `.mdx` file with `title` and `description` frontmatter, and must be listed in
  `docs.json` navigation or it will not appear on the site.
- Use Mintlify components (`<Card>`, `<CardGroup>`, `<Tabs>`, `<CodeGroup>`, `<Accordion>`,
  `<Steps>`, `<Callout>`, `<Frame>` for images and videos, etc.) where they improve clarity. Keep
  MDX valid: escape or wrap raw angle-bracket text (`<`, `=>`) in code spans or fences so the
  build does not fail.
- Organize by reader need (Diátaxis), not by repository layout: never mirror the Sage repo's
  `docs/` tree. `docs.json` drifts between Mintlify CLI versions; the current schema wants
  `navigation` as an object (`{"groups": [...]}`) and requires `colors.primary`. After any
  `docs.json` change, validate through the preview rather than trusting an older example.
- Keep `docs.json` sorted, minimal, and valid against the Mintlify schema. Update navigation in the
  same change that adds or renames a page.
- Preview locally without committing anything: run `scripts/preview.sh`, which wraps
  `npx mint@latest dev` and validates `docs.json` on the spot. Site branding (the `colors` block)
  follows the Sage mark's violet/cyan/magenta vapor-glow gradient; keep new accent colors inside
  that palette.
- Check the whole build works after structural changes, not just the edited page. Broken MDX or
  navigation paths in one file can fail the entire Mintlify deploy.
- Run `scripts/check-links.sh` after content work: it verifies that every internal link resolves
  to a page or asset listed in `docs.json` navigation, and that every external link answers. It
  skips links quoted inside code fences; review those by hand.

## Branding

- The logo asset (`assets/sage.png`, from the Sage repository's mark) and the favicon
  (`assets/favicon.png`) are wired into `docs.json` (`logo`, `favicon`). They come from the Sage
  mark; treat updates to it as a source-synced change, not a free edit.
- Keep the mark out of page bodies: no decorative logo images, no repeated wordmarks per page,
  and no gradient-as-decoration inside content. The palette rule in the `colors` block and the
  `STYLE.md` ban list cover the chrome.

## Videos

Videos are produced with hyperframes and embedded in MDX. Use the repo-local
`sage-docs-video` skill (`.agents/skills/sage-docs-video/`) as the production
path; the bar below is the canonical policy the skill must honor. The project's public video
channel is the **Mythic Sage AI** YouTube channel (`https://www.youtube.com/@MythicSageAI`);
embeds in docs should use that channel's uploads. The hyperframes repo is
host-local tooling and does not ship inside a public clone of this repo; the skill resolves it
per host and, when absent, produces a handoff brief instead of pretending to produce video. Because a video is expensive to make and
expensive to keep correct, apply a strict bar for when one earns its place:

- **When to include:** motion, timing, or sequence is the content (an autonomous solve unfolding,
  an approval-card interaction, a live trace walkthrough), or a visual where users demonstrably
  get stuck. Otherwise use screenshots, diagrams, or text.
- **When not to:** configuration steps, reference tables, anything expressible as a `Steps` list.
  Text and steps remain the canonical instructions: they are skimmable, searchable, and versionable;
  the embedded AI/agent consumption surface (`llms.txt`) reads the text, not the video.
- **Always pair with text.** A video never carries information absent from the page: give it a text
  (or screenshot) equivalent, on-page context, and a caption.
- **Keep them short, evergreen, and version-stamped.** Target under ~2 minutes; favor UI moments
  that change slowly; state in the page which Sage version the video was recorded against, since
  video cannot be diffed.
- **Paucity by default.** At most one or two videos per page, placed where they remove the most
  friction, not as decoration.

Delivery rules:

- Prefer embedding from the project's public video channel over serving video files; local
  `videos/*.mp4` is allowed only for short silent looping demos with a poster image and
  lazy loading, kept small. Do not commit long GIFs; convert them to muted looping
  MP4/WebM (`<video autoPlay muted loop playsInline>` inside a `<Frame caption>`).
- Autoplay only ever muted. Captions or an on-page equivalent are required for anything spoken.
- Public videos follow the public-content rules above: nothing personal, engagement-derived, or
  target-identifying survives into a frame.
- **Format for docs embeds is 16:9 horizontal.** Vertical video is a separate social/marketing
  deliverable, not a docs asset.


## Content and safety boundaries

- Public files must be committable as-is: no personal paths, private model pins, credentials,
  maintainer tooling, authorized-target names, engagement data, or references to files absent from
  a public clone.
- Preserve the Sage README's authorized-use posture: authorized use only, beta status, the
  Mythic version qualification, and the warning about autonomous-agent risk in production. Do not
  soften, drop, or bury these qualified claims.
- Keep claims about Sage's architecture consistent with the security boundary documented in the
  Sage repository (`docs/SECURITY_AND_DATA_HANDLING.md` and README): Sage drives Mythic tasks on
  live payload callbacks and never connects directly to target services; a green test or demo run
  is not a proof statement. When documenting capabilities, state limitations alongside strengths.
- Do not document the development/evaluation plane (GOAD harnesses, evaluator machinery, internal
  review processes) in public docs unless a release explicitly exposes it.

## Writing style

- Follow `STYLE.md` (the repo's editorial standard: Google Developer Documentation Style Guide as
  the base, a Sage voice layer on top, and a banned-AI-tells list with grep checks). It governs
  prose in every tracked file, including this one.
- Match the Sage repository's voice: precise, hedged where behavior is unvalidated, and free of
  hype. Prefer concrete nouns and second-person operator instructions over abstract restatement.
- Show real commands and configuration in fenced code blocks with the correct language tag; never
  show placeholder credentials or invented paths.
- Link across pages with Mintlify-relative links, and link out to the Sage repo and Mythic docs
  with pinned branches or tags where practical so examples stay reproducible.
