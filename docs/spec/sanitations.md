_Author_: RDPerera \
_Created_: 2026/07/16 \
_Updated_: 2026/07/24 \
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

Two operation groups were probed against a live tenant and found to consistently return errors on both the gateway and workspace hosts, with no alternate path found to fix them: the `/v1/model/*` group (`retrieveModel`, `updateModel`, `deleteModel`, `createModel`, `listModelRevisions`, `updateModelInfo`, plus the `approvalExpiration`/`syntaxchecker` operations) returns a plain `404` on both hosts regardless of path variant tried, and the Analytics (SPG = Signavio Process Governance) report group (`listCases`, `listTasks`, `listUsers`, `listGroups`, `listFiles`, `listCaseVariables`, and their sub-resources) returns a plain `404` on the gateway with no working alternate found. Response headers confirm both are gateway-level "no such route" rejections (only `date`/`content-length`) rather than an application rejecting the request (which always includes SAP's full security header suite, e.g. `strict-transport-security`, `x-frame-options`) - so this isn't a licensing gap, the paths are simply wrong and no working replacement has been found yet. `listInitiatives`/`listInsights`/asset operations (Transformation Manager) and `uploadSchemaAndData`/`getStatus` (Ingestion) return structured `403`/`401 Access Denied` bodies from a route that otherwise resolves correctly (full security header suite present) - this reads as a genuine licensing/entitlement gap on the specific trial tenant tested against, not a routing bug, so those paths were left unchanged. Cross-checked against the SAP Business Accelerator Hub catalog (api.sap.com): Process Manager (5 APIs, matches what's confirmed working), Process Transformation Suite (1 API, matches the shared Authentication endpoint), and Process Transformation Manager (3 APIs: Initiatives/Insights/Objectives, matching the mixed 403/200 result) all line up; Process Governance is listed as its own separate product (1 API), confirming "SPG" is a distinct, unlicensed product on this tenant rather than an unlicensed feature of something else.

12. Fixed `importBpmn20Xml`'s multipart file field name and added the required `signavio-id` field
- **Original**: `BpmnImportRequest.bpmn2File` was named `bpmn2_file` in the multipart body, and only the session's `X-Signavio-ID` was sent as a header.
- **Updated**: The field is named `bpmn2_0file`, and the session's signavio-id value is *also* sent as a `signavio-id` multipart form field (in addition to the `X-Signavio-ID` header every other workspace operation uses).
- **Reason**: Verified against a live tenant by capturing the real browser request (DevTools) for a successful manual BPMN import and diffing it against the generated request - the field name and the extra `signavio-id` field are exactly what the browser's own upload widget sends; without them the API returns a generic `BPMN2_0Import.NoFile` error regardless of any other header/encoding permutation tried.

13. Fixed `createBodyParts` silently corrupting file uploads (`importBpmn20Xml`, `uploadSchemaAndData`)
- **Original**: `createBodyParts` receives its payload after `check jsondata:toJson(payload).ensureType()`. JSON has no byte-array representation, so a `record {byte[] fileContent; string fileName;}` field becomes a JSON array of integers at runtime (a `map<json>`, not the original record type). The function's type check for that exact record shape (`value is record {byte[] fileContent; string fileName;}`) therefore always failed post-conversion, silently falling through to the generic `record {}` branch, which serialized the *entire* `{"fileContent":[...],"fileName":"..."}` structure via `.toString()` as the file's content instead of the actual file bytes.
- **Updated**: Added `asFilePayload()`, which recognizes this JSON-converted shape (a `map<json>` with a `json[]` `fileContent` and a `string` `fileName`) and reconstructs the original `byte[]`, for both a single file field and an array of file fields (`uploadSchemaAndData`'s `files` array has the same shape and the same bug).
- **Reason**: Discovered while diagnosing sanitation 12 - even after fixing the field name, imports failed until this was found by writing a plain reproduction that inspected the runtime type of the payload's file field post-JSON-conversion. This affects every file-upload operation, not just BPMN import; `uploadSchemaAndData` was fixed the same way even though it couldn't be re-verified live (Ingestion isn't licensed on the test tenant), since the bug is unrelated to and independent of that entitlement gap.

14. Wrapped the generated client to add transparent token/session refresh (gmail-style module split)
- **Original**: The generated client (`client.bal`/`types.bal`/`utils.bal`) was the public API directly. `Client.init()` obtained the gateway JWT and the workspace session once and held them for the client's lifetime, baking the JWT into `gatewayClient`'s config. A client instance living past the gateway JWT's ~24h TTL (confirmed by decoding the token's `exp` claim against a live tenant) or the workspace session's server-side timeout would then fail every subsequent call with an auth error until re-initialized - a real reliability gap for long-lived consumers (e.g. an HTTP service that constructs the client once at startup).
- **Updated**: Adopted the `ballerinax/googleapis.gmail` layout. The generated client moved verbatim into a `modules/oas` submodule, and the public `ballerinax/sap.signavio` module became a hand-written wrapper over it:
  - `oas:Client` now keeps the gateway JWT and workspace session in `lock`-guarded mutable state instead of baking them into the http clients. `gatewayClient` is built plain and the JWT is injected per request (`gatewayHeaders`); the session headers are read per request (`currentSessionHeaders`); and a public `reauthenticate()` re-runs both logins (`POST /auth/v1/token` and `POST /p/login`) and atomically swaps in the fresh state.
  - The root `Client` (`client.bal`) delegates each of the 92 operations to `oas:Client` and, when a call comes back HTTP 401, calls `reauthenticate()` once and replays the request. `types.bal` re-exports the 243 public `oas` types so the public API is unchanged and self-contained (callers still import only `ballerinax/sap.signavio`).
- **Reason**: A pure-Ballerina *transparent* wrapper (one that passes the caller's expected type straight through to the HTTP client) is impossible - a dependently-typed function must have an `external`/Java body - so the SAP Business One approach (`b1_http_client.bal`) would require adding a Java native module. Rebuilding the inner client on 401 was also ruled out because `ConnectionConfig` embeds `http:*` config records and is not `Cloneable`, so it cannot be stored for reconstruction. Injecting refreshable auth per request inside `oas:Client` and retrying on 401 in the wrapper closes the expiry gap with neither Java nor a config-storage workaround. Covered by the `testReauthenticatesOn401` mock test (a sentinel request is rejected with 401 exactly once, and the wrapper must re-login and replay to succeed).

Regenerating this connector from `docs/spec/aligned_ballerina_openapi.json` regenerates only the `modules/oas` submodule (see the CLI command below); the hand-written wrapper (`client.bal`), the type re-exports (`types.bal`), and the `reauthenticate`/per-request-auth changes in the root module are not touched by `bal openapi`. Within `modules/oas`, sanitations 2-13 would still be discarded on regeneration, since they go beyond what `bal openapi` can express (a login handshake isn't representable as an OpenAPI security scheme, and the multipart field-name/extra-field fixes and the `createBodyParts` byte-array bug are in hand-maintained code, not the spec). The spec itself should be corrected (split the single server into the two real backends, drop `ApiKeysConfig`/browser-cookie security schemes, fix the `/spm/v1` paths, the doubled `/v1/objectives` segment, the dictionary-entry response shapes, and the `bpmn2_file`/`bpmn2_0file` field name) before the next regeneration, and these hand-changes reconciled against the regenerated output.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory. Since the generated client now lives in the `oas` submodule (sanitation 14), the output is directed there so the hand-written wrapper in the root module is left untouched.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json --mode client --client-methods remote --license docs/license.txt -o ballerina/modules/oas
```

Note: The license year in `docs/license.txt` is currently 2026; update it before regenerating if the year has changed.
