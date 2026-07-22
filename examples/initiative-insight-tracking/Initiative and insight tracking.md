# Initiative and insight tracking

This example manages a process transformation workflow in SAP Signavio Process Transformation Manager. It creates a transformation initiative, records an insight linked to that initiative, and then lists all insights sorted by priority score.

## Prerequisites

- Ballerina Swan Lake 2201.13.x or later
- Push the connector to the local repository:
  ```bash
  cd ../../ballerina
  bal pack && bal push --repository=local
  ```
- Create a `Config.toml` in this directory:
  ```toml
  username = "<your-signavio-username-or-email>"
  password = "<your-signavio-password>"
  ownerUserId = "<UUID of the initiative owner>"
  ```

## Run the example

```bash
bal run
```
