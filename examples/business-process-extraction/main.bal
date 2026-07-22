// Getting Business Process data from SAP Signavio - the SAP-side half of a
// "Business Process -> Ardoq" sync. This example signs in to a SAP Signavio
// Process Manager workspace, walks the directory tree, and collects the
// Business Process Level 2 and Level 3 models that a downstream mapping step
// (Ardoq side, out of scope here) would consume.
//
// The connector handles authentication internally: `signavio:Client.init()`
// exchanges `username`/`password` for both the API gateway JWT and the
// Process Manager workspace session, so this example only ever deals with
// account credentials - no tokens, cookies, or separate login calls.

import ballerina/io;
import ballerinax/sap.signavio;

configurable string username = ?;
configurable string password = ?;
configurable string region = "eu"; // e.g. "au" for https://app-au.signavio.com

function entryName(signavio:HyperMediaObject entry) returns string {
    json? rep = entry?.rep;
    if rep is map<json> && rep["name"] is string {
        return <string>rep["name"];
    }
    return "";
}

type ProcessModel record {
    string id;
    string name;
    string href;
};

public function main() returns error? {
    signavio:Client signavioClient = check new ({auth: {username, password}, region});

    // Step 1: Browse the workspace, starting at the root folders.
    signavio:HyperMediaObject[] rootEntries = check signavioClient->getRootDirectories();
    io:println("Root folders: ", from signavio:HyperMediaObject e in rootEntries
        where e.rel == "dir"
        select entryName(e));

    // Step 2: Recursively walk folders to collect Business Process Level 2
    // and Level 3 models (the data a mapping step would push into Ardoq).
    ProcessModel[] level2Models = [];
    ProcessModel[] level3Models = [];
    foreach signavio:HyperMediaObject rootEntry in rootEntries {
        if rootEntry.rel == "dir" {
            check collectProcessModels(signavioClient, rootEntry.href ?: "", "", level2Models, level3Models, 0);
        }
    }

    io:println("Business Process Level 2 models found: ", level2Models.length());
    foreach ProcessModel model in level2Models {
        io:println(" - ", model.name, " (", model.id, ")");
    }
    io:println("Business Process Level 3 models found: ", level3Models.length());
    foreach ProcessModel model in level3Models {
        io:println(" - ", model.name, " (", model.id, ")");
    }

    // Step 3: Pull the full diagram JSON for one Level 2 model, to show the
    // actual business process content (nodes/edges) that would be mapped.
    if level2Models.length() > 0 {
        ProcessModel sample = level2Models[0];
        signavio:DiagramJson diagram = check signavioClient->getModelJson(sample.id);
        io:println("Sample diagram JSON fetched for '", sample.name, "', resource ID: ", diagram.resourceId);
    }
}

// `folderLevelHint` carries down the nearest ancestor folder name that looked
// like a "Level 3" grouping folder (e.g. "Level 3 & 4: Procurement of Parts"),
// since the individual sub-process models inside it are not themselves named
// "Level 3" - it's the containing folder that marks the level.
function collectProcessModels(signavio:Client signavioClient, string directoryHref, string folderLevelHint,
        ProcessModel[] level2Models, ProcessModel[] level3Models, int depth) returns error? {
    if depth > 4 {
        return;
    }
    string directoryId = directoryHref.substring(<int>directoryHref.lastIndexOf("/") + 1);
    signavio:HyperMediaObject[] entries = check signavioClient->getDirectoryContent(directoryId);
    foreach signavio:HyperMediaObject entry in entries {
        string entryHref = entry.href ?: "";
        if entry.rel == "dir" {
            string childName = entryName(entry);
            string childHint = childName.includes("Level 3") ? "Level 3" : folderLevelHint;
            check collectProcessModels(signavioClient, entryHref, childHint, level2Models, level3Models, depth + 1);
        } else if entry.rel == "mod" {
            string name = entryName(entry);
            string modelId = entryHref.substring(<int>entryHref.lastIndexOf("/") + 1);
            ProcessModel model = {id: modelId, name, href: entryHref};
            if name.includes("Level 2") {
                level2Models.push(model);
            } else if folderLevelHint == "Level 3" {
                level3Models.push(model);
            }
        }
    }
}
