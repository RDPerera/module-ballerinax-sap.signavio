# Dictionary entry management

This example maintains the SAP Signavio Process Manager dictionary. It creates a new dictionary entry in a given category, lists the entries of that category sorted by title, and retrieves the created entry's details.

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
  categoryId = "<dictionary category ID, e.g. ORG_UNIT>"
  ```

## Run the example

```bash
bal run
```
