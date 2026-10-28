# Sage source currency

Tracks which Sage revision this documentation tree has been verified against. When this file and a
doc page disagree, the page prose wins on wording but this file wins on *currency*; refresh this
file only through the `sage-source-sync` skill (`.agents/skills/sage-source-sync/`) or a manual
re-verification pass of every affected page.

## Current verification state

| Field | Value |
|---|---|
| Verified against mirror commit | `bd85f84c7d9bb0ae540be3f6b10687fc05242435` |
| Closest tag | `v0.2.0` (HEAD is 4 commits after it; inside no tag) |
| Tags before that point | `v0.1.0-alpha`, `v0.1.0-beta` |
| Verified on | 2026-10-26 |
| Mirror working tree | clean at verification time |
| Subject to the beta posture | yes: authorized-use-only, beta status, Mythic version pin, and autonomous-agent risk language in the Sage README must survive every sync |

## Source map (page groups to Sage files)

Used by the sync skill to route source changes to affected pages. Directory level on purpose;
page-level line mapping is done during verification, not recorded here.

| Docs pages | Sage paths they draw from |
|---|---|
| `index`, `quickstart` | `README.md`, `config.json`, `docs/releases/`, `docs/SECURITY_AND_DATA_HANDLING.md` |
| `understand/**` | `README.md`, `docs/SECURITY_AND_DATA_HANDLING.md`, `docs/architecture/`, `Payload_Type/sage/sage_chat/` |
| `guides/using-chat`, `understand/authority-modes` | `README.md`, `Payload_Type/sage/sage_chat/` (`hitl.py`, `slash.py`, `config.py`), `Payload_Type/sage/prompts/` |
| `guides/chat-config` | `Payload_Type/sage/sage_chat/models.py` (config options, channel token scopes), Mythic `New AI Chat` dialog |
| `guides/bloodhound` | `Payload_Type/sage/` BloodHound connect code, `Payload_Type/sage/.env` resolution, `Payload_Type/sage/mcp_tool_policy.json` |
| `understand/limitations` | `README.md` (Requirements, Limitations), `CHANGELOG.md` (Validation), `docs/releases/` |
| `guides/troubleshooting` | Error strings and behaviors drawn from the pages it links; re-check whenever those pages change |
| `reference/release-notes` | `CHANGELOG.md`, `docs/releases/` |
| `guides/mcp-servers` | `Payload_Type/sage/mcp_tool_policy.json`, Sage MCP connect/classification code |
| `guides/custom-tls` | `Payload_Type/sage/ssl_bootstrap.py`, `Payload_Type/sage/certs/`, `Payload_Type/sage/ai/langgraph/mythic_tools.py` (Mythic login and registered-file download), `mythic` client package (`mythic_utilities.py` TLS handling) |
| `guides/findings-watcher` | `Payload_Type/sage/sage_chat/` (findings watcher) |
| `guides/engagement-ledger` | `Payload_Type/sage/sage_chat/` (ledger, operation memory, report identity/observations), `Payload_Type/sage/runtime_db.py` |
| `configuration/environment` | `config.json`, `Payload_Type/sage/dotenv_bootstrap.py`, `Payload_Type/sage/config.py` |
| `configuration/runtime-state` | `Payload_Type/sage/runtime_db.py`, `Payload_Type/sage/ai/langgraph/engagement_ledger.py`, `Payload_Type/sage/container/`, Mythic CLI (`stop`/`start`) |
| `configuration/observability` | `skills/phoenix-traces/`, `Payload_Type/sage/container/` |
| `reference/tools-and-capabilities` | `docs/reference/TOOLS_AND_CAPABILITIES.md`, `Payload_Type/sage/tools/`, `Payload_Type/sage/ai/langgraph/capabilities.py` (capability catalog), `Payload_Type/sage/ai/langgraph/mythic_capability_adapter.py` (payload profiles), `Payload_Type/sage/ai/langgraph/mythic_tools.py` (tool safety, scopes, discovery and tasking), `Payload_Type/sage/ai/langgraph/command_parameter_schema.py`, `Payload_Type/sage/ai/langgraph/command_builder.py`, `Payload_Type/sage/ai/comparison_tool_surface.py` (agent-visible tool lists), `Payload_Type/sage/prompts/` (frontmatter tool lists) |
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
