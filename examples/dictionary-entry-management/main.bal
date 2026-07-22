// This example maintains the SAP Signavio Process Manager dictionary: it
// creates a new dictionary entry, lists the entries of its category, and
// retrieves the created entry's details.

import ballerina/io;
import ballerinax/sap.signavio;

// Configuration — create a Config.toml with these values before running
configurable string username = ?;
configurable string password = ?;
configurable string categoryId = ?;

public function main() returns error? {
    signavio:Client baseClient = check new ({
        auth: {username, password}
    });

    // Step 1: Create a dictionary entry
    signavio:DictionaryResponse created = check baseClient->createDictionaryEntry({
        title: "Supplier (sap.signavio connector example)",
        category: categoryId,
        description: "An external party providing goods or services."
    });
    io:println("Created entry: ", created.href);

    // Step 2: List the dictionary entries in the same category
    signavio:DictionaryResponse[] entries = check baseClient->listDictionaryEntries(
        queries = {category: categoryId, sort: "title"}
    );
    io:println("Entries in category: ", entries.length());

    // Step 3: Retrieve the created entry's details (the flat representation, via the /info route)
    string entryId = created.href.substring(<int>created.href.lastIndexOf("/") + 1);
    signavio:Representation entry = check baseClient->getDictionaryEntryInfo(entryId);
    io:println("Entry title: ", entry.title);
}
