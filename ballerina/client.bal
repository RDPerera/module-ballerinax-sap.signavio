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
    # + return - The returned case variables resources response schema
    remote isolated function listCaseVariables(ListCaseVariablesHeaders headers = {}, *ListCaseVariablesQueries queries) returns CaseVariablesResourcesResponseSchema|CaseVariablesResourceReferencesResponseSchema|error {
        CaseVariablesResourcesResponseSchema|CaseVariablesResourceReferencesResponseSchema|error result = self.oasClient->listCaseVariables(headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listCaseVariables(headers, queries);
        }
        return result;
    }

    # Case-variables resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned case variables resource response schema
    remote isolated function getCaseVariable(string id, GetCaseVariableHeaders headers = {}, *GetCaseVariableQueries queries) returns CaseVariablesResourceResponseSchema|CaseVariablesResourceReferencesResponseSchema|error {
        CaseVariablesResourceResponseSchema|CaseVariablesResourceReferencesResponseSchema|error result = self.oasClient->getCaseVariable(id, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getCaseVariable(id, headers, queries);
        }
        return result;
    }

    # Cases related to a case-variables resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned cases resource response schema
    remote isolated function listCaseVariableCases(string id, ListCaseVariableCasesHeaders headers = {}, *ListCaseVariableCasesQueries queries) returns CasesResourceResponseSchema|CasesResourceReferencesResponseSchema|error {
        CasesResourceResponseSchema|CasesResourceReferencesResponseSchema|error result = self.oasClient->listCaseVariableCases(id, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listCaseVariableCases(id, headers, queries);
        }
        return result;
    }

    # Cases references related to a case-variables resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned cases resource reference response schema
    remote isolated function listCaseVariableCaseRefs(string id, ListCaseVariableCaseRefsHeaders headers = {}, *ListCaseVariableCaseRefsQueries queries) returns CasesResourceReferenceResponseSchema|CasesResourceReferencesResponseSchema|error {
        CasesResourceReferenceResponseSchema|CasesResourceReferencesResponseSchema|error result = self.oasClient->listCaseVariableCaseRefs(id, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listCaseVariableCaseRefs(id, headers, queries);
        }
        return result;
    }

    # List of cases resources
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned cases resources response schema
    remote isolated function listCases(ListCasesHeaders headers = {}, *ListCasesQueries queries) returns CasesResourcesResponseSchema|CasesResourceReferencesResponseSchema|error {
        CasesResourcesResponseSchema|CasesResourceReferencesResponseSchema|error result = self.oasClient->listCases(headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listCases(headers, queries);
        }
        return result;
    }

    # Cases resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned cases resource response schema
    remote isolated function getCase(string id, GetCaseHeaders headers = {}, *GetCaseQueries queries) returns CasesResourceResponseSchema|error {
        CasesResourceResponseSchema|error result = self.oasClient->getCase(id, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getCase(id, headers, queries);
        }
        return result;
    }

    # Tasks related to a cases resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned tasks resources response schema
    remote isolated function listCaseTasks(string id, ListCaseTasksHeaders headers = {}, *ListCaseTasksQueries queries) returns TasksResourcesResponseSchema|TasksResourceReferencesResponseSchema|error {
        TasksResourcesResponseSchema|TasksResourceReferencesResponseSchema|error result = self.oasClient->listCaseTasks(id, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listCaseTasks(id, headers, queries);
        }
        return result;
    }

    # Users related to a cases resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned users resource response schema
    remote isolated function getCaseCreator(string id, GetCaseCreatorHeaders headers = {}, *GetCaseCreatorQueries queries) returns UsersResourceResponseSchema|UsersResourceReferencesResponseSchema|error {
        UsersResourceResponseSchema|UsersResourceReferencesResponseSchema|error result = self.oasClient->getCaseCreator(id, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getCaseCreator(id, headers, queries);
        }
        return result;
    }

    # List of files resources
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned files resources response schema
    remote isolated function listFiles(ListFilesHeaders headers = {}, *ListFilesQueries queries) returns FilesResourcesResponseSchema|FilesResourceReferencesResponseSchema|error {
        FilesResourcesResponseSchema|FilesResourceReferencesResponseSchema|error result = self.oasClient->listFiles(headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listFiles(headers, queries);
        }
        return result;
    }

    # Files resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned files resource response schema
    remote isolated function getFile(string id, GetFileHeaders headers = {}, *GetFileQueries queries) returns FilesResourceResponseSchema|FilesResourceReferencesResponseSchema|error {
        FilesResourceResponseSchema|FilesResourceReferencesResponseSchema|error result = self.oasClient->getFile(id, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getFile(id, headers, queries);
        }
        return result;
    }

    # List of groups resources
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned groups resources response schema
    remote isolated function listGroups(ListGroupsHeaders headers = {}, *ListGroupsQueries queries) returns GroupsResourcesResponseSchema|GroupsResourceReferencesResponseSchema|error {
        GroupsResourcesResponseSchema|GroupsResourceReferencesResponseSchema|error result = self.oasClient->listGroups(headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listGroups(headers, queries);
        }
        return result;
    }

    # Groups resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned groups resource response schema
    remote isolated function getGroup(string id, GetGroupHeaders headers = {}, *GetGroupQueries queries) returns GroupsResourceResponseSchema|GroupsResourceReferencesResponseSchema|error {
        GroupsResourceResponseSchema|GroupsResourceReferencesResponseSchema|error result = self.oasClient->getGroup(id, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getGroup(id, headers, queries);
        }
        return result;
    }

    # Users references related to a groups resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + return - The returned users resource references response schema
    remote isolated function listGroupUserRefs(string id, ListGroupUserRefsHeaders headers = {}) returns UsersResourceReferencesResponseSchema|error {
        UsersResourceReferencesResponseSchema|error result = self.oasClient->listGroupUserRefs(id, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listGroupUserRefs(id, headers);
        }
        return result;
    }

    # Users related to a groups resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned users resources response schema
    remote isolated function listGroupUsers(string id, ListGroupUsersHeaders headers = {}, *ListGroupUsersQueries queries) returns UsersResourcesResponseSchema|UsersResourceReferencesResponseSchema|error {
        UsersResourcesResponseSchema|UsersResourceReferencesResponseSchema|error result = self.oasClient->listGroupUsers(id, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listGroupUsers(id, headers, queries);
        }
        return result;
    }

    # List of tasks resources
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned tasks resources response schema
    remote isolated function listTasks(ListTasksHeaders headers = {}, *ListTasksQueries queries) returns TasksResourcesResponseSchema|TasksResourceReferencesResponseSchema|error {
        TasksResourcesResponseSchema|TasksResourceReferencesResponseSchema|error result = self.oasClient->listTasks(headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listTasks(headers, queries);
        }
        return result;
    }

    # Tasks resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned tasks resource response schema
    remote isolated function getTask(string id, GetTaskHeaders headers = {}, *GetTaskQueries queries) returns TasksResourceResponseSchema|TasksResourceReferencesResponseSchema|error {
        TasksResourceResponseSchema|TasksResourceReferencesResponseSchema|error result = self.oasClient->getTask(id, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getTask(id, headers, queries);
        }
        return result;
    }

    # Case related to a tasks resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned cases resource response schema
    remote isolated function getTaskCase(string id, GetTaskCaseHeaders headers = {}, *GetTaskCaseQueries queries) returns CasesResourceResponseSchema|CasesResourceReferencesResponseSchema|error {
        CasesResourceResponseSchema|CasesResourceReferencesResponseSchema|error result = self.oasClient->getTaskCase(id, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getTaskCase(id, headers, queries);
        }
        return result;
    }

    # Case reference related to a tasks resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + return - The returned cases resource reference response schema
    remote isolated function getTaskCaseRef(string id, GetTaskCaseRefHeaders headers = {}) returns CasesResourceReferenceResponseSchema|CasesResourceReferencesResponseSchema|error {
        CasesResourceReferenceResponseSchema|CasesResourceReferencesResponseSchema|error result = self.oasClient->getTaskCaseRef(id, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getTaskCaseRef(id, headers);
        }
        return result;
    }

    # List of users resources
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned users resources response schema
    remote isolated function listUsers(ListUsersHeaders headers = {}, *ListUsersQueries queries) returns UsersResourcesResponseSchema|UsersResourceReferencesResponseSchema|error {
        UsersResourcesResponseSchema|UsersResourceReferencesResponseSchema|error result = self.oasClient->listUsers(headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listUsers(headers, queries);
        }
        return result;
    }

    # Users resource
    #
    # + id - case primary key to include
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned users resource response schema
    remote isolated function getUser(string id, GetUserHeaders headers = {}, *GetUserQueries queries) returns UsersResourceResponseSchema|UsersResourceReferencesResponseSchema|error {
        UsersResourceResponseSchema|UsersResourceReferencesResponseSchema|error result = self.oasClient->getUser(id, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getUser(id, headers, queries);
        }
        return result;
    }

    # Add automatic measurement to existing metrics.
    #
    # + journeyId - The ID of the journey to be updated
    # + metricId - The ID of the metric to be updated
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Updated successfully
    remote isolated function addAutomaticMeasurementToMetric(string journeyId, string metricId, AutomaticMeasurement payload, map<string|string[]> headers = {}) returns error? {
        error? result = self.oasClient->addAutomaticMeasurementToMetric(journeyId, metricId, payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->addAutomaticMeasurementToMetric(journeyId, metricId, payload, headers);
        }
        return result;
    }

    # Create an API access token (login)
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Authentication successful. Following successful authentication, subsequent authenticated API requests must include the 'JSESSIONID' cookie
    remote isolated function authenticate(TokenRequest payload, AuthenticateHeaders headers = {}) returns string|error {
        string|error result = self.oasClient->authenticate(payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->authenticate(payload, headers);
        }
        return result;
    }

    # Lists dictionary entries, optionally filtered by category, and with full-text search or title initial letter filter.
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - A JSON representation of the search results. All dictionary entries are contained in a top-level array (bounded by `[` and `]`),  and contain the key-value pair `"rel": "gitem"` (for 'glossary  item'). The important fields inside the content of their `rep`  object have the same semantics as is defined for dictionary entry  creation. They are:   * `id`   * `title`   * `category`   * `description`   * `attachments` Some fields provide additional information on the entry's category:   * `categoryName`   * `color` **Hint:** If the category ID in the `category` query string is not found, the response includes all categories instead of having a 404  Not Found status
    remote isolated function listDictionaryEntries(ListDictionaryEntriesHeaders headers = {}, *ListDictionaryEntriesQueries queries) returns DictionaryResponse[]|error {
        DictionaryResponse[]|error result = self.oasClient->listDictionaryEntries(headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listDictionaryEntries(headers, queries);
        }
        return result;
    }

    # Creates a dictionary entry.
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Returns a JSON object containing the created dictionary item
    remote isolated function createDictionaryEntry(DictionaryEntryRequest payload, CreateDictionaryEntryHeaders headers = {}) returns DictionaryResponse|error {
        DictionaryResponse|error result = self.oasClient->createDictionaryEntry(payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->createDictionaryEntry(payload, headers);
        }
        return result;
    }

    # Retrieves the specified dictionary entry.
    #
    # + id - The ID of the dictionary entry to retrieve
    # + headers - Headers to be sent with the request
    # + return - The returned dictionary response list
    remote isolated function getDictionaryEntry(string id, GetDictionaryEntryHeaders headers = {}) returns DictionaryResponse[]|error {
        DictionaryResponse[]|error result = self.oasClient->getDictionaryEntry(id, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getDictionaryEntry(id, headers);
        }
        return result;
    }

    # Deletes a dictionary entry.
    #
    # + id - The ID of the dictionary entry to delete
    # + headers - Headers to be sent with the request
    # + return - The returned success response
    remote isolated function deleteDictionaryEntry(string id, DeleteDictionaryEntryHeaders headers = {}) returns SuccessResponse|error {
        SuccessResponse|error result = self.oasClient->deleteDictionaryEntry(id, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->deleteDictionaryEntry(id, headers);
        }
        return result;
    }

    # Retrieves the specified dictionary entry with additional meta  information: most importantly, the category containing the entry.
    #
    # + id - The ID of the dictionary entry to retrieve
    # + headers - Headers to be sent with the request
    # + return - The returned representation
    remote isolated function getDictionaryEntryInfo(string id, GetDictionaryEntryInfoHeaders headers = {}) returns Representation|error {
        Representation|error result = self.oasClient->getDictionaryEntryInfo(id, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getDictionaryEntryInfo(id, headers);
        }
        return result;
    }

    # Updates a dictionary entry.
    #
    # + id - The ID of the dictionary entry to update
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - The returned dictionary response
    remote isolated function updateDictionaryEntry(string id, DictionaryEntryUpdateRequest payload, UpdateDictionaryEntryHeaders headers = {}) returns DictionaryResponse|error {
        DictionaryResponse|error result = self.oasClient->updateDictionaryEntry(id, payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->updateDictionaryEntry(id, payload, headers);
        }
        return result;
    }

    # Retrieves a list of your workspace's dictionary categories.
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - Returns a list of all dictionary categories. The content data is  partly made up of information as described in  `POST /glossarycategory`. Additionally, each category contains the following information:   * `childCategories`: Array of prefixed IDs of categories that have   this category as parent category.   * `childCategoryCount`: The number of child categories.   * `glossaryId`: ID of the workspaces’s Dictionary (not relevant for    API access).   * `itemCount`: The number of dictionary entries in this category    (excluding those in sub-categories).   * `items`: Array of IDs of the contained dictionary entries    (deprecated).   * If the category corresponds to one of the six standard     categories, this field is set. For example, some reports     consider the content of these categories. The following     `oldCategories` exist:     * `ORG_UNIT` - Organizational units     * `DOCUMENT` - Documents     * `ACTIVITY` - Activities     * `STATE` - Events     * `IT_SYSTEM` - IT systems     * `NONE` - Everything else
    remote isolated function listDictionaryCategories(ListDictionaryCategoriesHeaders headers = {}, *ListDictionaryCategoriesQueries queries) returns DictionaryResponse[]|error {
        DictionaryResponse[]|error result = self.oasClient->listDictionaryCategories(headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listDictionaryCategories(headers, queries);
        }
        return result;
    }

    # Creates a dictionary category.
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - The newly created category
    remote isolated function createDictionaryCategory(DictionaryCategoryRequest payload, CreateDictionaryCategoryHeaders headers = {}) returns DictionaryResponse|error {
        DictionaryResponse|error result = self.oasClient->createDictionaryCategory(payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->createDictionaryCategory(payload, headers);
        }
        return result;
    }

    # Retrieves the specified dictionary category.
    #
    # + id - The ID of the dictionary category to retrieve
    # + headers - Headers to be sent with the request
    # + return - A list of this category's sub-categories (`rel` is `cat`), and an  object with information on the category itself (`rel` is `info`).  Sending a `GET` request to `/p/glossarycategory/(id)/info` request  will fetch the information object only
    remote isolated function getDictionaryCategory(string id, GetDictionaryCategoryHeaders headers = {}) returns DictionaryResponse[]|error {
        DictionaryResponse[]|error result = self.oasClient->getDictionaryCategory(id, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getDictionaryCategory(id, headers);
        }
        return result;
    }

    # Updates an existing dictionary category.
    #
    # + id - The ID of the dictionary category to update
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - The returned dictionary response
    remote isolated function updateDictionaryCategory(string id, DictionaryCategoryRequest payload, UpdateDictionaryCategoryHeaders headers = {}) returns DictionaryResponse|error {
        DictionaryResponse|error result = self.oasClient->updateDictionaryCategory(id, payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->updateDictionaryCategory(id, payload, headers);
        }
        return result;
    }

    # Deletes a dictionary category.
    #
    # + id - The dictionary category to delete
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned success response
    remote isolated function deleteDictionaryCategory(string id, DeleteDictionaryCategoryHeaders headers = {}, *DeleteDictionaryCategoryQueries queries) returns SuccessResponse|error {
        SuccessResponse|error result = self.oasClient->deleteDictionaryCategory(id, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->deleteDictionaryCategory(id, headers, queries);
        }
        return result;
    }

    # Retrieves your workspace's root folders' metadata.
    #
    # + headers - Headers to be sent with the request
    # + return - Returns four resources, which represent a workspace's root folders:   * `Shared Documents` folder   * `My Documents` folder   * `Trash`   * `Dictionary` **Note:** The actual folder names may differ depending on the workspace language. Each resource's `rel` and `type` properties differ, depending on the resource type. The folders  `Shared Documents`, `My Documents` and `Trash` have the `rel` field set to `dir` and are tagged with a  `type` field, which can be either `public`, `private` or `trash`. Such type fields are only defined for  root folder structures. For the Dictionary, the `rel` field is set to `glos` (from 'glossary'). **Hint:** Although the `href` property values start with a `/` they are relative to the base URL path  rather than being absolute URL paths
    remote isolated function getRootDirectories(map<string|string[]> headers = {}) returns HyperMediaObject[]|error {
        HyperMediaObject[]|error result = self.oasClient->getRootDirectories(headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getRootDirectories(headers);
        }
        return result;
    }

    # Create a new directory
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully created folder and returns its meta-data. **Hint:** The expected HTTP response status is `200 OK` rather than `201 Created`
    remote isolated function createDirectory(CreateDirectoryRequest payload, map<string|string[]> headers = {}) returns HyperMediaObject|error {
        HyperMediaObject|error result = self.oasClient->createDirectory(payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->createDirectory(payload, headers);
        }
        return result;
    }

    # Get meta-data of items in a given directory.
    #
    # + id - The ID of the directory to get the content of
    # + headers - Headers to be sent with the request
    # + return - Successfully provided meta-data of all items in the directory
    remote isolated function getDirectoryContent(DirectoryId id, map<string|string[]> headers = {}) returns HyperMediaObject[]|error {
        HyperMediaObject[]|error result = self.oasClient->getDirectoryContent(id, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getDirectoryContent(id, headers);
        }
        return result;
    }

    # Move a given directory.
    #
    # + id - The ID of the directory to move
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully moved the directory and returned its updated meta-data
    remote isolated function moveDirectory(DirectoryId id, MoveDirectoryRequest payload, map<string|string[]> headers = {}) returns HyperMediaObject|error {
        HyperMediaObject|error result = self.oasClient->moveDirectory(id, payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->moveDirectory(id, payload, headers);
        }
        return result;
    }

    # Delete a directory.
    #
    # + id - The ID of the directory to delete
    # + headers - Headers to be sent with the request
    # + return - successfully deleted the directory
    remote isolated function deleteDirectory(DirectoryId id, map<string|string[]> headers = {}) returns DeleteDirectoryResponse|error {
        DeleteDirectoryResponse|error result = self.oasClient->deleteDirectory(id, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->deleteDirectory(id, headers);
        }
        return result;
    }

    # Meta-data of a given directory.
    #
    # + id - The ID of the directory to get the meta-data of
    # + headers - Headers to be sent with the request
    # + return - Successfully provided meta-data of the directory
    remote isolated function getDirectoryInfo(DirectoryId id, map<string|string[]> headers = {}) returns DirectoryInfo|error {
        DirectoryInfo|error result = self.oasClient->getDirectoryInfo(id, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getDirectoryInfo(id, headers);
        }
        return result;
    }

    # Rename a given directory.
    #
    # + id - The ID of the directory to rename
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully renamed the directory and returned its updated meta-data
    remote isolated function renameDirectory(DirectoryId id, RenameDirectoryData payload, map<string|string[]> headers = {}) returns DirectoryInfo|error {
        DirectoryInfo|error result = self.oasClient->renameDirectory(id, payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->renameDirectory(id, payload, headers);
        }
        return result;
    }

    # publish/unpublish an item
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - successfully published or unpublished the item
    remote isolated function publishItem(PublishData payload, map<string|string[]> headers = {}) returns HyperMediaObject[]|error {
        HyperMediaObject[]|error result = self.oasClient->publishItem(payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->publishItem(payload, headers);
        }
        return result;
    }

    # Get the model diagram as JSON
    #
    # + modelId - The ID of the model to be retrieved
    # + headers - Headers to be sent with the request
    # + return - Workflow model data successfully retrieved
    remote isolated function getModelJson(string modelId, map<string|string[]> headers = {}) returns DiagramJson|error {
        DiagramJson|error result = self.oasClient->getModelJson(modelId, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getModelJson(modelId, headers);
        }
        return result;
    }

    # Get revision JSON.
    #
    # + revisionId - The ID of the revision to be retrieved
    # + headers - Headers to be sent with the request
    # + return - JSON representation of a model successfully retrieved
    remote isolated function getRevisionJson(string revisionId, map<string|string[]> headers = {}) returns DiagramJson|error {
        DiagramJson|error result = self.oasClient->getRevisionJson(revisionId, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getRevisionJson(revisionId, headers);
        }
        return result;
    }

    # Get the model diagram as a PNG image
    #
    # + modelId - The ID of the model
    # + headers - Headers to be sent with the request
    # + return - The binary content of the response
    remote isolated function getPng(string modelId, map<string|string[]> headers = {}) returns byte[]|error {
        byte[]|error result = self.oasClient->getPng(modelId, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getPng(modelId, headers);
        }
        return result;
    }

    # Get revision PNG.
    #
    # + revisionId - Revision ID
    # + headers - Headers to be sent with the request
    # + return - The binary content of the response
    remote isolated function getRevisionPng(string revisionId, map<string|string[]> headers = {}) returns byte[]|error {
        byte[]|error result = self.oasClient->getRevisionPng(revisionId, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getRevisionPng(revisionId, headers);
        }
        return result;
    }

    # Get BPMN 2.0 XML
    #
    # + modelId - The ID of the model
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The XML response
    remote isolated function getBpmnXml(string modelId, map<string|string[]> headers = {}, *GetBpmnXmlQueries queries) returns xml|error {
        xml|error result = self.oasClient->getBpmnXml(modelId, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getBpmnXml(modelId, headers, queries);
        }
        return result;
    }

    # Get revision BPMN 2.0 XML
    #
    # + revisionId - The ID of the model revision
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The XML response
    remote isolated function getRevisionBpmnXml(string revisionId, map<string|string[]> headers = {}, *GetRevisionBpmnXmlQueries queries) returns xml|error {
        xml|error result = self.oasClient->getRevisionBpmnXml(revisionId, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getRevisionBpmnXml(revisionId, headers, queries);
        }
        return result;
    }

    # Get the model diagram as an SVG image
    #
    # + modelId - The ID of the model
    # + headers - Headers to be sent with the request
    # + return - The raw HTTP response
    remote isolated function getSvg(string modelId, map<string|string[]> headers = {}) returns http:Response|error {
        http:Response|error result = self.oasClient->getSvg(modelId, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getSvg(modelId, headers);
        }
        return result;
    }

    # Get revision SVG.
    #
    # + revisionId - Revision ID
    # + headers - Headers to be sent with the request
    # + return - SVG representation
    remote isolated function getRevisionSvg(string revisionId, map<string|string[]> headers = {}) returns http:Response|error {
        http:Response|error result = self.oasClient->getRevisionSvg(revisionId, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getRevisionSvg(revisionId, headers);
        }
        return result;
    }

    # Import BPMN 2.0 XML
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - The returned bpmn import result
    remote isolated function importBpmn20Xml(BpmnImportRequest payload, map<string|string[]> headers = {}) returns BpmnImportResult|error {
        BpmnImportResult|error result = self.oasClient->importBpmn20Xml(payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->importBpmn20Xml(payload, headers);
        }
        return result;
    }

    # Retrieve download link to xml
    #
    # + id - The ID of the model
    # + headers - Headers to be sent with the request
    # + return - Successful response
    remote isolated function getDmnDownloadLink(string id, map<string|string[]> headers = {}) returns DmnDownloadLinkResponse|error {
        DmnDownloadLinkResponse|error result = self.oasClient->getDmnDownloadLink(id, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getDmnDownloadLink(id, headers);
        }
        return result;
    }

    # Download DMN XML
    #
    # + id - The download id provided from /dmn-xml-download/{id}
    # + headers - Headers to be sent with the request
    # + return - File downloaded successfully
    remote isolated function downloadDmnXml(string id, map<string|string[]> headers = {}) returns byte[]|error {
        byte[]|error result = self.oasClient->downloadDmnXml(id, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->downloadDmnXml(id, headers);
        }
        return result;
    }

    # Upload schema and data
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - The returned upload schema and data response dto
    remote isolated function uploadSchemaAndData(IngestionDataRequest payload, map<string|string[]> headers = {}) returns UploadSchemaAndDataResponseDto|error {
        UploadSchemaAndDataResponseDto|error result = self.oasClient->uploadSchemaAndData(payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->uploadSchemaAndData(payload, headers);
        }
        return result;
    }

    # Get status of ingestion request
    #
    # + executionId - Ingestion request execution Id
    # + headers - Headers to be sent with the request
    # + return - The returned execution status dto
    remote isolated function getStatus(string executionId, map<string|string[]> headers = {}) returns ExecutionStatusDto|error {
        ExecutionStatusDto|error result = self.oasClient->getStatus(executionId, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getStatus(executionId, headers);
        }
        return result;
    }

    # List initiatives
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned initiative list
    remote isolated function listInitiatives(map<string|string[]> headers = {}, *ListInitiativesQueries queries) returns Initiative[]|error {
        Initiative[]|error result = self.oasClient->listInitiatives(headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listInitiatives(headers, queries);
        }
        return result;
    }

    # Create initiative
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully created initiative
    remote isolated function createInitiative(IncomingInitiative payload, map<string|string[]> headers = {}) returns Initiative|error {
        Initiative|error result = self.oasClient->createInitiative(payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->createInitiative(payload, headers);
        }
        return result;
    }

    # Get initiative
    #
    # + initiativeId - The id of the initiative to retrieve
    # + headers - Headers to be sent with the request
    # + return - The returned initiative
    remote isolated function getInitiative(UUID initiativeId, map<string|string[]> headers = {}) returns Initiative|error {
        Initiative|error result = self.oasClient->getInitiative(initiativeId, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getInitiative(initiativeId, headers);
        }
        return result;
    }

    # Update initiative
    #
    # + initiativeId - The id of the initiative to update
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully updated initiative
    remote isolated function updateInitiative(UUID initiativeId, IncomingInitiative payload, map<string|string[]> headers = {}) returns Initiative|error {
        Initiative|error result = self.oasClient->updateInitiative(initiativeId, payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->updateInitiative(initiativeId, payload, headers);
        }
        return result;
    }

    # Delete initiative
    #
    # + initiativeId - The id of the initiative to delete
    # + headers - Headers to be sent with the request
    # + return - Successfully deleted initiative
    remote isolated function deleteInitiative(UUID initiativeId, map<string|string[]> headers = {}) returns error? {
        error? result = self.oasClient->deleteInitiative(initiativeId, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->deleteInitiative(initiativeId, headers);
        }
        return result;
    }

    # List assets from initiative
    #
    # + initiativeId - The id of the initiative containing the assets
    # + headers - Headers to be sent with the request
    # + return - The returned asset list
    remote isolated function listAssetsInitiative(UUID initiativeId, map<string|string[]> headers = {}) returns Asset[]|error {
        Asset[]|error result = self.oasClient->listAssetsInitiative(initiativeId, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listAssetsInitiative(initiativeId, headers);
        }
        return result;
    }

    # Create asset in initiative
    #
    # + initiativeId - The id of the initiative to add the asset to
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully created asset
    remote isolated function createAssetInitiative(UUID initiativeId, IncomingAsset payload, map<string|string[]> headers = {}) returns Asset|error {
        Asset|error result = self.oasClient->createAssetInitiative(initiativeId, payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->createAssetInitiative(initiativeId, payload, headers);
        }
        return result;
    }

    # Get asset from initiative
    #
    # + assetId - The id of the asset to retrieve
    # + initiativeId - The id of the initiative containing the asset
    # + headers - Headers to be sent with the request
    # + return - The returned asset
    remote isolated function getAssetInitiative(UUID assetId, UUID initiativeId, map<string|string[]> headers = {}) returns Asset|error {
        Asset|error result = self.oasClient->getAssetInitiative(assetId, initiativeId, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getAssetInitiative(assetId, initiativeId, headers);
        }
        return result;
    }

    # Update asset in initiative
    #
    # + assetId - The id of the asset to update
    # + initiativeId - The id of the initiative containing the asset
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully updated asset
    remote isolated function updateAssetInitiative(UUID assetId, UUID initiativeId, IncomingAsset payload, map<string|string[]> headers = {}) returns Asset|error {
        Asset|error result = self.oasClient->updateAssetInitiative(assetId, initiativeId, payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->updateAssetInitiative(assetId, initiativeId, payload, headers);
        }
        return result;
    }

    # Delete asset from initiative
    #
    # + assetId - The id of the asset to delete
    # + initiativeId - The id of the initiative containing the asset
    # + headers - Headers to be sent with the request
    # + return - Successfully deleted asset
    remote isolated function deleteAssetInitiative(UUID assetId, UUID initiativeId, map<string|string[]> headers = {}) returns Asset|error {
        Asset|error result = self.oasClient->deleteAssetInitiative(assetId, initiativeId, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->deleteAssetInitiative(assetId, initiativeId, headers);
        }
        return result;
    }

    # Get all insights in an initiative
    #
    # + initiativeId - ID of the initiative whose insights should be listed
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned insight list
    remote isolated function listInsightsInInitiative(string initiativeId, map<string|string[]> headers = {}, *ListInsightsInInitiativeQueries queries) returns Insight[]|error {
        Insight[]|error result = self.oasClient->listInsightsInInitiative(initiativeId, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listInsightsInInitiative(initiativeId, headers, queries);
        }
        return result;
    }

    # Get insight in initiative
    #
    # + initiativeId - ID of the initiative to which the insight belongs
    # + insightId - ID of the insight to be retrieved
    # + headers - Headers to be sent with the request
    # + return - The returned insight
    remote isolated function getInsightInInitiative(UUID initiativeId, UUID insightId, map<string|string[]> headers = {}) returns Insight|error {
        Insight|error result = self.oasClient->getInsightInInitiative(initiativeId, insightId, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getInsightInInitiative(initiativeId, insightId, headers);
        }
        return result;
    }

    # Get all insights
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned insight list
    remote isolated function listInsights(map<string|string[]> headers = {}, *ListInsightsQueries queries) returns Insight[]|error {
        Insight[]|error result = self.oasClient->listInsights(headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listInsights(headers, queries);
        }
        return result;
    }

    # Create an insight
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully created insight
    remote isolated function createInsight(IncomingInsight payload, map<string|string[]> headers = {}) returns Insight|error {
        Insight|error result = self.oasClient->createInsight(payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->createInsight(payload, headers);
        }
        return result;
    }

    # Get insight
    #
    # + insightId - The id of the insight to retrieve
    # + headers - Headers to be sent with the request
    # + return - The returned insight
    remote isolated function getInsight(UUID insightId, map<string|string[]> headers = {}) returns Insight|error {
        Insight|error result = self.oasClient->getInsight(insightId, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getInsight(insightId, headers);
        }
        return result;
    }

    # Update insight
    #
    # + insightId - The id of the insight to update
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully updated insight
    remote isolated function updateInsight(UUID insightId, IncomingInsight payload, map<string|string[]> headers = {}) returns Insight|error {
        Insight|error result = self.oasClient->updateInsight(insightId, payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->updateInsight(insightId, payload, headers);
        }
        return result;
    }

    # Delete insight
    #
    # + insightId - The id of the insight to delete
    # + headers - Headers to be sent with the request
    # + return - Successfully deleted insight
    remote isolated function deleteInsight(UUID insightId, map<string|string[]> headers = {}) returns json|error {
        json|error result = self.oasClient->deleteInsight(insightId, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->deleteInsight(insightId, headers);
        }
        return result;
    }

    # Retrieve Model
    #
    # + id - The ID of the model to be retrieved
    # + headers - Headers to be sent with the request
    # + return - The returned model resource response list
    remote isolated function retrieveModel(string id, map<string|string[]> headers = {}) returns ModelResourceResponse[]|error {
        ModelResourceResponse[]|error result = self.oasClient->retrieveModel(id, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->retrieveModel(id, headers);
        }
        return result;
    }

    # Update Model
    #
    # + id - The ID of the model to be updated
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned model resource response list
    remote isolated function updateModel(string id, ModelRequest payload, map<string|string[]> headers = {}, *UpdateModelQueries queries) returns ModelResourceResponse[]|error {
        ModelResourceResponse[]|error result = self.oasClient->updateModel(id, payload, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->updateModel(id, payload, headers, queries);
        }
        return result;
    }

    # Delete Model
    #
    # + id - The ID of the model to be deleted
    # + headers - Headers to be sent with the request
    # + return - The returned success response
    remote isolated function deleteModel(string id, map<string|string[]> headers = {}) returns SuccessResponse|error {
        SuccessResponse|error result = self.oasClient->deleteModel(id, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->deleteModel(id, headers);
        }
        return result;
    }

    # Create a new Model
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned model response
    remote isolated function createModel(ModelRequest payload, map<string|string[]> headers = {}, *CreateModelQueries queries) returns ModelResponse|error {
        ModelResponse|error result = self.oasClient->createModel(payload, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->createModel(payload, headers, queries);
        }
        return result;
    }

    # Retrieving all revision IDs of a model.
    #
    # + modelId - The model's ID
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The returned model revisions response list
    remote isolated function listModelRevisions(string modelId, map<string|string[]> headers = {}, *ListModelRevisionsQueries queries) returns ModelRevisionsResponse[]|error {
        ModelRevisionsResponse[]|error result = self.oasClient->listModelRevisions(modelId, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listModelRevisions(modelId, headers, queries);
        }
        return result;
    }

    # Update model info
    #
    # + modelId - The ID of the model
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successful operation
    remote isolated function updateModelInfo(string modelId, ModelInfoRequest payload, map<string|string[]> headers = {}) returns ModelInfoResponse|error {
        ModelInfoResponse|error result = self.oasClient->updateModelInfo(modelId, payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->updateModelInfo(modelId, payload, headers);
        }
        return result;
    }

    # Performs a syntax check on a BPMN 2.0 process model.
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Syntax check successful
    remote isolated function checkSyntax(SyntaxCheckRequest payload, map<string|string[]> headers = {}) returns SyntaxCheckResponse|error {
        SyntaxCheckResponse|error result = self.oasClient->checkSyntax(payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->checkSyntax(payload, headers);
        }
        return result;
    }

    # Create a new model draft.
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - Model created successfully
    remote isolated function createDiagramDraft(map<string|string[]> headers = {}, *CreateDiagramDraftQueries queries) returns DiagramDraftResponse|error {
        DiagramDraftResponse|error result = self.oasClient->createDiagramDraft(headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->createDiagramDraft(headers, queries);
        }
        return result;
    }

    # Get meta information
    #
    # + headers - Headers to be sent with the request
    # + return - Successfully retrieved meta information
    remote isolated function getMetaInfo(map<string|string[]> headers = {}) returns MetaResponseItem[]|error? {
        MetaResponseItem[]|error? result = self.oasClient->getMetaInfo(headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getMetaInfo(headers);
        }
        return result;
    }

    # Create meta information
    #
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully created meta information
    remote isolated function createMetaInfo(MetaInfoRequest payload, map<string|string[]> headers = {}) returns MetaResponseItem|error {
        MetaResponseItem|error result = self.oasClient->createMetaInfo(payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->createMetaInfo(payload, headers);
        }
        return result;
    }

    # Retrieve the current approval expiration date.
    #
    # + modelID - The ID of the model
    # + headers - Headers to be sent with the request
    # + return - Successfully retrieved the approval expiration date
    remote isolated function getExpirationDate(string modelID, map<string|string[]> headers = {}) returns ExpirationDate|error {
        ExpirationDate|error result = self.oasClient->getExpirationDate(modelID, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getExpirationDate(modelID, headers);
        }
        return result;
    }

    # Update the approval expiration date.
    #
    # + modelID - The ID of the model
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully updated the approval expiration date
    remote isolated function updateExpirationDate(string modelID, ExpirationDate payload, map<string|string[]> headers = {}) returns ExpirationDate|error {
        ExpirationDate|error result = self.oasClient->updateExpirationDate(modelID, payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->updateExpirationDate(modelID, payload, headers);
        }
        return result;
    }

    # Create a new approval expiration date.
    #
    # + modelID - The ID of the model
    # + payload - The request payload
    # + headers - Headers to be sent with the request
    # + return - Successfully created the approval expiration date
    remote isolated function createExpirationDate(string modelID, ExpirationDate payload, map<string|string[]> headers = {}) returns ExpirationDate|error {
        ExpirationDate|error result = self.oasClient->createExpirationDate(modelID, payload, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->createExpirationDate(modelID, payload, headers);
        }
        return result;
    }

    # Delete the current approval expiration date.
    #
    # + modelID - The ID of the model
    # + headers - Headers to be sent with the request
    # + return - Successfully deleted the approval expiration date
    remote isolated function deleteExpirationDate(string modelID, map<string|string[]> headers = {}) returns error? {
        error? result = self.oasClient->deleteExpirationDate(modelID, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->deleteExpirationDate(modelID, headers);
        }
        return result;
    }

    # Get all objectives
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - Success returns objectives wrapped in value array
    remote isolated function listObjectives(map<string|string[]> headers = {}, *ListObjectivesQueries queries) returns ObjectivesResponse|error {
        ObjectivesResponse|error result = self.oasClient->listObjectives(headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->listObjectives(headers, queries);
        }
        return result;
    }

    # Get objective by SID
    #
    # + objectiveSid - The Suite Objective ID (SID) (e.g. SuiteObjective_<32 hex chars>)
    # + headers - Headers to be sent with the request
    # + return - The returned objective
    remote isolated function getObjective(string objectiveSid, map<string|string[]> headers = {}) returns Objective|error {
        Objective|error result = self.oasClient->getObjective(objectiveSid, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getObjective(objectiveSid, headers);
        }
        return result;
    }

    # Get linked initiatives
    #
    # + objectiveSid - The Suite Objective ID (SID) (e.g. SuiteObjective_<32 hex chars>)
    # + headers - Headers to be sent with the request
    # + return - The returned initiative summary for objective list
    remote isolated function getInitiativesByObjective(string objectiveSid, map<string|string[]> headers = {}) returns InitiativeSummaryForObjective[]|error {
        InitiativeSummaryForObjective[]|error result = self.oasClient->getInitiativesByObjective(objectiveSid, headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getInitiativesByObjective(objectiveSid, headers);
        }
        return result;
    }

    # Search the workspace
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - JSON array containing folder and model object representations. In the response object with `rel="search"`, the `totalNrOfResults` property gives the total number of results. When there are more than 250 results, the API limits the response array to the first 250 results. You can use the `offset=250` request parameter to fetch the second ‘page’ of results
    remote isolated function search(map<string|string[]> headers = {}, *SearchQueries queries) returns http:Response|error {
        http:Response|error result = self.oasClient->search(headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->search(headers, queries);
        }
        return result;
    }

    # Returns all entity sets (Odata views) the user has access to. A JSON list is returned representing the entity set.
    #
    # + headers - Headers to be sent with the request
    # + return - List all entity sets (OData views) the user has access to. The user has access if the underlying resources which the SIGNAL query in the view accesses (tables/views) are accessible. If this is not the case the entity (view) is not returned. A JSON list is given with all entities
    remote isolated function getServiceDocument(map<string|string[]> headers = {}) returns ServiceDocument|error {
        ServiceDocument|error result = self.oasClient->getServiceDocument(headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getServiceDocument(headers);
        }
        return result;
    }

    # Returns metadata for all entity sets (OData views) the user has access to. An XML schema is returned representing the metadata.
    #
    # + headers - Headers to be sent with the request
    # + return - Metadata information for all entity sets (OData views) the user has access to. The user has access if the underlying resources which the SIGNAL query in the view accesses (tables/views) are accessible. If this is not the case the entity (view) is not returned. A XML schema is given as metadata
    remote isolated function getMetadata(map<string|string[]> headers = {}) returns xml|error {
        xml|error result = self.oasClient->getMetadata(headers);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->getMetadata(headers);
        }
        return result;
    }

    # This endpoint implements an OData service endpoint according to version 4.0 of
    # the OData Protocol specification.
    #
    # + entitySetName - The name for the entity set (in this case, the oData view). Can be returned by calling the /$metadata endpoint
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - Data for the given entity, returned as a JSON schema
    remote isolated function queryEntitySet(string entitySetName, map<string|string[]> headers = {}, *QueryEntitySetQueries queries) returns OdataOutput|error {
        OdataOutput|error result = self.oasClient->queryEntitySet(entitySetName, headers, queries);
        if isAuthError(result) {
            check self.oasClient.reauthenticate();
            result = self.oasClient->queryEntitySet(entitySetName, headers, queries);
        }
        return result;
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
