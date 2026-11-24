# Sage source currency

Tracks which Sage revision this documentation tree has been verified against. When this file and a
doc page disagree, the page prose wins on wording but this file wins on *currency*; refresh this
file only through the `sage-source-sync` skill (`.agents/skills/sage-source-sync/`) or a manual
re-verification pass of every affected page.

## Current verification state

| Field | Value |
|---|---|
| Verified against mirror commit | `95b3c99e3056b2e874520bbb959beff347889d76` |
| Closest tag | `v0.3.0` (exactly this commit; annotated tag object `da0d595`) |
| Tags before that point | `v0.1.0-alpha`, `v0.1.0-beta`, `v0.2.0` |
| Verified on | 2026-11-12 |
| Mirror working tree | dirty at verification time (unrelated uncommitted work); every file was read from the tag with `git show`, never from the working tree |
| Subject to the beta posture | yes: authorized-use-only, beta status, Mythic version qualification, and autonomous-agent risk language in the Sage README must survive every sync. At `v0.3.0` the README dropped the word "beta" (it says "still maturing" and "under active development"); the operator keeps beta status in the docs (2026-11-12) |

## Source map (page groups to Sage files)

Used by the sync skill to route source changes to affected pages. Directory level on purpose;
page-level line mapping is done during verification, not recorded here.

