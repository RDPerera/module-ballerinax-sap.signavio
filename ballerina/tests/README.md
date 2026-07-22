# Tests

The test suite covers 30 representative operations across all SAP Signavio API groups exposed by the connector: authentication (`POST /auth/v1/token`), Analytics case/task/user listing, Journey Modeler metric measurements, Dictionary entry CRUD, Directory browsing and folder management, model export as diagram JSON and BPMN 2.0 XML, BPMN import, Process Intelligence data ingestion and status polling, Transformation Manager initiative and insight CRUD, Objectives listing, workspace search, and SIGNAL OData entity-set queries. Each test invokes the generated client against the mock service and asserts on the shape and content of the typed response.

## Running Tests

```bash
bal test
```

The test suite uses a mock server (`tests/mock_service.bal`) that intercepts HTTP calls so no real credentials are required.

To run the tests against the live SAP Signavio API instead, set the following environment variables:

```bash
export IS_LIVE_SERVER=true
export SAP_SIGNAVIO_TOKEN="<your-access-token>"
export SAP_SIGNAVIO_COOKIE="JSESSIONID=<jsessionid>; LBROUTEID=<lbrouteid>"
export SAP_SIGNAVIO_ID="<x-signavio-id-auth-token>"
```
