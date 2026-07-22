_Author_: RDPerera \
_Created_: 2026/07/16 \
_Updated_: 2026/07/22 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from SapSignavio.
The OpenAPI specification is a manually assembled/merged specification covering multiple SAP Signavio API
surfaces (Authentication, Process Manager, Process Intelligence, Process Governance Analytics, Journey
Modeler, Transformation Manager).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Change `ODataError target` to nullable
- **Original**: The `target` field in `ODataError` was `not nullable`.
- **Updated**: The `target` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

2. Internalized authentication (hand-modified `client.bal`/`types.bal`, not regenerated from the spec)
- **Original**: `ConnectionConfig.auth` was `http:BearerTokenConfig|http:CredentialsConfig|ApiKeysConfig`, requiring the caller to separately obtain a JWT (or, for Directory/Model/Dictionary/Search, a full set of browser session cookies) and pass it in.
- **Updated**: `ConnectionConfig.auth` is now a single `Credentials` record (`username`, `password`, optional `tenant`/`odataAccessToken`). `Client.init()` performs both real login flows itself - `POST /auth/v1/token` for the API gateway JWT, and `POST /p/login` for the Process Manager workspace session - and holds two internal `http:Client`s (`gatewayClient`, `workspaceClient`) plus an optional `odataClient` (only constructed when `odataAccessToken` is supplied). `ApiKeysConfig` was removed.
- **Reason**: Verified against a live tenant that these are two genuinely different backends with two different auth mechanisms; requiring the caller to drive either login manually (and thread cookies through every call) defeated the point of a generated client. The SIGNAL Engine OData API is authenticated with a separate SAP-issued access token that cannot be derived from the account password, so it remains an explicit opt-in field.

