# Process model export

This example browses the SAP Signavio Process Manager workspace, lists the content of the first root folder, and exports the first process model it finds as both diagram JSON and BPMN 2.0 XML. It demonstrates navigating the directory hypermedia structure to discover model IDs.

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
