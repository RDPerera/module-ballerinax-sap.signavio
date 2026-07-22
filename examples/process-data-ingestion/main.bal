// This example pushes process data into SAP Signavio Process Intelligence:
// it uploads a schema with CSV data through the Ingestion API, checks the
// ingestion status, and then queries the resulting data via the SIGNAL
// Engine OData API.

import ballerina/io;
import ballerinax/sap.signavio;

// Configuration — create a Config.toml with these values before running
configurable string username = ?;
configurable string password = ?;
configurable string entitySetName = ?;
// A SAP Signavio OData API access token (generated from the SAP Signavio UI) - only the
// SIGNAL Engine OData API (queried in step 3) needs this; it can't be derived from
// username/password since it's a separate credential type.
configurable string odataAccessToken = ?;

public function main() returns error? {
    signavio:Client baseClient = check new ({
        auth: {username, password, odataAccessToken}
    });

    // Step 1: Upload a schema and CSV data through the Ingestion API
    signavio:UploadSchemaAndDataResponseDto upload = check baseClient->uploadSchemaAndData({
        schema: "{\"type\":\"record\",\"name\":\"orders\",\"fields\":[{\"name\":\"id\",\"type\":\"string\"},{\"name\":\"amount\",\"type\":\"double\"}]}",
        primaryKeys: ["id"],
        files: [
            {fileName: "orders.csv", fileContent: "id,amount\nORD-1,120.50\nORD-2,89.90".toBytes()}
        ]
    });
    io:println("Ingestion started: ", upload.executionId);

    // Step 2: Check the status of the ingestion request
    signavio:ExecutionStatusDto status = check baseClient->getStatus(upload.executionId);
    io:println("Ingestion status: ", status.status, " - ", status.message);

    // Step 3: Query the ingested data through the SIGNAL Engine OData API
    signavio:OdataOutput result = check baseClient->queryEntitySet(entitySetName, 
        queries = {dollarSelect: ["id"], dollarTop: 10}
    );
    io:println("Rows returned: ", result.value.length());
}
