# Examples

The `ballerinax/sap.signavio` connector provides practical examples illustrating usage in various scenarios.

| Example | Description |
|---------|-------------|
| [`process-model-export`](./process-model-export) | Browses the workspace folders and exports a process model as diagram JSON and BPMN 2.0 XML. |
| [`dictionary-entry-management`](./dictionary-entry-management) | Creates a dictionary entry, lists the entries of its category, and retrieves the entry's details. |
| [`business-process-extraction`](./business-process-extraction) | Signs in to a Process Manager workspace and collects the Business Process Level 2 and Level 3 models for a downstream Ardoq mapping step. |

## Prerequisites

1. Build and push the connector to your local Ballerina repository:
   ```bash
   cd ../ballerina
   bal pack && bal push --repository=local
   ```

2. For each example, create a `Config.toml` in the example directory with your SAP Signavio account credentials:
   ```toml
   username = "<your-signavio-username-or-email>"
   password = "<your-signavio-password>"
   ```
   The connector exchanges these for both the API gateway JWT and the Process Manager workspace session internally - no separate login step is needed. Some examples need additional values — see the `configurable` declarations at the top of each example's `main.bal` (e.g. `categoryId`, `region`).

## Running an example

```bash
cd examples/<example-name>
bal run
```
