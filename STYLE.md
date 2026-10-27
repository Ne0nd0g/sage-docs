# Sage Docs Style Guide

Editorial standard for every tracked file in this repository: written for AI agents and human
contributors alike, meant to be followed mechanically, and verifiable with the checks at the
bottom. Good documentation is boring in specific ways; this file names them.

Precedence, highest first:

1. `AGENTS.md` for content, safety, and policy boundaries (what may be written at all).
2. This file for how the writing is done.
3. The adopted external standard, where this file is silent.

## Base standard

Adopt the [Google Developer Documentation Style Guide](https://developers.google.com/style) as the
base editorial standard. Follow it for everything it covers: audience and purpose first, second
person, present tense, active voice, sentence case in headings, prose over bullet-point sprawl,
procedurals as numbered steps of complete sentences, and its word list for usage decisions.

If a question falls outside the Google guide's coverage, fall back in order to the
[Microsoft Writing Style Guide](https://learn.microsoft.com/en-us/style-guide/welcome-style-guide)
(stronger on product UI and chat voice) and the
[GitLab Documentation Style Guide](https://docs.gitlab.com/development/documentation/styleguide/)
(stronger on open-source workflow conventions).

## Sage voice layer

The audience is an offensive-security operator who already has credentials and does not want a
pitch. On top of the base standard:

- **Second person, direct.** "Run the container", not "you may wish to run the container" and
  never "one simply runs the container". No condescension, no cheerleading.
- **Hedged where behavior is unvalidated.** Sage is beta software. Say "unsupported", "may", or
  "currently" rather than promising behavior nobody has verified. Match the Sage README's
  qualifications: authorized use only, Mythic version pin, autonomous-agent risk in production.
- **No hype.** A stated strength carries its limitation in the same sentence ("drives real Mythic
  tasks; it never connects to target services directly").
- **Show, then tell.** Real commands and real configuration in fenced code blocks with correct
  language tags, ahead of the paragraphs explaining them. Never show placeholder credentials or
  invented paths.
- **Concrete nouns.** Name the task type, the file, the flag, the approval card. Avoid abstract
  restatements ("interaction with the operational surface" means "tasking a callback").

## Banned AI tells

These are the patterns AI text generation overproduces. The problem with any single instance is
minor; the problem is density. When enough of them accumulate, prose reads as generated. Rewrite
toward the plainest sentence that carries the claim.

### Structure tells

- **Em dashes.** Do not use em dashes (`—`) in prose. Recast with a comma, colon, parentheses, or
  a separate sentence. Use a hyphen (`-`) for compound terms and an en dash (`–`) only for numeric
  ranges (as in `10–20`). Code blocks and quoted command output are exempt; scan those lines
  manually.
- **Negative parallelism.** Constructions like "It's not X, it's Y", "not just X, but Y", and
  "X isn't about Y, it's about Z" are AI compression habits. State the positive claim first. Use a
  contrast only when the contrast itself is the load-bearing point, and carry it with evidence. At
  most once per document, ideally zero.
- **Forced triads.** Never group three items because three feels round. Group items because there
  are exactly that many. If a natural list has two or four members, keep two or four.
- **Over-fragmentation.** Do not shred one idea into three bullets, a bolded lead-in with a colon,
  or a heading per two sentences. Write the paragraph when the content is a paragraph. Reserve
  `<Steps>`, lists, and headings for genuinely enumerable content.
- **List-only documents.** A page made of bullet points with no connecting prose loses cause,
  condition, and ordering. Explain relationships in sentences; enumerate only the enumerable.
- **Uniform paragraph rhythm.** If every paragraph is exactly three sentences and every section
  ends with a summary sentence, reread and break the pattern.

### Vocabulary tells

Replace on sight. Applies to prose, frontmatter `title`/`description`, and callout copy.

| Banned | Use |
|---|---|
| delve | explain, look at, describe (or name what is described) |
| leverage, utilize, harness | use |
| robust | name the property: stable, tested, survives restarts |
| seamless, seamlessly | delete, or name what made it easy |
| comprehensive | complete, or name the coverage |
| crucial, pivotal | name why it matters, or delete |
| intricate, multifaceted | complex (if true), or delete |
| unlock, unleash, elevate, empower | delete; the feature is what it is |
| showcase | show |
| foster, underscore, highlight, boast | state directly |
| cutting-edge, state-of-the-art, game-changer, revolutionary | delete; name the specific capability |
| landscape, realm, tapestry, journey (as metaphor) | delete the metaphor, name the subject |
| simply, easily, just (as in "just run") | delete; instructions stay silent about ease |
| effortless | delete |
| powerful | name what it does |
| flexible | name what it accepts |
| holistic, end-to-end (as praise) | delete, or state what the full loop covers |
| impactful, actionable | delete, or name the effect |

### Tone tells

- **Sycophancy.** No "great question", "as you correctly identified", or any opener that addresses
  the reader's competence rather than the subject.
- **Hollow hedges.** "It's worth noting", "it's important to remember", and "keep in mind that"
  add no information. If the note matters, state it declaratively. If it does not matter, cut it.
- **Winding-down summaries.** AI drafts close sections with restatements ("this makes the system
  more flexible while maintaining robustness" says nothing the page above did not already say).
  End sections on their last substantive sentence.
- **Bursts of synonym variation.** Swapping in synonyms for range ("utility, instrument,
  implement") trades precision for variety. Keep the noun exactly the noun every time.
- **Emoji decoration.** None, anywhere, including headings and callouts.

### Formality tells

- **Title Case Headings.** Use sentence case: "How the loop works" rather than "How The Loop
  Works". Proper nouns stay capitalized.
- **Emphasis inflation.** Bold is for UI labels and terms being defined; italics rarely appear.
  If a sentence needs three bolded phrases to hold together, the sentence needs restructuring.
- **Pointless Markdown.** Do not use blockquotes for emphasis, do not add horizontal rules
  between sections, and do not pad frontmatter with tags no consumer reads.

## Checks

Run before reporting prose work as done. Each command that returns hits marks a rewrite pass as
still pending.

```bash
# Em dash in prose (code blocks legitimately contain dashes; judge those lines individually)
grep -n '—' **/*.mdx

# Negative parallelism
grep -nEi "not (just|only|about) .*(but|it's)" **/*.mdx
grep -nEi "\bn't (just|only|about) .*(it's|but)" **/*.mdx

# Vocabulary compression (matches have alternates in the table above)
grep -nEi "delve|leverage|utilize|seamless|crucial|pivotal|robust(ness)?|comprehensive|showcase|unlock|cutting-edge|state-of-the-art|game-changer|effortless(ly)?|holistic|tapestry" **/*.mdx

# Filler openers, hollow hedges, and sycophancy
grep -nEi "great question|as you correctly|worth noting|important to (note|remember)|keep in mind" **/*.mdx
```

`grep` needs `globstar` enabled (`setopt globstar` in zsh) for `**` to work, or run from the repo
root against `*.mdx` and each directory by name.

## Process notes

- When porting from the Sage repository's markdown, apply this guide during the MDX adaptation.
  The value of a port lives in the adaptation, and the port is the place where inherited marketing
  tone most often survives.
- Prose inside Mintlify components (`<Steps>`, `<Callout>`, `<Accordion>`) follows this guide with
  the same force as body text.
- If a drafted page fails three or more of the checks, rework at the page level rather than
  patching individual instances.
