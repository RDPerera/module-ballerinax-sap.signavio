# Ballerina SAP Signavio connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-sap.signavio/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-sap.signavio/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-sap.signavio.svg)](https://github.com/ballerina-platform/module-ballerinax-sap.signavio/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/sap.signavio.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fsap.signavio)

## Overview

[SAP Signavio](https://www.signavio.com/) is SAP's business process transformation suite for modeling, analyzing, and improving business processes. The `ballerinax/sap.signavio` connector provides a unified Ballerina client for the SAP Signavio REST APIs, covering Authentication, Process Manager (Dictionary, Directory, Model, Import and Export, Search), Process Intelligence (Ingestion and SIGNAL Engine OData), Process Governance Analytics, Journey Modeler Metrics, and Process Transformation Manager (Initiatives, Assets, Insights, and Objectives).

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

1. [Process model export](examples/process-model-export) — Browses the workspace folders and exports a process model as diagram JSON and BPMN 2.0 XML.
2. [Dictionary entry management](examples/dictionary-entry-management) — Creates a dictionary entry, lists the entries of its category, and retrieves the entry's details.
3. [Business process extraction](examples/business-process-extraction) — Signs in to a Process Manager workspace and collects the Business Process Level 2 and Level 3 models for a downstream Ardoq mapping step.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`sap.signavio` package](https://central.ballerina.io/ballerinax/sap.signavio/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
