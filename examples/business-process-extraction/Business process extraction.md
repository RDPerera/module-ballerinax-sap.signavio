# Business process extraction

This example implements the SAP-side half of a "Business Process → Ardoq" sync (the mapping/Ardoq side is out of scope). It signs in to a SAP Signavio Process Manager workspace, walks the directory tree, and collects the Business Process Level 2 and Level 3 models that a downstream mapping step would push into Ardoq.

The connector handles authentication internally: `signavio:Client.init()` exchanges `username`/`password` for both the API gateway JWT and the Process Manager workspace session, so this example only ever deals with account credentials.

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
  region = "<your-signavio-region>" # e.g. "au", "eu", "us" - defaults to "eu"
  ```

## Run the example

```bash
bal run
```
