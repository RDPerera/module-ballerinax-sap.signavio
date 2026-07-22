# Process data ingestion

This example pushes process data into SAP Signavio Process Intelligence. It uploads an Avro schema with CSV data through the Ingestion API, checks the status of the ingestion request, and then queries the resulting data via the SIGNAL Engine OData API.

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
  entitySetName = "<OData entity set name to query>"
  odataAccessToken = "<SAP Signavio OData API access token, generated from the SAP Signavio UI>"
  ```

## Run the example

```bash
bal run
```