3. Corrected the Process Manager path prefix from `/spm/v1/...` to `/p/...`
- **Original**: `getRootDirectories`, `getDirectoryContent`, `getModelJson`, `getBpmnXml`/`getPng`/`getSvg` (+ revision variants), the dictionary/glossary operations, `search`, `importBpmn20Xml`, `publishItem`, and the DMN/BPMN import-export operations all called `/spm/v1/...` against the single gateway server declared in the spec.
- **Updated**: These operations now call `/p/...` against a second server, the Process Manager workspace host (`https://app-<region>.signavio.com`), via `self.workspaceClient`.
- **Reason**: Verified against a live tenant - `/spm/v1/...` on the API gateway unconditionally rejects every request for these operations (`Invalid JWT`, regardless of what's sent), while the identical resource shapes are served at `/p/...` on the workspace host under a classic session. `createDiagramDraft` (`/p/editorcreate`) and `getMetaInfo`/`createMetaInfo` (`/p/meta`) already had the correct `/p/...` path but were still wired to the gateway client; they were switched to `self.workspaceClient` too.

4. Widened `HyperMediaObject.rep` from `record {}` to `json`
- **Original**: `rep` was typed `record {}` (object shape only).
- **Updated**: `rep` is typed `json`.
- **Reason**: The real Directory API returns an object for `dir`/`mod`/`glos` entries, but an array (e.g. `["all","warehouse.share"]`, or `[]`) for hypermedia-relation entries like `priv`/`parents`/`subscription`. The stricter object-only type failed payload binding on real directory listings.

5. Removed `cookie`/`xSignavioID` header fields from the Dictionary operation `*Headers` types
- **Original**: `GetDictionaryEntryHeaders`, `CreateDictionaryEntryHeaders`, `UpdateDictionaryEntryHeaders`, `DeleteDictionaryEntryHeaders`, `GetDictionaryEntryInfoHeaders`, `ListDictionaryCategoriesHeaders`, `CreateDictionaryCategoryHeaders`, `GetDictionaryCategoryHeaders`, `UpdateDictionaryCategoryHeaders`, `DeleteDictionaryCategoryHeaders`, and `ListDictionaryEntriesHeaders` all required the caller to supply a session cookie and/or `X-Signavio-ID` token.
- **Updated**: Those fields were removed (the records left with only genuine content-negotiation fields, e.g. `contentType`, now defaulted); the session is attached automatically from `self.workspaceSessionHeaders`.
- **Reason**: Consequence of sanitation 2 - the session is no longer the caller's concern.

6. `authenticate()` moved off the shared gateway client onto a dedicated, un-authenticated `authClient`
- **Original**: `authenticate()` (`POST /auth/v1/token`) ran on `self.gatewayClient`, the same client every other gateway operation uses.
- **Updated**: A separate `self.authClient` (no `Authorization` header ever attached) is used only for this operation.
- **Reason**: Verified against a live tenant - the gateway's `/auth/v1/token` route returns `404 Not Found` on *any* request that carries an `Authorization` header, including one bearing a JWT that route itself issued moments earlier. Since `gatewayClient` always attaches the JWT from `init()`, calling `authenticate()` again through it (e.g. to refresh a token) always 404s.

7. Fixed the doubled `/v1/objectives` segment in the Objectives operations
- **Original**: `listObjectives`, `getObjective`, `getInitiativesByObjective` called `/transformationmanager/v1/objectives/v1/objectives...`.
- **Updated**: They call `/transformationmanager/v1/objectives...` (the `/v1/objectives` segment isn't repeated).
- **Reason**: Verified against a live tenant - the doubled path 404s; the single-segment path returns `200 {"value":[]}`.

8. Added `Accept: application/json` to the Process Manager workspace session headers
- **Original**: `self.workspaceSessionHeaders` carried only `Cookie` and `X-Signavio-ID`.
- **Updated**: `Accept: application/json` is included too.
- **Reason**: Verified against a live tenant - `listDictionaryEntries`/`getDictionaryEntry`/`getDictionaryEntryInfo` (and likely other dictionary/glossary routes) serve an HTML browser page by default and only return JSON when this header is present; every other workspace operation tested is unaffected by it.

9. Fixed the return types of `deleteDictionaryEntry` and `deleteDictionaryCategory`
- **Original**: Both returned `error?` (i.e. expected an empty body on success).
- **Updated**: Both return `SuccessResponse|error` (`{success: true}`).
- **Reason**: Verified against a live tenant - both endpoints return a `{"success":true}` JSON body on success, which failed payload binding against `()`.

10. Swapped the return types of `getDictionaryEntry` and `getDictionaryEntryInfo`
- **Original**: `getDictionaryEntry` (`GET /glossary/{id}`) returned `Representation`; `getDictionaryEntryInfo` (`GET /glossary/{id}/info`) returned `DictionaryResponse[]`.
- **Updated**: `getDictionaryEntry` returns `DictionaryResponse[]` and `getDictionaryEntryInfo` returns `Representation`.
- **Reason**: Verified against a live tenant - the bare `/glossary/{id}` route returns a hypermedia array (`rel: info/subscription/outgoings/parents/link`), while `/glossary/{id}/info` returns the flat entry representation directly. The two operations had the shapes reversed.

11. Widened `DictionaryResponse.rep` from `Representation|string[]` to `json`
- **Original**: `rep` was typed `Representation|string[]`.
- **Updated**: `rep` is typed `json`.
- **Reason**: Verified against a live tenant - within a single `getDictionaryEntry` response array, different `rel` values carry different `rep` shapes (e.g. `rel: "cat"` carries a full category object with fields like `hidden`/`isDimension`/`publishingMode` that don't fit `Representation`). Same underlying issue as sanitation 4.

Two operation groups were probed against a live tenant and found to consistently return errors on both the gateway and workspace hosts, with no alternate path found to fix them: the `/v1/model/*` group (`retrieveModel`, `updateModel`, `deleteModel`, `createModel`, `listModelRevisions`, `updateModelInfo`, plus the `approvalExpiration`/`syntaxchecker` operations) returns a plain `404` on both hosts regardless of path variant tried, and the Analytics (SPG) report group (`listCases`, `listTasks`, `listUsers`, `listGroups`, `listFiles`, `listCaseVariables`, and their sub-resources) returns a plain `404` on the gateway with no working alternate found. `listInitiatives`/`listInsights`/asset operations (Transformation Manager) and `uploadSchemaAndData`/`getStatus` (Ingestion) return structured `403`/`401 Access Denied` bodies from a route that otherwise resolves correctly - this reads as a licensing/entitlement gap on the specific trial tenant tested against, not a routing bug, so those paths were left unchanged.

Regenerating this connector from `docs/spec/aligned_ballerina_openapi.json` would currently discard sanitations 2-11, since they go beyond what `bal openapi` can express (a login handshake isn't representable as an OpenAPI security scheme). The spec itself should be corrected (split the single server into the two real backends, drop `ApiKeysConfig`/browser-cookie security schemes, fix the `/spm/v1` paths and the doubled `/v1/objectives` segment, correct the dictionary-entry response shapes) before the next regeneration, and these hand-changes reconciled against the regenerated output.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json --mode client --client-methods remote --license docs/license.txt -o .
```

Note: The license year in `docs/license.txt` is currently 2026; update it before regenerating if the year has changed.
