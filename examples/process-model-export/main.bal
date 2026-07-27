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

// This example browses the SAP Signavio Process Manager workspace, lists the
// content of the first root folder, and exports the first process model it
// finds as both diagram JSON and BPMN 2.0 XML.

import ballerina/io;
import ballerinax/sap.signavio;

// Configuration — create a Config.toml with these values before running
configurable string username = ?;
configurable string password = ?;
configurable string region = "eu"; // e.g. "au" for https://app-au.signavio.com

public function main() returns error? {
    signavio:Client baseClient = check new ({
        auth: {username, password},
        region
    });

    // Step 1: Retrieve the workspace's root folders
    signavio:HyperMediaObject[] rootDirectories = check baseClient->getRootDirectories();
    io:println("Root folders: ", rootDirectories.length());

    // Step 2: List the content of the first root folder
    string firstDirHref = rootDirectories[0].href ?: "";
    string directoryId = firstDirHref.substring(<int>firstDirHref.lastIndexOf("/") + 1);
    signavio:HyperMediaObject[] directoryContent = check baseClient->getDirectoryContent(directoryId);
    io:println("Items in folder: ", directoryContent.length());

    // Step 3: Export the first model in the folder as diagram JSON and BPMN 2.0 XML
    foreach signavio:HyperMediaObject item in directoryContent {
        if item.rel == "mod" {
            string modelHref = item.href ?: "";
            string modelId = modelHref.substring(<int>modelHref.lastIndexOf("/") + 1);

            signavio:DiagramJson diagram = check baseClient->getModelJson(modelId);
            io:println("Model JSON resource ID: ", diagram.resourceId);

            xml bpmn = check baseClient->getBpmnXml(modelId);
            io:println("BPMN 2.0 XML export: ", bpmn.toString().length(), " characters");
            break;
        }
    }
}
