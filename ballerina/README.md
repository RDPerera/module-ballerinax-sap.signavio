## Overview

[SAP Signavio](https://www.signavio.com/) is SAP's business process transformation suite for modeling, analyzing, and improving business processes. The `ballerinax/sap.signavio` connector provides a unified Ballerina client for the SAP Signavio REST APIs, covering Authentication, Process Manager (Dictionary, Directory, Model, Import and Export, Search), Process Intelligence (Ingestion and SIGNAL Engine OData), Process Governance Analytics, Journey Modeler Metrics, and Process Transformation Manager (Initiatives, Assets, Insights, and Objectives). The connector is generated from a merged OpenAPI 3.0 specification of the SAP Signavio API.

## Setup guide

To use the SAP Signavio connector, you need an SAP Signavio workspace account (a user name/email and password).

1. Sign in to your [SAP Signavio](https://www.signavio.com/) workspace and note the region of your tenant (`au`, `ca`, `eu`, `jp`, `kr`, `sgp`, or `us`) — it determines the hostnames the connector connects to (e.g. `api.eu.signavio.cloud.sap` and `app-eu.signavio.com`).

2. Provide your credentials to the connector via a `Config.toml` file:

   ```toml
   username = "<your-signavio-username-or-email>"
   password = "<your-signavio-password>"
   ```

   The connector handles authentication internally: `Client.init()` exchanges these credentials for both the API gateway JWT (`POST /auth/v1/token`) and the Process Manager workspace session (`POST /p/login`) - no separate login step, token, or cookie handling is needed.

   The SIGNAL Engine OData operations (`getServiceDocument`, `getMetadata`, `queryEntitySet`) are the one exception: SAP Signavio authenticates these with a dedicated OData API access token rather than your account password, so that token can't be derived automatically. If you need those operations, generate an access token from the SAP Signavio UI (see the [SAP Signavio documentation](https://documentation.signavio.com/)) and pass it as `auth.odataAccessToken`.

## Quickstart

To use the `sap.signavio` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerinax/sap.signavio;
```

### Step 2: Instantiate a new connector

```ballerina
configurable string username = ?;
configurable string password = ?;

final signavio:Client signavioClient = check new ({
    auth: {username, password},
    region: "eu"
});
```

### Step 3: Invoke the connector operation

```ballerina
public function main() returns error? {
    // List the root folders of the workspace
    signavio:HyperMediaObject[] rootFolders = check signavioClient->getRootDirectories();
    io:println("Root folders: ", rootFolders.length());
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `SAP Signavio` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-sap.signavio/tree/main/examples/), covering the following use cases:

1. [Process model export](https://github.com/ballerina-platform/module-ballerinax-sap.signavio/tree/main/examples/process-model-export) — Browses the workspace folders and exports a process model as diagram JSON and BPMN 2.0 XML.
2. [Dictionary entry management](https://github.com/ballerina-platform/module-ballerinax-sap.signavio/tree/main/examples/dictionary-entry-management) — Creates a dictionary entry, lists the entries of its category, and retrieves the entry's details.
3. [Business process extraction](https://github.com/ballerina-platform/module-ballerinax-sap.signavio/tree/main/examples/business-process-extraction) — Signs in to a Process Manager workspace and collects the Business Process Level 2 and Level 3 models for a downstream Ardoq mapping step.
