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

import ballerina/http;

# The `ballerinax/sap.signavio` client. Wraps the generated `oas` client and adds transparent
# re-authentication: when a request comes back unauthenticated (the gateway JWT is valid ~24h and
# the Process Manager workspace session has its own server-side timeout), the client re-logs in
# once and replays the request, so a long-lived client instance keeps working without manual
# re-initialization.
public isolated client class Client {
    final GeneratedClient oasClient;

    # Gets invoked to initialize the `connector`. Exchanges `config.auth` for a gateway JWT and a
    # Process Manager workspace session; both are refreshed automatically when they expire.
    #
    # + config - The configurations to be used when initializing the `connector`
    # + gatewayUrl - URL of the SAP Signavio API gateway. Defaults to the URL derived from `config.region`
    # + workspaceUrl - URL of the SAP Signavio Process Manager workspace. Defaults to the URL derived from `config.region`
    # + return - An error if connector initialization, or either login, failed
    public isolated function init(ConnectionConfig config, string? gatewayUrl = (), string? workspaceUrl = ()) returns error? {
        self.oasClient = check new GeneratedClient(config, gatewayUrl, workspaceUrl);
    }

    # List of case-variables resources
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function listCaseVariables(ListCaseVariablesHeaders headers = {}, *ListCaseVariablesQueries queries) returns CaseVariablesResourcesResponseSchema|CaseVariablesResourceReferencesResponseSchema|error {
        CaseVariablesResourcesResponseSchema|CaseVariablesResourceReferencesResponseSchema|error r = self.oasClient->listCaseVariables(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCaseVariables(headers, queries);
        }
        return r;
    }

    # Case-variables resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function getCaseVariable(string id, GetCaseVariableHeaders headers = {}, *GetCaseVariableQueries queries) returns CaseVariablesResourceResponseSchema|CaseVariablesResourceReferencesResponseSchema|error {
        CaseVariablesResourceResponseSchema|CaseVariablesResourceReferencesResponseSchema|error r = self.oasClient->getCaseVariable(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getCaseVariable(id, headers, queries);
        }
        return r;
    }

    # Cases related to a case-variables resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function listCaseVariableCases(string id, ListCaseVariableCasesHeaders headers = {}, *ListCaseVariableCasesQueries queries) returns CasesResourceResponseSchema|CasesResourceReferencesResponseSchema|error {
        CasesResourceResponseSchema|CasesResourceReferencesResponseSchema|error r = self.oasClient->listCaseVariableCases(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCaseVariableCases(id, headers, queries);
        }
        return r;
    }

    # Cases references related to a case-variables resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function listCaseVariableCaseRefs(string id, ListCaseVariableCaseRefsHeaders headers = {}, *ListCaseVariableCaseRefsQueries queries) returns CasesResourceReferenceResponseSchema|CasesResourceReferencesResponseSchema|error {
        CasesResourceReferenceResponseSchema|CasesResourceReferencesResponseSchema|error r = self.oasClient->listCaseVariableCaseRefs(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCaseVariableCaseRefs(id, headers, queries);
        }
        return r;
    }

    # List of cases resources
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function listCases(ListCasesHeaders headers = {}, *ListCasesQueries queries) returns CasesResourcesResponseSchema|CasesResourceReferencesResponseSchema|error {
        CasesResourcesResponseSchema|CasesResourceReferencesResponseSchema|error r = self.oasClient->listCases(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCases(headers, queries);
        }
        return r;
    }

    # Cases resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function getCase(string id, GetCaseHeaders headers = {}, *GetCaseQueries queries) returns CasesResourceResponseSchema|error {
        CasesResourceResponseSchema|error r = self.oasClient->getCase(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getCase(id, headers, queries);
        }
        return r;
    }

    # Tasks related to a cases resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function listCaseTasks(string id, ListCaseTasksHeaders headers = {}, *ListCaseTasksQueries queries) returns TasksResourcesResponseSchema|TasksResourceReferencesResponseSchema|error {
        TasksResourcesResponseSchema|TasksResourceReferencesResponseSchema|error r = self.oasClient->listCaseTasks(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCaseTasks(id, headers, queries);
        }
        return r;
    }

    # Users related to a cases resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function getCaseCreator(string id, GetCaseCreatorHeaders headers = {}, *GetCaseCreatorQueries queries) returns UsersResourceResponseSchema|UsersResourceReferencesResponseSchema|error {
        UsersResourceResponseSchema|UsersResourceReferencesResponseSchema|error r = self.oasClient->getCaseCreator(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getCaseCreator(id, headers, queries);
        }
        return r;
    }

    # List of files resources
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function listFiles(ListFilesHeaders headers = {}, *ListFilesQueries queries) returns FilesResourcesResponseSchema|FilesResourceReferencesResponseSchema|error {
        FilesResourcesResponseSchema|FilesResourceReferencesResponseSchema|error r = self.oasClient->listFiles(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listFiles(headers, queries);
        }
        return r;
    }

    # Files resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function getFile(string id, GetFileHeaders headers = {}, *GetFileQueries queries) returns FilesResourceResponseSchema|FilesResourceReferencesResponseSchema|error {
        FilesResourceResponseSchema|FilesResourceReferencesResponseSchema|error r = self.oasClient->getFile(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getFile(id, headers, queries);
        }
        return r;
    }

    # List of groups resources
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function listGroups(ListGroupsHeaders headers = {}, *ListGroupsQueries queries) returns GroupsResourcesResponseSchema|GroupsResourceReferencesResponseSchema|error {
        GroupsResourcesResponseSchema|GroupsResourceReferencesResponseSchema|error r = self.oasClient->listGroups(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listGroups(headers, queries);
        }
        return r;
    }

    # Groups resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function getGroup(string id, GetGroupHeaders headers = {}, *GetGroupQueries queries) returns GroupsResourceResponseSchema|GroupsResourceReferencesResponseSchema|error {
        GroupsResourceResponseSchema|GroupsResourceReferencesResponseSchema|error r = self.oasClient->getGroup(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getGroup(id, headers, queries);
        }
        return r;
    }

    # Users references related to a groups resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + return - OK
    remote isolated function listGroupUserRefs(string id, ListGroupUserRefsHeaders headers = {}) returns UsersResourceReferencesResponseSchema|error {
        UsersResourceReferencesResponseSchema|error r = self.oasClient->listGroupUserRefs(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listGroupUserRefs(id, headers);
        }
        return r;
    }

    # Users related to a groups resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function listGroupUsers(string id, ListGroupUsersHeaders headers = {}, *ListGroupUsersQueries queries) returns UsersResourcesResponseSchema|UsersResourceReferencesResponseSchema|error {
        UsersResourcesResponseSchema|UsersResourceReferencesResponseSchema|error r = self.oasClient->listGroupUsers(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listGroupUsers(id, headers, queries);
        }
        return r;
    }

    # List of tasks resources
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function listTasks(ListTasksHeaders headers = {}, *ListTasksQueries queries) returns TasksResourcesResponseSchema|TasksResourceReferencesResponseSchema|error {
        TasksResourcesResponseSchema|TasksResourceReferencesResponseSchema|error r = self.oasClient->listTasks(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listTasks(headers, queries);
        }
        return r;
    }

    # Tasks resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function getTask(string id, GetTaskHeaders headers = {}, *GetTaskQueries queries) returns TasksResourceResponseSchema|TasksResourceReferencesResponseSchema|error {
        TasksResourceResponseSchema|TasksResourceReferencesResponseSchema|error r = self.oasClient->getTask(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getTask(id, headers, queries);
        }
        return r;
    }

    # Case related to a tasks resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function getTaskCase(string id, GetTaskCaseHeaders headers = {}, *GetTaskCaseQueries queries) returns CasesResourceResponseSchema|CasesResourceReferencesResponseSchema|error {
        CasesResourceResponseSchema|CasesResourceReferencesResponseSchema|error r = self.oasClient->getTaskCase(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getTaskCase(id, headers, queries);
        }
        return r;
    }

    # Case reference related to a tasks resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + return - OK
    remote isolated function getTaskCaseRef(string id, GetTaskCaseRefHeaders headers = {}) returns CasesResourceReferenceResponseSchema|CasesResourceReferencesResponseSchema|error {
        CasesResourceReferenceResponseSchema|CasesResourceReferencesResponseSchema|error r = self.oasClient->getTaskCaseRef(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getTaskCaseRef(id, headers);
        }
        return r;
    }

    # List of users resources
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function listUsers(ListUsersHeaders headers = {}, *ListUsersQueries queries) returns UsersResourcesResponseSchema|UsersResourceReferencesResponseSchema|error {
        UsersResourcesResponseSchema|UsersResourceReferencesResponseSchema|error r = self.oasClient->listUsers(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listUsers(headers, queries);
        }
        return r;
    }

    # Users resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - OK
    remote isolated function getUser(string id, GetUserHeaders headers = {}, *GetUserQueries queries) returns UsersResourceResponseSchema|UsersResourceReferencesResponseSchema|error {
        UsersResourceResponseSchema|UsersResourceReferencesResponseSchema|error r = self.oasClient->getUser(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getUser(id, headers, queries);
        }
        return r;
    }

    # Add automatic measurement to existing metrics.
    #
    # + journeyId - The ID of the journey to be updated
    # + metricId - The ID of the metric to be updated
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Updated successfully
    remote isolated function addAutomaticMeasurementToMetric(string journeyId, string metricId, AutomaticMeasurement payload, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->addAutomaticMeasurementToMetric(journeyId, metricId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addAutomaticMeasurementToMetric(journeyId, metricId, payload, headers);
        }
        return r;
    }

    # Create an API access token (login)
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Authentication successful. Following successful authentication, subsequent authenticated API requests must include the 'JSESSIONID' cookie
    remote isolated function authenticate(TokenRequest payload, AuthenticateHeaders headers = {}) returns string|error {
        string|error r = self.oasClient->authenticate(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->authenticate(payload, headers);
        }
        return r;
    }

    # Lists dictionary entries, optionally filtered by category, and with full-text search or title initial letter filter.
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - A JSON representation of the search results. All dictionary entries are contained in a top-level array (bounded by `[` and `]`),  and contain the key-value pair `"rel": "gitem"` (for 'glossary  item'). The important fields inside the content of their `rep`  object have the same semantics as is defined for dictionary entry  creation. They are:   * `id`   * `title`   * `category`   * `description`   * `attachments` Some fields provide additional information on the entry's category:   * `categoryName`   * `color` **Hint:** If the category ID in the `category` query string is not found, the response includes all categories instead of having a 404  Not Found status
    remote isolated function listDictionaryEntries(ListDictionaryEntriesHeaders headers = {}, *ListDictionaryEntriesQueries queries) returns DictionaryResponse[]|error {
        DictionaryResponse[]|error r = self.oasClient->listDictionaryEntries(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listDictionaryEntries(headers, queries);
        }
        return r;
    }

    # Creates a dictionary entry.
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Returns a JSON object containing the created dictionary item
    remote isolated function createDictionaryEntry(DictionaryEntryRequest payload, CreateDictionaryEntryHeaders headers = {}) returns DictionaryResponse|error {
        DictionaryResponse|error r = self.oasClient->createDictionaryEntry(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createDictionaryEntry(payload, headers);
        }
        return r;
    }

    # Retrieves the specified dictionary entry.
    #
    # + id - The ID of the dictionary entry to retrieve
    # + headers - Headers to be sent with the request
    # + return - Success
    remote isolated function getDictionaryEntry(string id, GetDictionaryEntryHeaders headers = {}) returns DictionaryResponse[]|error {
        DictionaryResponse[]|error r = self.oasClient->getDictionaryEntry(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDictionaryEntry(id, headers);
        }
        return r;
    }

    # Deletes a dictionary entry.
    #
    # + id - The ID of the dictionary entry to delete
    # + headers - Headers to be sent with the request
    # + return - OK
    remote isolated function deleteDictionaryEntry(string id, DeleteDictionaryEntryHeaders headers = {}) returns SuccessResponse|error {
        SuccessResponse|error r = self.oasClient->deleteDictionaryEntry(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteDictionaryEntry(id, headers);
        }
        return r;
    }

    # Retrieves the specified dictionary entry with additional meta  information: most importantly, the category containing the entry.
    #
    # + id - The ID of the dictionary entry to retrieve
    # + headers - Headers to be sent with the request
    # + return - Success
    remote isolated function getDictionaryEntryInfo(string id, GetDictionaryEntryInfoHeaders headers = {}) returns Representation|error {
        Representation|error r = self.oasClient->getDictionaryEntryInfo(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDictionaryEntryInfo(id, headers);
        }
        return r;
    }

    # Updates a dictionary entry.
    #
    # + id - The ID of the dictionary entry to update
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - OK
    remote isolated function updateDictionaryEntry(string id, DictionaryEntryUpdateRequest payload, UpdateDictionaryEntryHeaders headers = {}) returns DictionaryResponse|error {
        DictionaryResponse|error r = self.oasClient->updateDictionaryEntry(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateDictionaryEntry(id, payload, headers);
        }
        return r;
    }

    # Retrieves a list of your workspace's dictionary categories.
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - Returns a list of all dictionary categories. The content data is  partly made up of information as described in  `POST /glossarycategory`. Additionally, each category contains the following information:   * `childCategories`: Array of prefixed IDs of categories that have   this category as parent category.   * `childCategoryCount`: The number of child categories.   * `glossaryId`: ID of the workspaces’s Dictionary (not relevant for    API access).   * `itemCount`: The number of dictionary entries in this category    (excluding those in sub-categories).   * `items`: Array of IDs of the contained dictionary entries    (deprecated).   * If the category corresponds to one of the six standard     categories, this field is set. For example, some reports     consider the content of these categories. The following     `oldCategories` exist:     * `ORG_UNIT` - Organizational units     * `DOCUMENT` - Documents     * `ACTIVITY` - Activities     * `STATE` - Events     * `IT_SYSTEM` - IT systems     * `NONE` - Everything else
    remote isolated function listDictionaryCategories(ListDictionaryCategoriesHeaders headers = {}, *ListDictionaryCategoriesQueries queries) returns DictionaryResponse[]|error {
        DictionaryResponse[]|error r = self.oasClient->listDictionaryCategories(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listDictionaryCategories(headers, queries);
        }
        return r;
    }

    # Creates a dictionary category.
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - The newly created category
    remote isolated function createDictionaryCategory(DictionaryCategoryRequest payload, CreateDictionaryCategoryHeaders headers = {}) returns DictionaryResponse|error {
        DictionaryResponse|error r = self.oasClient->createDictionaryCategory(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createDictionaryCategory(payload, headers);
        }
        return r;
    }

    # Retrieves the specified dictionary category.
    #
    # + id - The ID of the dictionary category to retrieve
    # + headers - Headers to be sent with the request
    # + return - A list of this category's sub-categories (`rel` is `cat`), and an  object with information on the category itself (`rel` is `info`).  Sending a `GET` request to `/p/glossarycategory/(id)/info` request  will fetch the information object only
    remote isolated function getDictionaryCategory(string id, GetDictionaryCategoryHeaders headers = {}) returns DictionaryResponse[]|error {
        DictionaryResponse[]|error r = self.oasClient->getDictionaryCategory(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDictionaryCategory(id, headers);
        }
        return r;
    }

    # Updates an existing dictionary category.
    #
    # + id - The ID of the dictionary category to update
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Success
    remote isolated function updateDictionaryCategory(string id, DictionaryCategoryRequest payload, UpdateDictionaryCategoryHeaders headers = {}) returns DictionaryResponse|error {
        DictionaryResponse|error r = self.oasClient->updateDictionaryCategory(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateDictionaryCategory(id, payload, headers);
        }
        return r;
    }

    # Deletes a dictionary category.
    #
    # + id - The dictionary category to delete
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - Success
    remote isolated function deleteDictionaryCategory(string id, DeleteDictionaryCategoryHeaders headers = {}, *DeleteDictionaryCategoryQueries queries) returns SuccessResponse|error {
        SuccessResponse|error r = self.oasClient->deleteDictionaryCategory(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteDictionaryCategory(id, headers, queries);
        }
        return r;
    }

    # Retrieves your workspace's root folders' metadata.
    #
    # + headers - Headers to be sent with the request
    # + return - Returns four resources, which represent a workspace's root folders:   * `Shared Documents` folder   * `My Documents` folder   * `Trash`   * `Dictionary` **Note:** The actual folder names may differ depending on the workspace language. Each resource's `rel` and `type` properties differ, depending on the resource type. The folders  `Shared Documents`, `My Documents` and `Trash` have the `rel` field set to `dir` and are tagged with a  `type` field, which can be either `public`, `private` or `trash`. Such type fields are only defined for  root folder structures. For the Dictionary, the `rel` field is set to `glos` (from 'glossary'). **Hint:** Although the `href` property values start with a `/` they are relative to the base URL path  rather than being absolute URL paths
    remote isolated function getRootDirectories(map<string|string[]> headers = {}) returns HyperMediaObject[]|error {
        HyperMediaObject[]|error r = self.oasClient->getRootDirectories(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getRootDirectories(headers);
        }
        return r;
    }

    # Create a new directory
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully created folder and returns its meta-data. **Hint:** The expected HTTP response status is `200 OK` rather than `201 Created`
    remote isolated function createDirectory(CreateDirectoryRequest payload, map<string|string[]> headers = {}) returns HyperMediaObject|error {
        HyperMediaObject|error r = self.oasClient->createDirectory(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createDirectory(payload, headers);
        }
        return r;
    }

    # Get meta-data of items in a given directory.
    #
    # + id - The ID of the directory to get the content of
    # + headers - Headers to be sent with the request
    # + return - Successfully provided meta-data of all items in the directory
    remote isolated function getDirectoryContent(DirectoryId id, map<string|string[]> headers = {}) returns HyperMediaObject[]|error {
        HyperMediaObject[]|error r = self.oasClient->getDirectoryContent(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDirectoryContent(id, headers);
        }
        return r;
    }

    # Move a given directory.
    #
    # + id - The ID of the directory to move
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully moved the directory and returned its updated meta-data
    remote isolated function moveDirectory(DirectoryId id, MoveDirectoryRequest payload, map<string|string[]> headers = {}) returns HyperMediaObject|error {
        HyperMediaObject|error r = self.oasClient->moveDirectory(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->moveDirectory(id, payload, headers);
        }
        return r;
    }

    # Delete a directory.
    #
    # + id - The ID of the directory to delete
    # + headers - Headers to be sent with the request
    # + return - successfully deleted the directory
    remote isolated function deleteDirectory(DirectoryId id, map<string|string[]> headers = {}) returns DeleteDirectoryResponse|error {
        DeleteDirectoryResponse|error r = self.oasClient->deleteDirectory(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteDirectory(id, headers);
        }
        return r;
    }

    # Meta-data of a given directory.
    #
    # + id - The ID of the directory to get the meta-data of
    # + headers - Headers to be sent with the request
    # + return - Successfully provided meta-data of the directory
    remote isolated function getDirectoryInfo(DirectoryId id, map<string|string[]> headers = {}) returns DirectoryInfo|error {
        DirectoryInfo|error r = self.oasClient->getDirectoryInfo(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDirectoryInfo(id, headers);
        }
        return r;
    }

    # Rename a given directory.
    #
    # + id - The ID of the directory to rename
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully renamed the directory and returned its updated meta-data
    remote isolated function renameDirectory(DirectoryId id, RenameDirectoryData payload, map<string|string[]> headers = {}) returns DirectoryInfo|error {
        DirectoryInfo|error r = self.oasClient->renameDirectory(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->renameDirectory(id, payload, headers);
        }
        return r;
    }

    # publish/unpublish an item
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - successfully published or unpublished the item
    remote isolated function publishItem(PublishData payload, map<string|string[]> headers = {}) returns HyperMediaObject[]|error {
        HyperMediaObject[]|error r = self.oasClient->publishItem(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->publishItem(payload, headers);
        }
        return r;
    }

    # Get the model diagram as JSON
    #
    # + modelId - The ID of the model to be retrieved
    # + headers - Headers to be sent with the request
    # + return - Workflow model data successfully retrieved
    remote isolated function getModelJson(string modelId, map<string|string[]> headers = {}) returns DiagramJson|error {
        DiagramJson|error r = self.oasClient->getModelJson(modelId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getModelJson(modelId, headers);
        }
        return r;
    }

    # Get revision JSON.
    #
    # + revisionId - The ID of the revision to be retrieved
    # + headers - Headers to be sent with the request
    # + return - JSON representation of a model successfully retrieved
    remote isolated function getRevisionJson(string revisionId, map<string|string[]> headers = {}) returns DiagramJson|error {
        DiagramJson|error r = self.oasClient->getRevisionJson(revisionId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getRevisionJson(revisionId, headers);
        }
        return r;
    }

    # Get the model diagram as a PNG image
    #
    # + modelId - The ID of the model
    # + headers - Headers to be sent with the request
    # + return - Success
    remote isolated function getPng(string modelId, map<string|string[]> headers = {}) returns byte[]|error {
        byte[]|error r = self.oasClient->getPng(modelId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getPng(modelId, headers);
        }
        return r;
    }

    # Get revision PNG.
    #
    # + revisionId - Revision ID
    # + headers - Headers to be sent with the request
    # + return - Success
    remote isolated function getRevisionPng(string revisionId, map<string|string[]> headers = {}) returns byte[]|error {
        byte[]|error r = self.oasClient->getRevisionPng(revisionId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getRevisionPng(revisionId, headers);
        }
        return r;
    }

    # Get BPMN 2.0 XML
    #
    # + modelId - The ID of the model
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - Success
    remote isolated function getBpmnXml(string modelId, map<string|string[]> headers = {}, *GetBpmnXmlQueries queries) returns xml|error {
        xml|error r = self.oasClient->getBpmnXml(modelId, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getBpmnXml(modelId, headers, queries);
        }
        return r;
    }

    # Get revision BPMN 2.0 XML
    #
    # + revisionId - The ID of the model revision
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - Success
    remote isolated function getRevisionBpmnXml(string revisionId, map<string|string[]> headers = {}, *GetRevisionBpmnXmlQueries queries) returns xml|error {
        xml|error r = self.oasClient->getRevisionBpmnXml(revisionId, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getRevisionBpmnXml(revisionId, headers, queries);
        }
        return r;
    }

    # Get the model diagram as an SVG image
    #
    # + modelId - The ID of the model
    # + headers - Headers to be sent with the request
    # + return - Success
    remote isolated function getSvg(string modelId, map<string|string[]> headers = {}) returns http:Response|error {
        http:Response|error r = self.oasClient->getSvg(modelId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getSvg(modelId, headers);
        }
        return r;
    }

    # Get revision SVG.
    #
    # + revisionId - Revision ID
    # + headers - Headers to be sent with the request
    # + return - SVG representation
    remote isolated function getRevisionSvg(string revisionId, map<string|string[]> headers = {}) returns http:Response|error {
        http:Response|error r = self.oasClient->getRevisionSvg(revisionId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getRevisionSvg(revisionId, headers);
        }
        return r;
    }

    # Import BPMN 2.0 XML
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Success
    remote isolated function importBpmn20Xml(BpmnImportRequest payload, map<string|string[]> headers = {}) returns BpmnImportResult|error {
        BpmnImportResult|error r = self.oasClient->importBpmn20Xml(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->importBpmn20Xml(payload, headers);
        }
        return r;
    }

    # Retrieve download link to xml
    #
    # + id - The ID of the model
    # + headers - Headers to be sent with the request
    # + return - Successful response
    remote isolated function getDmnDownloadLink(string id, map<string|string[]> headers = {}) returns DmnDownloadLinkResponse|error {
        DmnDownloadLinkResponse|error r = self.oasClient->getDmnDownloadLink(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDmnDownloadLink(id, headers);
        }
        return r;
    }

    # Download DMN XML
    #
    # + id - The download id provided from /dmn-xml-download/{id}
    # + headers - Headers to be sent with the request
    # + return - File downloaded successfully
    remote isolated function downloadDmnXml(string id, map<string|string[]> headers = {}) returns byte[]|error {
        byte[]|error r = self.oasClient->downloadDmnXml(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->downloadDmnXml(id, headers);
        }
        return r;
    }

    # Upload schema and data
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - OK
    remote isolated function uploadSchemaAndData(IngestionDataRequest payload, map<string|string[]> headers = {}) returns UploadSchemaAndDataResponseDto|error {
        UploadSchemaAndDataResponseDto|error r = self.oasClient->uploadSchemaAndData(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->uploadSchemaAndData(payload, headers);
        }
        return r;
    }

    # Get status of ingestion request
    #
    # + executionId - Ingestion request execution Id
    # + headers - Headers to be sent with the request
    # + return - OK
    remote isolated function getStatus(string executionId, map<string|string[]> headers = {}) returns ExecutionStatusDto|error {
        ExecutionStatusDto|error r = self.oasClient->getStatus(executionId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getStatus(executionId, headers);
        }
        return r;
    }

    # List initiatives
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - Success
    remote isolated function listInitiatives(map<string|string[]> headers = {}, *ListInitiativesQueries queries) returns Initiative[]|error {
        Initiative[]|error r = self.oasClient->listInitiatives(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listInitiatives(headers, queries);
        }
        return r;
    }

    # Create initiative
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully created initiative
    remote isolated function createInitiative(IncomingInitiative payload, map<string|string[]> headers = {}) returns Initiative|error {
        Initiative|error r = self.oasClient->createInitiative(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createInitiative(payload, headers);
        }
        return r;
    }

    # Get initiative
    #
    # + initiativeId - The id of the initiative to retrieve
    # + headers - Headers to be sent with the request
    # + return - Success
    remote isolated function getInitiative(UUID initiativeId, map<string|string[]> headers = {}) returns Initiative|error {
        Initiative|error r = self.oasClient->getInitiative(initiativeId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getInitiative(initiativeId, headers);
        }
        return r;
    }

    # Update initiative
    #
    # + initiativeId - The id of the initiative to update
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully updated initiative
    remote isolated function updateInitiative(UUID initiativeId, IncomingInitiative payload, map<string|string[]> headers = {}) returns Initiative|error {
        Initiative|error r = self.oasClient->updateInitiative(initiativeId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateInitiative(initiativeId, payload, headers);
        }
        return r;
    }

    # Delete initiative
    #
    # + initiativeId - The id of the initiative to delete
    # + headers - Headers to be sent with the request
    # + return - Successfully deleted initiative
    remote isolated function deleteInitiative(UUID initiativeId, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->deleteInitiative(initiativeId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteInitiative(initiativeId, headers);
        }
        return r;
    }

    # List assets from initiative
    #
    # + initiativeId - The id of the initiative containing the assets
    # + headers - Headers to be sent with the request
    # + return - Success
    remote isolated function listAssetsInitiative(UUID initiativeId, map<string|string[]> headers = {}) returns Asset[]|error {
        Asset[]|error r = self.oasClient->listAssetsInitiative(initiativeId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listAssetsInitiative(initiativeId, headers);
        }
        return r;
    }

    # Create asset in initiative
    #
    # + initiativeId - The id of the initiative to add the asset to
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully created asset
    remote isolated function createAssetInitiative(UUID initiativeId, IncomingAsset payload, map<string|string[]> headers = {}) returns Asset|error {
        Asset|error r = self.oasClient->createAssetInitiative(initiativeId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createAssetInitiative(initiativeId, payload, headers);
        }
        return r;
    }

    # Get asset from initiative
    #
    # + assetId - The id of the asset to retrieve
    # + initiativeId - The id of the initiative containing the asset
    # + headers - Headers to be sent with the request
    # + return - Success
    remote isolated function getAssetInitiative(UUID assetId, UUID initiativeId, map<string|string[]> headers = {}) returns Asset|error {
        Asset|error r = self.oasClient->getAssetInitiative(assetId, initiativeId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getAssetInitiative(assetId, initiativeId, headers);
        }
        return r;
    }

    # Update asset in initiative
    #
    # + assetId - The id of the asset to update
    # + initiativeId - The id of the initiative containing the asset
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully updated asset
    remote isolated function updateAssetInitiative(UUID assetId, UUID initiativeId, IncomingAsset payload, map<string|string[]> headers = {}) returns Asset|error {
        Asset|error r = self.oasClient->updateAssetInitiative(assetId, initiativeId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateAssetInitiative(assetId, initiativeId, payload, headers);
        }
        return r;
    }

    # Delete asset from initiative
    #
    # + assetId - The id of the asset to delete
    # + initiativeId - The id of the initiative containing the asset
    # + headers - Headers to be sent with the request
    # + return - Successfully deleted asset
    remote isolated function deleteAssetInitiative(UUID assetId, UUID initiativeId, map<string|string[]> headers = {}) returns Asset|error {
        Asset|error r = self.oasClient->deleteAssetInitiative(assetId, initiativeId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteAssetInitiative(assetId, initiativeId, headers);
        }
        return r;
    }

    # Get all insights in an initiative
    #
    # + initiativeId - ID of the initiative whose insights should be listed
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - Success
    remote isolated function listInsightsInInitiative(string initiativeId, map<string|string[]> headers = {}, *ListInsightsInInitiativeQueries queries) returns Insight[]|error {
        Insight[]|error r = self.oasClient->listInsightsInInitiative(initiativeId, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listInsightsInInitiative(initiativeId, headers, queries);
        }
        return r;
    }

    # Get insight in initiative
    #
    # + initiativeId - ID of the initiative to which the insight belongs
    # + insightId - ID of the insight to be retrieved
    # + headers - Headers to be sent with the request
    # + return - Success
    remote isolated function getInsightInInitiative(UUID initiativeId, UUID insightId, map<string|string[]> headers = {}) returns Insight|error {
        Insight|error r = self.oasClient->getInsightInInitiative(initiativeId, insightId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getInsightInInitiative(initiativeId, insightId, headers);
        }
        return r;
    }

    # Get all insights
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - Success
    remote isolated function listInsights(map<string|string[]> headers = {}, *ListInsightsQueries queries) returns Insight[]|error {
        Insight[]|error r = self.oasClient->listInsights(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listInsights(headers, queries);
        }
        return r;
    }

    # Create an insight
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully created insight
    remote isolated function createInsight(IncomingInsight payload, map<string|string[]> headers = {}) returns Insight|error {
        Insight|error r = self.oasClient->createInsight(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createInsight(payload, headers);
        }
        return r;
    }

    # Get insight
    #
    # + insightId - The id of the insight to retrieve
    # + headers - Headers to be sent with the request
    # + return - Success
    remote isolated function getInsight(UUID insightId, map<string|string[]> headers = {}) returns Insight|error {
        Insight|error r = self.oasClient->getInsight(insightId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getInsight(insightId, headers);
        }
        return r;
    }

    # Update insight
    #
    # + insightId - The id of the insight to update
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully updated insight
    remote isolated function updateInsight(UUID insightId, IncomingInsight payload, map<string|string[]> headers = {}) returns Insight|error {
        Insight|error r = self.oasClient->updateInsight(insightId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateInsight(insightId, payload, headers);
        }
        return r;
    }

    # Delete insight
    #
    # + insightId - The id of the insight to delete
    # + headers - Headers to be sent with the request
    # + return - Successfully deleted insight
    remote isolated function deleteInsight(UUID insightId, map<string|string[]> headers = {}) returns json|error {
        json|error r = self.oasClient->deleteInsight(insightId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteInsight(insightId, headers);
        }
        return r;
    }

    # Retrieve Model
    #
    # + id - The ID of the model to be retrieved
    # + headers - Headers to be sent with the request
    # + return - Successful Operation
    remote isolated function retrieveModel(string id, map<string|string[]> headers = {}) returns ModelResourceResponse[]|error {
        ModelResourceResponse[]|error r = self.oasClient->retrieveModel(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->retrieveModel(id, headers);
        }
        return r;
    }

    # Update Model
    #
    # + id - The ID of the model to be updated
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - Successful Operation
    remote isolated function updateModel(string id, ModelRequest payload, map<string|string[]> headers = {}, *UpdateModelQueries queries) returns ModelResourceResponse[]|error {
        ModelResourceResponse[]|error r = self.oasClient->updateModel(id, payload, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateModel(id, payload, headers, queries);
        }
        return r;
    }

    # Delete Model
    #
    # + id - The ID of the model to be deleted
    # + headers - Headers to be sent with the request
    # + return - Successful Operation
    remote isolated function deleteModel(string id, map<string|string[]> headers = {}) returns SuccessResponse|error {
        SuccessResponse|error r = self.oasClient->deleteModel(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteModel(id, headers);
        }
        return r;
    }

    # Create a new Model
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - Successful Operation
    remote isolated function createModel(ModelRequest payload, map<string|string[]> headers = {}, *CreateModelQueries queries) returns ModelResponse|error {
        ModelResponse|error r = self.oasClient->createModel(payload, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createModel(payload, headers, queries);
        }
        return r;
    }

    # Retrieving all revision IDs of a model.
    #
    # + modelId - The model's ID
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - Successful Operation
    remote isolated function listModelRevisions(string modelId, map<string|string[]> headers = {}, *ListModelRevisionsQueries queries) returns ModelRevisionsResponse[]|error {
        ModelRevisionsResponse[]|error r = self.oasClient->listModelRevisions(modelId, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listModelRevisions(modelId, headers, queries);
        }
        return r;
    }

    # Update model info
    #
    # + modelId - The ID of the model
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successful operation
    remote isolated function updateModelInfo(string modelId, ModelInfoRequest payload, map<string|string[]> headers = {}) returns ModelInfoResponse|error {
        ModelInfoResponse|error r = self.oasClient->updateModelInfo(modelId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateModelInfo(modelId, payload, headers);
        }
        return r;
    }

    # Performs a syntax check on a BPMN 2.0 process model.
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Syntax check successful
    remote isolated function checkSyntax(SyntaxCheckRequest payload, map<string|string[]> headers = {}) returns SyntaxCheckResponse|error {
        SyntaxCheckResponse|error r = self.oasClient->checkSyntax(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->checkSyntax(payload, headers);
        }
        return r;
    }

    # Create a new model draft.
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - Model created successfully
    remote isolated function createDiagramDraft(map<string|string[]> headers = {}, *CreateDiagramDraftQueries queries) returns DiagramDraftResponse|error {
        DiagramDraftResponse|error r = self.oasClient->createDiagramDraft(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createDiagramDraft(headers, queries);
        }
        return r;
    }

    # Get meta information
    #
    # + headers - Headers to be sent with the request
    # + return - Successfully retrieved meta information
    remote isolated function getMetaInfo(map<string|string[]> headers = {}) returns MetaResponseItem[]|error? {
        MetaResponseItem[]|error? r = self.oasClient->getMetaInfo(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getMetaInfo(headers);
        }
        return r;
    }

    # Create meta information
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully created meta information
    remote isolated function createMetaInfo(MetaInfoRequest payload, map<string|string[]> headers = {}) returns MetaResponseItem|error {
        MetaResponseItem|error r = self.oasClient->createMetaInfo(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createMetaInfo(payload, headers);
        }
        return r;
    }

    # Retrieve the current approval expiration date.
    #
    # + modelID - The ID of the model
    # + headers - Headers to be sent with the request
    # + return - Successfully retrieved the approval expiration date
    remote isolated function getExpirationDate(string modelID, map<string|string[]> headers = {}) returns ExpirationDate|error {
        ExpirationDate|error r = self.oasClient->getExpirationDate(modelID, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getExpirationDate(modelID, headers);
        }
        return r;
    }

    # Update the approval expiration date.
    #
    # + modelID - The ID of the model
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully updated the approval expiration date
    remote isolated function updateExpirationDate(string modelID, ExpirationDate payload, map<string|string[]> headers = {}) returns ExpirationDate|error {
        ExpirationDate|error r = self.oasClient->updateExpirationDate(modelID, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateExpirationDate(modelID, payload, headers);
        }
        return r;
    }

    # Create a new approval expiration date.
    #
    # + modelID - The ID of the model
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully created the approval expiration date
    remote isolated function createExpirationDate(string modelID, ExpirationDate payload, map<string|string[]> headers = {}) returns ExpirationDate|error {
        ExpirationDate|error r = self.oasClient->createExpirationDate(modelID, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createExpirationDate(modelID, payload, headers);
        }
        return r;
    }

    # Delete the current approval expiration date.
    #
    # + modelID - The ID of the model
    # + headers - Headers to be sent with the request
    # + return - Successfully deleted the approval expiration date
    remote isolated function deleteExpirationDate(string modelID, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->deleteExpirationDate(modelID, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteExpirationDate(modelID, headers);
        }
        return r;
    }

    # Get all objectives
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - Success returns objectives wrapped in value array
    remote isolated function listObjectives(map<string|string[]> headers = {}, *ListObjectivesQueries queries) returns ObjectivesResponse|error {
        ObjectivesResponse|error r = self.oasClient->listObjectives(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listObjectives(headers, queries);
        }
        return r;
    }

    # Get objective by SID
    #
    # + objectiveSid - The Suite Objective ID (SID) (e.g. SuiteObjective_<32 hex chars>)
    # + headers - Headers to be sent with the request
    # + return - Success
    remote isolated function getObjective(string objectiveSid, map<string|string[]> headers = {}) returns Objective|error {
        Objective|error r = self.oasClient->getObjective(objectiveSid, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getObjective(objectiveSid, headers);
        }
        return r;
    }

    # Get linked initiatives
    #
    # + objectiveSid - The Suite Objective ID (SID) (e.g. SuiteObjective_<32 hex chars>)
    # + headers - Headers to be sent with the request
    # + return - Success
    remote isolated function getInitiativesByObjective(string objectiveSid, map<string|string[]> headers = {}) returns InitiativeSummaryForObjective[]|error {
        InitiativeSummaryForObjective[]|error r = self.oasClient->getInitiativesByObjective(objectiveSid, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getInitiativesByObjective(objectiveSid, headers);
        }
        return r;
    }

    # Search the workspace
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - JSON array containing folder and model object representations. In the response object with `rel="search"`, the `totalNrOfResults` property gives the total number of results. When there are more than 250 results, the API limits the response array to the first 250 results. You can use the `offset=250` request parameter to fetch the second ‘page’ of results
    remote isolated function search(map<string|string[]> headers = {}, *SearchQueries queries) returns http:Response|error {
        http:Response|error r = self.oasClient->search(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->search(headers, queries);
        }
        return r;
    }

    # Returns all entity sets (Odata views) the user has access to. A JSON list is returned representing the entity set.
    #
    # + headers - Headers to be sent with the request
    # + return - List all entity sets (OData views) the user has access to. The user has access if the underlying resources which the SIGNAL query in the view accesses (tables/views) are accessible. If this is not the case the entity (view) is not returned. A JSON list is given with all entities
    remote isolated function getServiceDocument(map<string|string[]> headers = {}) returns ServiceDocument|error {
        ServiceDocument|error r = self.oasClient->getServiceDocument(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getServiceDocument(headers);
        }
        return r;
    }

    # Returns metadata for all entity sets (OData views) the user has access to. An XML schema is returned representing the metadata.
    #
    # + headers - Headers to be sent with the request
    # + return - Metadata information for all entity sets (OData views) the user has access to. The user has access if the underlying resources which the SIGNAL query in the view accesses (tables/views) are accessible. If this is not the case the entity (view) is not returned. A XML schema is given as metadata
    remote isolated function getMetadata(map<string|string[]> headers = {}) returns xml|error {
        xml|error r = self.oasClient->getMetadata(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getMetadata(headers);
        }
        return r;
    }

    # This endpoint implements an OData service endpoint according to version 4.0 of
    # the OData Protocol specification.
    #
    # + entitySetName - The name for the entity set (in this case, the oData view). Can be returned by calling the /$metadata endpoint
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - Data for the given entity, returned as a JSON schema
    remote isolated function queryEntitySet(string entitySetName, map<string|string[]> headers = {}, *QueryEntitySetQueries queries) returns OdataOutput|error {
        OdataOutput|error r = self.oasClient->queryEntitySet(entitySetName, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->queryEntitySet(entitySetName, headers, queries);
        }
        return r;
    }
}

# Returns whether a client response/error represents an authentication failure (HTTP 401), which
# is the signal to re-authenticate and replay the request once.
#
# + r - The response value or error returned by an `oas` client operation
# + return - `true` if the result is an HTTP 401
isolated function isAuthError(any|error r) returns boolean {
    if r is http:Response {
        return r.statusCode == http:STATUS_UNAUTHORIZED;
    }
    if r is http:ClientRequestError {
        return r.detail().statusCode == http:STATUS_UNAUTHORIZED;
    }
    return false;
}
