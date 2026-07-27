// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

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
