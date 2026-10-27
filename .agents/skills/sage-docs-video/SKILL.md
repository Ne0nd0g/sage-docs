---
name: sage-docs-video
description: >-
  Produce a 16:9 horizontal video for the sage-docs Mintlify site via the hyperframes pipeline,
  in the vapor-glow palette, with YouTube-embed-first delivery. Host-portable: resolves the
  pipeline on any machine, and degrades to a handoff brief when the pipeline is absent. USE WHEN
  make a docs video, sage docs demo video, video for the landing page, convert a docs GIF to MP4,
  loop video, narrated walkthrough for sage-docs, embed video. NOT FOR vertical social Shorts
  (use the _VIDEO skill), screen-recording capture of live UI, or editing Mintlify pages.
---

# Sage Docs Video

One invocation produces one video asset for the sage-docs Mintlify site. The canonical
policy (when video earns its place, length, paucity, autoplay and captioning rules) lives in
this repository's `AGENTS.md` under "Videos". Read it first; this skill wraps production, not
policy.

## What this skill depends on

Video production requires the hyperframes repository. That repo is **host-local tooling, not part
of a public clone of sage-docs**: anyone cloning this repo does not get video production. This is
deliberate (the Mintlify build never needs the video toolchain), but it means the skill must
degrade gracefully on any host where the pipeline is absent. It does, via the resolution and
brief-handoff paths below.

## Resolve the pipeline (in order; stop at the first hit that works)

1. `SAGE_DOCS_VIDEO_REPO` environment variable, if set and valid.
2. The hyperframes path documented in this host's `AGENTS.local.md` (the list of maintainer hosts
   lives there; keep each host's copy current).

Never guess a checkout location by directory name. If neither resolves, treat the pipeline as
absent: say that `SAGE_DOCS_VIDEO_REPO` is unset and take the brief-handoff path.

At the resolved repo, verify the two artifacts this skill needs exist:
`templates/shorts/sage-docs/` and `.claude/skills/diy-yt-creator/new-sage-docs-video.md`. Also
confirm tooling runs there (`npx hyperframes lint --help`); locate the ElevenLabs key in the
repo's env config only if narration was requested. Archon is retired in this workflow: anything
archon-shaped in the hyperframes repo (`.archon/` files) is historical reference, not a
dependency.

### If resolution fails on this host

Run in **brief mode** (below), with one extra line in the report stating exactly which hosts hold
the pipeline and asking for one of: access to the hyperframes repo, the repo cloned next to this
clone, or the path exported as `SAGE_DOCS_VIDEO_REPO`. Never fabricate output or guess paths.

### Brief mode

When the pipeline is unavailable, the deliverable is a **docs video brief** saved to an untracked
scratch file: target MDX page, the motion/sequence required (one sentence on why motion is the
content), mode (silent/narrated), target duration, Sage version being depicted, phase-by-phase
content draft, and embed plan (YouTube first, or muted local loop). The brief is the portable
artifact: anyone on a host with the hyperframes repo can execute it deterministically from the
template and playbook without further context.

## Workflow

1. Read the "Videos" section of this repository's `AGENTS.md`. If the requested video does not
   meet the bar (motion/timing content, stuck-point, max ~2 minutes, text equivalent planned),
   say so and propose the alternative (screenshot, diagram, Steps) instead of producing the video.
2. Resolve the pipeline (above). Fail closed naming what is missing; never guess paths.
3. In pipeline mode, follow the docs-orientation playbook in the hyperframes repo
   (`.claude/skills/diy-yt-creator/new-sage-docs-video.md`) and execute with the `npx
   hyperframes` CLI against the `templates/shorts/sage-docs/` 16:9 template. If the template or
   playbook is missing from the checkout, stop and report; never port a vertical background into
   landscape by cropping.
4. Run the workflow with a written brief: topic, which MDX page embeds it, target length, version
   being demonstrated, caption/equivalent plan. Stream output live; do not batch.
5. In pipeline mode, return the preview path, the manual `npx hyperframes render` command, and the
   embed snippet: YouTube URL embedded via `<Frame caption>` when hosted, or the local
   `<video autoPlay muted loop playsInline>` pattern for short silent loops.
6. In brief mode, return the brief document and the named hosts holding the pipeline.

## Defaults this skill enforces (both modes)

- **16:9 horizontal.** Docs embeds are landscape; never produce a vertical cut for the docs site.
- **Vapor-glow palette.** Violet `#8B5CF6` core, cyan `#22D3EE`, magenta `#EC4899`, matching the
  Sage mark and the site's `docs.json` `colors` block.
- **Muted loops for demos.** No music bed, no narration unless explicitly requested; if narration
  is requested, ask for or generate captions. A spoken video without a text equivalent violates
  the AGENTS.md rule and ships nothing.
- **Version stamp in the brief.** Every video records against a named Sage version; the brief must
  state which one so the page can carry it.
- **Public-safe frames only.** Nothing personal, no real engagement data, no target-identifying
  content. GOAD and other public lab content is fine; anything from a live engagement is not.
- **Never auto-render.** The skill's last output is a preview (pipeline mode) or a brief
  (brief mode), plus the manual render command for the user to run.
