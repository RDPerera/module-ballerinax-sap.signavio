// This example manages a process transformation workflow in SAP Signavio
// Process Transformation Manager: it creates an initiative, records an
// insight against it, and then lists the open insights.

import ballerina/io;
import ballerinax/sap.signavio;

// Configuration — create a Config.toml with these values before running
configurable string username = ?;
configurable string password = ?;
configurable string ownerUserId = ?;

public function main() returns error? {
    signavio:Client baseClient = check new ({
        auth: {username, password}
    });

    // Step 1: Create a transformation initiative
    signavio:Initiative initiative = check baseClient->createInitiative({
        name: "Order to Cash Optimization",
        description: "Streamline the order-to-cash process across regions.",
        status: "IN_PROGRESS",
        valueDrivers: ["OPERATIONAL_EXCELLENCE"],
        authorizations: [
            {role: "OWNER", targetId: ownerUserId, targetType: "USER"}
        ]
    });
    io:println("Created initiative: ", initiative.id);

    // Step 2: Record an insight linked to the initiative
    signavio:Insight insight = check baseClient->createInsight({
        name: "Long approval times for high-value invoices",
        description: "Invoices above 10k EUR wait on average 4 days for approval.",
        status: "OPEN",
        valueDrivers: ["OPERATIONAL_EXCELLENCE"],
        authorizations: [
            {role: "OWNER", targetId: ownerUserId, targetType: "USER"}
        ],
        assignees: [ownerUserId],
        initiatives: [initiative.id],
        priorityScore: 7.5,
        effortScore: 3.0,
        impactScore: 8.0
    });
    io:println("Created insight: ", insight.id);

    // Step 3: List all insights sorted by priority
    signavio:Insight[] insights = check baseClient->listInsights(
        queries = {sortBy: "priorityScore", sortOrder: "Descending"}
    );
    foreach signavio:Insight item in insights {
        io:println(item.name, " (priority: ", item.priorityScore, ")");
    }
}