| Docs pages | Sage paths they draw from |
|---|---|
| `index`, `quickstart` | `README.md`, `config.json`, `docs/releases/`, `docs/SECURITY_AND_DATA_HANDLING.md`, `CHANGELOG.md` (Validation) |
| `understand/**` | `README.md`, `docs/SECURITY_AND_DATA_HANDLING.md`, `docs/architecture/`, `Payload_Type/sage/sage_chat/`, `CHANGELOG.md` (Known issues, Validation) |
| `guides/using-chat`, `understand/authority-modes` | `README.md`, `Payload_Type/sage/sage_chat/` (`hitl.py`, `slash.py`, `config.py`, `metadata.py` chips, `restoration.py`), `Payload_Type/sage/ai/langgraph/catalog_binding.py`, `Payload_Type/sage/ai/langgraph/capabilities.py` (catalog candidates, missing-input refusal), `Payload_Type/sage/prompts/`, `Payload_Type/sage/ai/langgraph/` (`step_bounds.py`, `handoff_brief.py`, `request_contract.py`; supervised step limits, delegation briefs, Autonomous Solve in conversation) |
| `guides/chat-config` | `Payload_Type/sage/sage_chat/models.py` (config options, channel token scopes), Mythic `New AI Chat` dialog |
| `guides/models` | `README.md` (Model configuration, OpenAI Responses and Daybreak, Reasoning effort and tools, Changing the model), `documentation-payload/sage/model-configuration.md`, `Payload_Type/sage/sage_chat/models.py`, `Payload_Type/sage/sage_chat/config.py` (resolution chain, provider checks), `Payload_Type/sage/ai/openai_api.py` (`validate_route`, `adapter_options`), `Payload_Type/sage/sage_chat/model_command.py`, `Payload_Type/sage/ai/langgraph/operator_error.py`, `Payload_Type/sage/sage_chat/service.py` (`_core_config_signature`, held-change notices, `handle_model_command`), `Payload_Type/sage/ai/langgraph/model.py` (foreign reasoning stripped) |
| `guides/coding-agent` | `Payload_Type/sage/container/codex/` (`README.md`, `SETUP.md`, `.env`, `docker-compose.yml`, `Dockerfile`, `bridge.mjs`), `Payload_Type/sage/ai/acp_connections.py`, `Payload_Type/sage/sage_chat/slash.py` (`/acp`, `/stop`), `Payload_Type/sage/sage_chat/session.py` (`sage_acp_channel_bindings`), `Payload_Type/sage/.env` (`SAGE_ACP_SOCKET`), `Payload_Type/sage/.dockerignore` |
| `guides/bloodhound` | `Payload_Type/sage/sage_chat/metadata.py` (BloodHound chip), `README.md` (Requirements, BloodHound, Ingest readiness), `docs/configuration/BLOODHOUND.md`, `Payload_Type/sage/Dockerfile` (MCP pin, ingest-status patch, baked dir, `UV_NO_SYNC`), `Payload_Type/sage/patches/`, `Payload_Type/sage/ai/bloodhound_config.py` (URL parsing, required tools, diagnostics, ingest contract and job status, per-turn state, last-failure cache), `Payload_Type/sage/ai/mcp.py` (`bloodhound_run_args`), `Payload_Type/sage/sage_chat/config.py` (`build_bloodhound_env`), `Payload_Type/sage/sage_chat/slash.py` (`/bloodhound`), `Payload_Type/sage/mcp_tool_policy.json`; Mythic `Mythic_CLI` (installed services use host networking) |
| `understand/limitations` | `README.md` (Requirements, Limitations), `CHANGELOG.md` (Validation), `docs/releases/` |
| `guides/troubleshooting` | Error strings and behaviors drawn from the pages it links; re-check whenever those pages change |
| `reference/release-notes` | `CHANGELOG.md`, `docs/releases/` |
| `guides/mcp-servers` | `Payload_Type/sage/mcp_tool_policy.json`, Sage MCP connect/classification code |
| `guides/custom-tls` | `Payload_Type/sage/ssl_bootstrap.py`, `Payload_Type/sage/certs/`, `Payload_Type/sage/ai/langgraph/mythic_tools.py` (Mythic login and registered-file download), `mythic` client package (`mythic_utilities.py` TLS handling) |
| `guides/findings-watcher` | `Payload_Type/sage/sage_chat/` (findings watcher) |
| `guides/engagement-ledger` | `Payload_Type/sage/ai/langgraph/` (`engagement_store.py`, `engagement_ledger.py`, `engagement_state.py`, `proof_boundary.py`, `effect_rules.py`, `step_ledger.py` (supervised step gains, attribution window), and the reconcile and evidence tools in `mythic_tools.py`), `Payload_Type/sage/sage_chat/slash.py` (`/state`), `Payload_Type/sage/sage_chat/` (operation memory, report identity/observations), `Payload_Type/sage/runtime_db.py`, `skills/sage-goad-reset/scripts/engagement_ledger_migrate.py` |
| `configuration/environment` | `config.json`, `Payload_Type/sage/dotenv_bootstrap.py`, `Payload_Type/sage/config.py`, `Payload_Type/sage/.env` (container-wide settings), `Payload_Type/sage/sage_chat/models.py` (option text), `Payload_Type/sage/ai/langgraph/step_bounds.py`, `Payload_Type/sage/ai/langgraph/step_ledger.py` |
| `configuration/edit-files-from-mythic` | `Payload_Type/sage/prompts/` (`README.md`, file headers, `step_bounds`), `Payload_Type/sage/ai/langgraph/step_bounds.py` (`front_matter_bounds`), `Payload_Type/sage/ai/langgraph/prompt_loader.py` (read per agent build, `str.format()` rendering and fallback, `tools` filter), `Payload_Type/sage/ai/langgraph/ttp_library.py` (read per lookup, skip rules), `Payload_Type/sage/ttps/contracts/README.md`, `Payload_Type/sage/ai/langgraph/staged_tools.py` (`binary_filename` index, per-call scan), `Payload_Type/sage/dotenv_bootstrap.py` (read once at startup), `Payload_Type/sage/Dockerfile` (`WORKDIR /Mythic/`), `Payload_Type/sage/requirements.txt` (`mythic-container` pin); `mythic-container` `mythic_service.py` (file browser rooted at the running script's folder); Mythic `MythicReactUI` Installed Services Chat tab and Container Files dialog (labels), `hasura-docker/metadata/actions.yaml` and `mythic-docker` `initialize.go` (`noSpectators` file routes), `Mythic_CLI` (`installservice.go` reinstall replaces the directory, `serviceMetadata.go` `/Mythic/` bind mount and `sage_use_volume`), no container restart in the 4.0.8 UI |
| `configuration/runtime-state` | `README.md` (restart contract), `Payload_Type/sage/sage_chat/restoration.py`, `Payload_Type/sage/sage_chat/session.py` (channel session records), `Payload_Type/sage/sage_chat/service.py` (startup settlement), `Payload_Type/sage/sage_chat/hitl.py` (Continue/Stop card), `Payload_Type/sage/runtime_db.py`, `Payload_Type/sage/ai/langgraph/engagement_store.py` (ledger tables, legacy-file guard), `Payload_Type/sage/ai/langgraph/engagement_ledger.py`, `skills/sage-goad-reset/scripts/engagement_ledger_migrate.py`, `Payload_Type/sage/container/`, Mythic CLI (`stop`/`start`) |
| `configuration/run-from-source` | `README.md` (Requirements, Local development, `.env` loading), `Payload_Type/sage/main.py`, `Payload_Type/sage/dotenv_bootstrap.py` (`.env.local` then `.env`), `Payload_Type/sage/runtime_db.py` (default `sage.db` path), `Payload_Type/sage/requirements*.txt`, `constraints.txt`, the repo's local restart script (env defaults it applies); `mythic-container` `logging.py`/`config.py` (`DEBUG_LEVEL`); Mythic `Mythic_CLI` (`debug_level`, `stop`/`start`/`restart`/`remove`/`add`/`logs`, loopback port bindings) |
| `configuration/observability` | `skills/phoenix-traces/`, `Payload_Type/sage/container/`, `Payload_Type/sage/ai/phoenix_tracing.py`, `Payload_Type/sage/ai/langgraph/kernel_tracing.py`, `Payload_Type/sage/main.py` (tracer registration, `SIGUSR1` stack dump) |
| `reference/tools-and-capabilities` | `docs/reference/TOOLS_AND_CAPABILITIES.md`, `Payload_Type/sage/tools/`, `Payload_Type/sage/.dockerignore` (drop zone excluded from images), `Payload_Type/sage/ai/langgraph/staged_tools.py` (`list_staged_tools`), `Payload_Type/sage/ai/langgraph/capabilities.py` (capability catalog), `Payload_Type/sage/sage_chat/models.py` (declared channel scopes), `Payload_Type/sage/ai/langgraph/operation_context.py` (event-log engagement marker), `Payload_Type/sage/ai/langgraph/model.py` (Supervisor tool binding), `Payload_Type/sage/ai/langgraph/mythic_capability_adapter.py` (payload profiles), `Payload_Type/sage/ai/langgraph/mythic_tools.py` (tool safety, scopes, discovery and tasking), `Payload_Type/sage/ai/langgraph/command_parameter_schema.py`, `Payload_Type/sage/ai/langgraph/command_builder.py`, `Payload_Type/sage/ai/comparison_tool_surface.py` (agent-visible tool lists), `Payload_Type/sage/prompts/` (frontmatter tool lists) |
| `reference/slash-commands` | `Payload_Type/sage/sage_chat/slash.py`, `Payload_Type/sage/prompts/` |

## What changed since the last full pass

Initial verification pass: the page tree was written against mirror HEAD `bd85f84` (2026-10-26).
No sync delta recorded yet.

Pre-launch review (2026-10-26), same mirror commit:

- Corrected the engagement-ledger storage claim (JSON under `.sage_engagement/`, not SQLite).
- Narrowed custom-tls: Mythic API calls do not verify TLS (`mythic` 0.3.0rc8 uses `CERT_NONE`), so the bundle applies to httpx clients (model endpoints, MCP HTTP/SSE) and BloodHound; only the registered-file download verifies Mythic. The Sage README still lists Mythic; flagged upstream.
- Added `understand/limitations`, `guides/troubleshooting`, and `reference/release-notes`.
- Renamed `guides/operations` to `guides/findings-watcher`.
- Rewrote clean resets for a Mythic install.
- Held the GOAD page back from launch: it is out of navigation and kept untracked under `temp/`,
  so it has no source-map row until it returns.

The tree has 20 pages.

Capability list (2026-10-28), `reference/tools-and-capabilities` only:

- Rewrote the page from code, not from `TOOLS_AND_CAPABILITIES.md`, against tag `v0.2.0`; the
  mapped files are identical between `v0.2.0` and mirror HEAD `fe151bf`.
- Any-agent section: discovery and tasking path verified in `mythic_tools.py`
  (`_authenticate_live_command`, `_prepare_supervised_issue_action`, `_validate_command_parameters`),
  `command_parameter_schema.py`, and `command_builder.resolve_params`. Adapters (Apollo, Merlin)
  from `mythic_capability_adapter.py`.
- Tools table: the 32 agent-visible tools are `SHIPPING_MYTHIC_*_TOOL_NAMES` in
  `Payload_Type/sage/ai/comparison_tool_surface.py` plus `sandbox_exec`, cross-checked against
  prompt frontmatter. Class from `@tool_safety`, scope from `SCOPE_REQUIREMENTS`. Seven other
  decorated methods are internal and never handed to an agent.
- Added the 15 capabilities from `capabilities.py`; `collect-graph` runs SharpHound (model.py).
- Drop zone: describes TTP-named staging only; folder discovery is planned for a later release.
- Added "Minimum bot token scopes". Sage side: `SCOPE_REQUIREMENTS` (preflight), `ChatAPITokenProvider`
  in `mythic-container==0.7.0rc9` (mints with no scopes, so the token inherits the channel token's).
  Mythic side, at the pinned `v4.0.0rc5` commit `a9add7f`: route scopes in
  `mythic-docker/src/webserver/initialize.go`, RPC scopes in `mythic-docker/src/rabbitmq/`, and
  per-table read filters in `hasura-docker/metadata/databases/default/tables/`. Derived from
  source; not yet confirmed with a live minimal-scope token. Re-check on any Mythic version bump.
- Fixed this page's source-map row: `agent_capabilities.json` is Mythic marketplace metadata, not
  the capability catalog.
- The recorded baseline above was not moved: only this page was re-verified. Note that
  `bd85f84` is not an ancestor of the current mirror HEAD, so the next full sync should establish
  a new baseline rather than diff from it.

BloodHound setup (2026-10-28), `guides/bloodhound` only:

- Expanded the page into a setup guide against mirror HEAD `fe151bf`: versions from the README
  Requirements and Dockerfile pin, URL rules from `parse_bloodhound_url`, resolution order and
  secret names from `build_bloodhound_env`, `/bloodhound` semantics from `slash.py`, ingest from
  the `ingest_collection` docstring.
- Host networking for installed services verified in Mythic `Mythic_CLI` at `a9add7f`
  (`Add3rdPartyService` sets `network_mode: host`).
- Token creation, roles, and Docker Desktop host networking are linked to SpecterOps and Docker
  documentation rather than captured from a live UI. The Power User recommendation is inferred
  from SpecterOps' role table and not yet tested with Sage.

Run from source (2026-10-29), `configuration/run-from-source` (new) and one `guides/troubleshooting` entry:

- Local-run steps from the README (Requirements, Local development) and the restart script's
  fresh-start path at mirror HEAD `fe151bf`: venv plus constrained install, `RABBITMQ_HOST` and
  `MYTHIC_SERVER_HOST` at `127.0.0.1`, `RABBITMQ_PASSWORD` from Mythic's `.env`, then
  `python -u main.py` from `Payload_Type/sage`. `.env.local` precedence and git-ignore status from
  `dotenv_bootstrap.py` and `.gitignore`.
- `DEBUG_LEVEL` values and fallback from `mythic-container==0.7.0rc9` (`logging.py`, Dynaconf
  settings with no env prefix). Modules on `getLogger(__name__)` are not under the `mythic` logger
  and the root logger is unconfigured, so they emit warnings and above only.
- Mythic side at `a9add7f`: `debug_level` default `warning`, applied to all installed services;
  `ServiceStart` regenerates service config on every start; RabbitMQ 5672 and server 17443/17444
  bind to localhost by default (`rabbitmq_bind_localhost_only`, `mythic_server_bind_localhost_only`),
  nginx 7443 to all interfaces. A remote source run needs both binds set to `false`; Sage reaches
  Mythic only through `RABBITMQ_HOST`, `MYTHIC_SERVER_HOST` (gRPC), and `NGINX_HOST`.
- Not yet run end to end on a live host; the "stop the container first" step is inferred from both
  copies consuming one queue.

Engagement State Ledger (2026-11-09), ledger content on eleven pages, against Sage `release/0.3.0` at
`8d68472` (ledger code identical to `556c697`; HEAD is after `v0.2.0` and inside no tag):

- Rewrote `guides/engagement-ledger`, the ledger section of `understand/how-sage-works`, the
  `/state` rows of `reference/slash-commands`, and the state table of `configuration/runtime-state`.
  The ledger moved from `.sage_engagement/state_<operation>.json` into `sage.db`
  (`engagement_store.py`); rows are `achieved` or `pending` (`_ROW_STATUSES`); unproven achieved
  writes become `pending`/`proof_missing` (`engagement_state.py` `record_effect_result`); proof
  origins include callbacks and derived rules (`proof_boundary.py`); the Supervisor and
  Mythic_Operator get a fresh ledger view per model call (`model.py`
  `_EngagementLedgerViewMiddleware`); turn-end reconciliation reads every issuer's tasks
  (`mythic_tools.py` `_reconcile_operation`); `/state` subcommands from `slash.py` `_STATE_USAGE`.
- Added "Importing a ledger from an earlier release" to `configuration/runtime-state`: the
  legacy-file guard (`engagement_store.py` `_assert_legacy_imported`) and the migration script's
  `import` options. The script lives in the Sage repository, not the container image.
- Small fixes on `index` (proof envelope contents) and `guides/using-chat` (`/state` line).
- Applied the ledger's formal name, Engagement State Ledger, to every ledger mention on those pages
  and on `quickstart`, `understand/limitations`, `understand/security-and-data-handling`,
  `guides/troubleshooting`, and `reference/tools-and-capabilities`. The `how-sage-works` anchor is
  now `#the-engagement-state-ledger`; its three inbound links follow. `reference/release-notes`
  keeps the v0.2.0 wording.
- Updated the `guides/engagement-ledger` and `configuration/runtime-state` source-map rows to the
  files the ledger actually lives in.
- `assets/screens/engagement-ledger-state.png` was recaptured from a current build: the table shows
  the shipping columns (#, Hop, Effect, Status, Task, CB) and current correction commands, cropped to
  the ledger from a supervised run with six achieved hops. Its caption describes that capture.
- The recorded baseline above was not moved: only the ledger content was re-verified.

Sage v0.3.0 sync (2026-11-12), full pass, against tag `v0.3.0` at `95b3c99` (baseline moved from
`bd85f84`, which is an ancestor of the tag; 124 commits reviewed through `--stat`, the `v0.3.0`
CHANGELOG section, and the README diff, with full diffs for every mapped file):

- Posture: carried the README's new Mythic target into `index`, `quickstart`,
  `configuration/run-from-source`, and `understand/limitations` (0.3.0 qualification on Mythic
  `v4.0.8`, reported in the GitHub release notes; 0.1.0-beta on `v4.0.0rc5` remains the last live
  qualification recorded in the repository). Kept beta status at the operator's direction although
  the README dropped the word, and added the README's "under active development" wording to the
  `index` warning. Auto mode is labeled experimental, a research and
  evaluation capability not run live on 0.3.0, on `index`, `understand/authority-modes`,
  `guides/using-chat`, and `understand/limitations`.
- Supervised mode: added "Bounded supervised steps" to `understand/authority-modes` (limits and
  defaults from `step_bounds.py` `StepBounds`, brief checks and typed outcomes from the CHANGELOG),
  the staging class, the pre-routing graph read, the first `collect-graph` proposal, and Autonomous
  Solve being ignored in conversation (`sage_chat/config.py` `autonomous_solve_ignored`). Supervisor
  role and step summary on `understand/how-sage-works`; Supervisor tool binding from `model.py`
  (`list_callbacks` outside auto, the two ledger tools in every mode).
- Scopes: tool table and "Minimum bot token scopes" rebuilt from `SCOPE_REQUIREMENTS`
  (`task.write` for tasking, `file.read` for `ingest_collection`, no scope for `sandbox_exec` and
  `download_tool`) and `_CHANNEL_TOKEN_SCOPES` (adds `operator.read` and `eventlog.write`; the
  latter backs the engagement marker in `operation_context.py`). Kept "a missing read scope returns
  empty results": Mythic's `hasura_claims.go` sets an absent scope's claim to `0` and the table
  filters compare against it, at both `a9add7f` and the `Mythic-v4.0.0` branch head (version 4.0.9)
  checked on 2026-11-12. The upstream README now says Mythic "rejects" such a query; flagged
  upstream rather than followed. Also updated `authority-modes`, `troubleshooting`,
  `slash-commands`, `chat-config`, and `quickstart`.
- Tools: added `list_staged_tools`, `read_engagement_state`, and `submit_engagement_evidence`
  (35 agent-visible tools: `comparison_tool_surface.py` plus `sandbox_exec`); `ensure_tool_uploaded`
  is `TOOL_SAFETY_STAGING`. Capability table rebuilt from the new `CapabilityDoc` catalog (same 15
  names; effect and requirement replace the one-line intent). Drop-zone inventory from
  `TOOLS_AND_CAPABILITIES.md` and `.dockerignore`.
- BloodHound: ingest readiness (README "Ingest readiness", `bloodhound_config.py` ingest contract,
  Dockerfile patch step, `/bloodhound` Connection and Ingest output in `slash.py`), patched custom
  checkouts, and `uv run --no-sync` in the image (`mcp.py` `bloodhound_run_args`). The upstream
  `BLOODHOUND.md` still says a custom checkout syncs on first connect, which `--no-sync` contradicts
  inside the container; flagged upstream. The ingest-status change (`d14b225`) is not in the 0.3.0
  CHANGELOG; the docs release notes include it.
- Ledger: added "What supervised steps record" (`step_ledger.py`, CHANGELOG), credential material,
  and automatic "no longer holds" markers to `guides/engagement-ledger`. Ledger files changed since
  the `8d68472` pass only in `engagement_state.py` and `proof_boundary.py` (FQDN learning, DCSync
  material for forging); no page claim changed.
- Configuration: per-request `max_steps`, the `autonomous_solve` note, and a "Container-wide
  settings" table (`SAGE_STEP_*`, `SAGE_ENGAGEMENT_NETBIOS_MAP`, from `.env`) on
  `configuration/environment`; `v0.3.0` ownership wording on `runtime-state` and `troubleshooting`;
  corrected the run-from-source banner claim (`_version.announce_startup` prints at any level; only
  the `.env` names log at `info`).
- `reference/release-notes`: replaced "Unreleased" with a `v0.3.0` section adapted from the
  CHANGELOG, leaving out evaluation-plane and maintainer-tooling entries.
- Confirmed untouched: `understand/security-and-data-handling` (security document unchanged),
  `guides/mcp-servers` (policy file and `/mcp` unchanged), `guides/custom-tls` (`ssl_bootstrap.py`,
  registered-file download TLS, and `mythic` pins unchanged), `guides/findings-watcher` (watcher
  and Slack modules unchanged), `configuration/observability` (span names, `SAGE_KERNEL_TRACING`,
  and `phoenix_verdict.py` unchanged; tracer moved off the global provider with no change to what is
  traced).
- No GitHub release object existed for `v0.3.0` at verification time, so no measured
  qualification result is quoted; pages state what the README says the release notes report.

Edit files from Mythic (2026-11-20), `configuration/edit-files-from-mythic` (new) and links from
`configuration/environment`, `configuration/runtime-state`, `guides/bloodhound`, `guides/chat-config`,
`understand/how-sage-works`, and `reference/tools-and-capabilities`, against tag `v0.3.0` at `95b3c99`:

- Prompt behavior from `prompt_loader.py` and `prompts/README.md`: files are read with no cache at
  each agent build, rendered with `str.format()`, fall back to the raw body on a render error, and
  the `tools` header only filters the code's candidate tools. The header example is the top of
  `mythic_operator.md`. Upstream inconsistency: `prompts/README.md` opens with "Edit a file,
  restart Sage" while its own step 2 and the loader say a new chat is enough; the docs follow the
  loader. Flagged upstream.
- TTP and drop-zone timing from `ttp_library.py` (`load_ttp` and `iter_ttps` read from disk on every
  call) and `staged_tools.scan` (per call, called from `list_staged_tools` and `/tools staged`).
  `ttps/contracts/` handling from its README.
- File browser root from `mythic-container==0.7.0rc9` `listFile`/`getFile`/`writeFile` (the folder
  of `sys.argv[0]`, which is `/Mythic/` per the Dockerfile `WORKDIR` and `CMD`). UI labels, the
  Upload File button, and the absence of a container restart control from Mythic `MythicReactUI` at
  `v4.0.0rc7-3-g3e07d356`, whose `VERSION` is `4.0.8`; the same labels are present at `v4.0.0rc9`
  (`VERSION` 4.0.11). Roles from Hasura action permissions and the `noSpectators` route group.
- Reinstall and mount behavior from `Mythic_CLI` at the same commit: `InstallFolder` removes the
  existing service directory before copying; installed services bind-mount the service directory
  at `/Mythic/` unless `<service>_use_volume` is `true`.
- The `.env` paragraph on `configuration/environment` now says applying a change needs one restart
  on the host. The Sage README and `.env` header say "no shell, no `docker cp`, no sudo", which holds
  for editing but not for the restart in Mythic 4.0.8; flagged upstream.
- File browser paths: the Container Files dialog opens in the service directory itself and labels
  that top folder **root** (`BrowserPath` in the dialog), so `.env`, `prompts/`, `ttps/`, and
  `tools/` sit at its top level. Pages give browser paths relative to it and keep
  `InstalledServices/sage/` for host commands, after operator feedback that host-relative paths
  read as if the browser started above the service directory.
- Screenshots from a live Mythic 4.0.8 install, captured 2026-11-20
  (`assets/screens/installed-services-view-files.png`, `container-files-root.png`,
  `container-files-edit-prompt.png`), confirm the Chat tab, View Files, the dialog title
  (sage's Current Files, with the Container Files list inside it), the root breadcrumb, the row
  buttons, and the editor's Submit. Saving an edit, uploads, and the restart step were not
  exercised; uploads of large binaries through the file browser are untested.
- The recorded baseline above was not moved.

Sage 0.4.0 pre-release pass (2026-11-23), against Sage `dev` at `2bb7564` (94 commits after
`v0.3.0`; no `v0.4.0` tag yet). The recorded baseline above was not moved: the final pass runs
against the tag.

- Restarts: rewrote `configuration/runtime-state` "What a restart does to your chats" from the README
  restart contract and `restoration.py` notice texts (restored-session notice, Continue saved decision /
  Stop card, startup-message settlement, bot-account condition, never-resent approved actions), and
  followed it on `guides/using-chat` (new "After Sage restarts"), `guides/troubleshooting` (three
  entries), `understand/limitations`, and `guides/engagement-ledger`. The double-issue known limit is
  replaced: `restoration.py` closes an interrupted approved action as never resent or outcome unknown.
- Models: new `guides/models`; chat fields and environment rows for `SAGE_OPENAI_API`,
  `SAGE_OPENAI_ACCESS_PROGRAM`, `SAGE_OPENAI_SAFETY_IDENTIFIER` and `SAGE_REASONING_EFFORT`
  (`models.py`, `openai_api.py`); Model chip and `/model` (`metadata.py`, `model_command.py`); a
  provider-rejection troubleshooting entry (`operator_error.py`); the Responses data row on
  `understand/security-and-data-handling` (from the security document's new row).
- Coding agent: new `guides/coding-agent` (experimental, configuration only), `/acp` rows on
  `reference/slash-commands`, `SAGE_ACP_SOCKET` on `configuration/environment`, the worker `.env` row on
  `configuration/edit-files-from-mythic`, and reinstall notes on `configuration/runtime-state`.
- BloodHound: four chip states, the single loss notice, the agent's explanation and `Last failure`
  (`bloodhound_config.py` `observe_bloodhound_state`, `_remember_failure`) on `guides/bloodhound`,
  `guides/using-chat` and `guides/troubleshooting`; collection retrieval despite collector diagnostics
  (`cb78ea3`).
- Supervised steps: per-specialist `step_bounds` and overrides (`step_bounds.py`, prompt headers),
  the remaining-budget line, the tool-free final answer, scope-refused proposals, catalog binding,
  the missing-input refusal and operator-named proof hosts on `understand/authority-modes`,
  `configuration/environment` and `configuration/edit-files-from-mythic`; the verification line, the
  `Not issued` line and the no-step notice (`step_bounds.py` `verdict_lines`, `model.py`) on
  `guides/using-chat`; edited credential rows and reviewed material on `guides/engagement-ledger`; the
  Conversation tool menu (`ab49f5b`) on `understand/authority-modes` and
  `reference/tools-and-capabilities`; the previous-reply block and attributed reports on
  `understand/how-sage-works`.
- One later commit, `9ad4cd4` (operator-named DCSync accounts and an explicit re-verify), adds a
  paragraph on `understand/authority-modes` from its commit message, `requested_dcsync_accounts`
  (`capabilities.py`) and its recorded request rows. No other page was re-verified against it.
- Mythic wording (operator decision, 2026-11-23): `index`, `quickstart`, `configuration/run-from-source`
  and `understand/limitations` now say Sage requires Mythic v4 and 0.4.0 is developed and tested
  against Mythic `v4.0.8` (the lab version of the 0.3.0 qualification and the 2026-11-20 screenshots);
  the 0.3.0 qualification detail stays in the release notes. The Sage README "Mythic target"
  paragraph still names the 0.3.0 qualification; flagged upstream.
- Resolved upstream flags from 2026-11-20: `2bb7564` changed the prompts README to "start a new chat"
  and the README and `.env` header to say a `.env` change needs `sudo ./mythic-cli restart sage`.
- New upstream flags: `container/codex/SETUP.md` ("A Sage redeploy keeps this directory") and the
  worker README (deploy sync never overwrites `.env`) describe the maintainer deploy script, while
  `mythic-cli install` removes the service directory; SETUP step 5 uses `docker restart sage`; the
  worker `Dockerfile` header names a `docker-compose.example.yml` that does not exist;
  `validate_route` refuses an explicit Daybreak Off without Responses while the README says only
  "Daybreak without Responses"; `SAGE_REASONING_EFFORT` is not in `OptionalUserSecrets` although the
  field text and README name a user-secret fallback (the docs omit that fallback); the CHANGELOG
  `[Unreleased]` section has only the step-bounds entry.
- Confirmed unchanged at `2bb7564`: `comparison_tool_surface.py` (35 agent-visible tools),
  `SCOPE_REQUIREMENTS`, `_CHANNEL_TOKEN_SCOPES`, the 15 capability names, `mcp_tool_policy.json`,
  `ssl_bootstrap.py`, tracing modules, `Dockerfile`; so `guides/custom-tls`, `guides/mcp-servers`,
  `guides/findings-watcher` and `configuration/observability` are untouched. `/model` worked live
  with a token holding `apitoken.write`, `chat-ai.write` and `callback.read` (the model-switch check in
  `skills/sage-focused-capability-tests/`), a subset of the declared channel scopes.
- Not done yet: `reference/release-notes` `v0.4.0` (waits on the CHANGELOG), the screenshot
  recaptures (`assets/chat-chips.png`, `assets/new-ai-chat/model-selection.png` and new shots), and the
  re-diff from `2bb7564` to the tag (more supervised work may land first).
