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
import ballerinax/sap.signavio.oas;

# The `ballerinax/sap.signavio` client. Wraps the generated `oas` client and adds transparent
# re-authentication: when a request comes back unauthenticated (the gateway JWT is valid ~24h and
# the Process Manager workspace session has its own server-side timeout), the client re-logs in
# once and replays the request, so a long-lived client instance keeps working without manual
# re-initialization.
public isolated client class Client {
    final oas:Client oasClient;

    # Gets invoked to initialize the `connector`. Exchanges `config.auth` for a gateway JWT and a
    # Process Manager workspace session; both are refreshed automatically when they expire.
    #
    # + config - The configurations to be used when initializing the `connector`
    # + gatewayUrl - URL of the SAP Signavio API gateway. Defaults to the URL derived from `config.region`
    # + workspaceUrl - URL of the SAP Signavio Process Manager workspace. Defaults to the URL derived from `config.region`
    # + return - An error if connector initialization, or either login, failed
    public isolated function init(ConnectionConfig config, string? gatewayUrl = (), string? workspaceUrl = ()) returns error? {
        self.oasClient = check new oas:Client(config, gatewayUrl, workspaceUrl);
    }

    remote isolated function listCaseVariables(ListCaseVariablesHeaders headers = {}, *ListCaseVariablesQueries queries) returns CaseVariablesResourcesResponseSchema|CaseVariablesResourceReferencesResponseSchema|error {
        CaseVariablesResourcesResponseSchema|CaseVariablesResourceReferencesResponseSchema|error r = self.oasClient->listCaseVariables(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCaseVariables(headers, queries);
        }
        return r;
    }
    remote isolated function getCaseVariable(string id, GetCaseVariableHeaders headers = {}, *GetCaseVariableQueries queries) returns CaseVariablesResourceResponseSchema|CaseVariablesResourceReferencesResponseSchema|error {
        CaseVariablesResourceResponseSchema|CaseVariablesResourceReferencesResponseSchema|error r = self.oasClient->getCaseVariable(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getCaseVariable(id, headers, queries);
        }
        return r;
    }
    remote isolated function listCaseVariableCases(string id, ListCaseVariableCasesHeaders headers = {}, *ListCaseVariableCasesQueries queries) returns CasesResourceResponseSchema|CasesResourceReferencesResponseSchema|error {
        CasesResourceResponseSchema|CasesResourceReferencesResponseSchema|error r = self.oasClient->listCaseVariableCases(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCaseVariableCases(id, headers, queries);
        }
        return r;
    }
    remote isolated function listCaseVariableCaseRefs(string id, ListCaseVariableCaseRefsHeaders headers = {}, *ListCaseVariableCaseRefsQueries queries) returns CasesResourceReferenceResponseSchema|CasesResourceReferencesResponseSchema|error {
        CasesResourceReferenceResponseSchema|CasesResourceReferencesResponseSchema|error r = self.oasClient->listCaseVariableCaseRefs(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCaseVariableCaseRefs(id, headers, queries);
        }
        return r;
    }
    remote isolated function listCases(ListCasesHeaders headers = {}, *ListCasesQueries queries) returns CasesResourcesResponseSchema|CasesResourceReferencesResponseSchema|error {
        CasesResourcesResponseSchema|CasesResourceReferencesResponseSchema|error r = self.oasClient->listCases(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCases(headers, queries);
        }
        return r;
    }
    remote isolated function getCase(string id, GetCaseHeaders headers = {}, *GetCaseQueries queries) returns CasesResourceResponseSchema|error {
        CasesResourceResponseSchema|error r = self.oasClient->getCase(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getCase(id, headers, queries);
        }
        return r;
    }
    remote isolated function listCaseTasks(string id, ListCaseTasksHeaders headers = {}, *ListCaseTasksQueries queries) returns TasksResourcesResponseSchema|TasksResourceReferencesResponseSchema|error {
        TasksResourcesResponseSchema|TasksResourceReferencesResponseSchema|error r = self.oasClient->listCaseTasks(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCaseTasks(id, headers, queries);
        }
        return r;
    }
    remote isolated function getCaseCreator(string id, GetCaseCreatorHeaders headers = {}, *GetCaseCreatorQueries queries) returns UsersResourceResponseSchema|UsersResourceReferencesResponseSchema|error {
        UsersResourceResponseSchema|UsersResourceReferencesResponseSchema|error r = self.oasClient->getCaseCreator(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getCaseCreator(id, headers, queries);
        }
        return r;
    }
    remote isolated function listFiles(ListFilesHeaders headers = {}, *ListFilesQueries queries) returns FilesResourcesResponseSchema|FilesResourceReferencesResponseSchema|error {
        FilesResourcesResponseSchema|FilesResourceReferencesResponseSchema|error r = self.oasClient->listFiles(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listFiles(headers, queries);
        }
        return r;
    }
    remote isolated function getFile(string id, GetFileHeaders headers = {}, *GetFileQueries queries) returns FilesResourceResponseSchema|FilesResourceReferencesResponseSchema|error {
        FilesResourceResponseSchema|FilesResourceReferencesResponseSchema|error r = self.oasClient->getFile(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getFile(id, headers, queries);
        }
        return r;
    }
    remote isolated function listGroups(ListGroupsHeaders headers = {}, *ListGroupsQueries queries) returns GroupsResourcesResponseSchema|GroupsResourceReferencesResponseSchema|error {
        GroupsResourcesResponseSchema|GroupsResourceReferencesResponseSchema|error r = self.oasClient->listGroups(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listGroups(headers, queries);
        }
        return r;
    }
    remote isolated function getGroup(string id, GetGroupHeaders headers = {}, *GetGroupQueries queries) returns GroupsResourceResponseSchema|GroupsResourceReferencesResponseSchema|error {
        GroupsResourceResponseSchema|GroupsResourceReferencesResponseSchema|error r = self.oasClient->getGroup(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getGroup(id, headers, queries);
        }
        return r;
    }
    remote isolated function listGroupUserRefs(string id, ListGroupUserRefsHeaders headers = {}) returns UsersResourceReferencesResponseSchema|error {
        UsersResourceReferencesResponseSchema|error r = self.oasClient->listGroupUserRefs(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listGroupUserRefs(id, headers);
        }
        return r;
    }
    remote isolated function listGroupUsers(string id, ListGroupUsersHeaders headers = {}, *ListGroupUsersQueries queries) returns UsersResourcesResponseSchema|UsersResourceReferencesResponseSchema|error {
        UsersResourcesResponseSchema|UsersResourceReferencesResponseSchema|error r = self.oasClient->listGroupUsers(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listGroupUsers(id, headers, queries);
        }
        return r;
    }
    remote isolated function listTasks(ListTasksHeaders headers = {}, *ListTasksQueries queries) returns TasksResourcesResponseSchema|TasksResourceReferencesResponseSchema|error {
        TasksResourcesResponseSchema|TasksResourceReferencesResponseSchema|error r = self.oasClient->listTasks(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listTasks(headers, queries);
        }
        return r;
    }
    remote isolated function getTask(string id, GetTaskHeaders headers = {}, *GetTaskQueries queries) returns TasksResourceResponseSchema|TasksResourceReferencesResponseSchema|error {
        TasksResourceResponseSchema|TasksResourceReferencesResponseSchema|error r = self.oasClient->getTask(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getTask(id, headers, queries);
        }
        return r;
    }
    remote isolated function getTaskCase(string id, GetTaskCaseHeaders headers = {}, *GetTaskCaseQueries queries) returns CasesResourceResponseSchema|CasesResourceReferencesResponseSchema|error {
        CasesResourceResponseSchema|CasesResourceReferencesResponseSchema|error r = self.oasClient->getTaskCase(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getTaskCase(id, headers, queries);
        }
        return r;
    }
    remote isolated function getTaskCaseRef(string id, GetTaskCaseRefHeaders headers = {}) returns CasesResourceReferenceResponseSchema|CasesResourceReferencesResponseSchema|error {
        CasesResourceReferenceResponseSchema|CasesResourceReferencesResponseSchema|error r = self.oasClient->getTaskCaseRef(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getTaskCaseRef(id, headers);
        }
        return r;
    }
    remote isolated function listUsers(ListUsersHeaders headers = {}, *ListUsersQueries queries) returns UsersResourcesResponseSchema|UsersResourceReferencesResponseSchema|error {
        UsersResourcesResponseSchema|UsersResourceReferencesResponseSchema|error r = self.oasClient->listUsers(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listUsers(headers, queries);
        }
        return r;
    }
    remote isolated function getUser(string id, GetUserHeaders headers = {}, *GetUserQueries queries) returns UsersResourceResponseSchema|UsersResourceReferencesResponseSchema|error {
        UsersResourceResponseSchema|UsersResourceReferencesResponseSchema|error r = self.oasClient->getUser(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getUser(id, headers, queries);
        }
        return r;
    }
    remote isolated function addAutomaticMeasurementToMetric(string journeyId, string metricId, AutomaticMeasurement payload, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->addAutomaticMeasurementToMetric(journeyId, metricId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addAutomaticMeasurementToMetric(journeyId, metricId, payload, headers);
        }
        return r;
    }
    remote isolated function authenticate(TokenRequest payload, AuthenticateHeaders headers = {}) returns string|error {
        string|error r = self.oasClient->authenticate(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->authenticate(payload, headers);
        }
        return r;
    }
    remote isolated function listDictionaryEntries(ListDictionaryEntriesHeaders headers = {}, *ListDictionaryEntriesQueries queries) returns DictionaryResponse[]|error {
        DictionaryResponse[]|error r = self.oasClient->listDictionaryEntries(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listDictionaryEntries(headers, queries);
        }
        return r;
    }
    remote isolated function createDictionaryEntry(DictionaryEntryRequest payload, CreateDictionaryEntryHeaders headers = {}) returns DictionaryResponse|error {
        DictionaryResponse|error r = self.oasClient->createDictionaryEntry(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createDictionaryEntry(payload, headers);
        }
        return r;
    }
    remote isolated function getDictionaryEntry(string id, GetDictionaryEntryHeaders headers = {}) returns DictionaryResponse[]|error {
        DictionaryResponse[]|error r = self.oasClient->getDictionaryEntry(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDictionaryEntry(id, headers);
        }
        return r;
    }
    remote isolated function deleteDictionaryEntry(string id, DeleteDictionaryEntryHeaders headers = {}) returns SuccessResponse|error {
        SuccessResponse|error r = self.oasClient->deleteDictionaryEntry(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteDictionaryEntry(id, headers);
        }
        return r;
    }
    remote isolated function getDictionaryEntryInfo(string id, GetDictionaryEntryInfoHeaders headers = {}) returns Representation|error {
        Representation|error r = self.oasClient->getDictionaryEntryInfo(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDictionaryEntryInfo(id, headers);
        }
        return r;
    }
    remote isolated function updateDictionaryEntry(string id, DictionaryEntryUpdateRequest payload, UpdateDictionaryEntryHeaders headers = {}) returns DictionaryResponse|error {
        DictionaryResponse|error r = self.oasClient->updateDictionaryEntry(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateDictionaryEntry(id, payload, headers);
        }
        return r;
    }
    remote isolated function listDictionaryCategories(ListDictionaryCategoriesHeaders headers = {}, *ListDictionaryCategoriesQueries queries) returns DictionaryResponse[]|error {
        DictionaryResponse[]|error r = self.oasClient->listDictionaryCategories(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listDictionaryCategories(headers, queries);
        }
        return r;
    }
    remote isolated function createDictionaryCategory(DictionaryCategoryRequest payload, CreateDictionaryCategoryHeaders headers = {}) returns DictionaryResponse|error {
        DictionaryResponse|error r = self.oasClient->createDictionaryCategory(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createDictionaryCategory(payload, headers);
        }
        return r;
    }
    remote isolated function getDictionaryCategory(string id, GetDictionaryCategoryHeaders headers = {}) returns DictionaryResponse[]|error {
        DictionaryResponse[]|error r = self.oasClient->getDictionaryCategory(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDictionaryCategory(id, headers);
        }
        return r;
    }
    remote isolated function updateDictionaryCategory(string id, DictionaryCategoryRequest payload, UpdateDictionaryCategoryHeaders headers = {}) returns DictionaryResponse|error {
        DictionaryResponse|error r = self.oasClient->updateDictionaryCategory(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateDictionaryCategory(id, payload, headers);
        }
        return r;
    }
    remote isolated function deleteDictionaryCategory(string id, DeleteDictionaryCategoryHeaders headers = {}, *DeleteDictionaryCategoryQueries queries) returns SuccessResponse|error {
        SuccessResponse|error r = self.oasClient->deleteDictionaryCategory(id, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteDictionaryCategory(id, headers, queries);
        }
        return r;
    }
    remote isolated function getRootDirectories(map<string|string[]> headers = {}) returns HyperMediaObject[]|error {
        HyperMediaObject[]|error r = self.oasClient->getRootDirectories(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getRootDirectories(headers);
        }
        return r;
    }
    remote isolated function createDirectory(CreateDirectoryRequest payload, map<string|string[]> headers = {}) returns HyperMediaObject|error {
        HyperMediaObject|error r = self.oasClient->createDirectory(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createDirectory(payload, headers);
        }
        return r;
    }
    remote isolated function getDirectoryContent(DirectoryId id, map<string|string[]> headers = {}) returns HyperMediaObject[]|error {
        HyperMediaObject[]|error r = self.oasClient->getDirectoryContent(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDirectoryContent(id, headers);
        }
        return r;
    }
    remote isolated function moveDirectory(DirectoryId id, MoveDirectoryRequest payload, map<string|string[]> headers = {}) returns HyperMediaObject|error {
        HyperMediaObject|error r = self.oasClient->moveDirectory(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->moveDirectory(id, payload, headers);
        }
        return r;
    }
    remote isolated function deleteDirectory(DirectoryId id, map<string|string[]> headers = {}) returns DeleteDirectoryResponse|error {
        DeleteDirectoryResponse|error r = self.oasClient->deleteDirectory(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteDirectory(id, headers);
        }
        return r;
    }
    remote isolated function getDirectoryInfo(DirectoryId id, map<string|string[]> headers = {}) returns DirectoryInfo|error {
        DirectoryInfo|error r = self.oasClient->getDirectoryInfo(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDirectoryInfo(id, headers);
        }
        return r;
    }
    remote isolated function renameDirectory(DirectoryId id, RenameDirectoryData payload, map<string|string[]> headers = {}) returns DirectoryInfo|error {
        DirectoryInfo|error r = self.oasClient->renameDirectory(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->renameDirectory(id, payload, headers);
        }
        return r;
    }
    remote isolated function publishItem(PublishData payload, map<string|string[]> headers = {}) returns HyperMediaObject[]|error {
        HyperMediaObject[]|error r = self.oasClient->publishItem(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->publishItem(payload, headers);
        }
        return r;
    }
    remote isolated function getModelJson(string modelId, map<string|string[]> headers = {}) returns DiagramJson|error {
        DiagramJson|error r = self.oasClient->getModelJson(modelId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getModelJson(modelId, headers);
        }
        return r;
    }
    remote isolated function getRevisionJson(string revisionId, map<string|string[]> headers = {}) returns DiagramJson|error {
        DiagramJson|error r = self.oasClient->getRevisionJson(revisionId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getRevisionJson(revisionId, headers);
        }
        return r;
    }
    remote isolated function getPng(string modelId, map<string|string[]> headers = {}) returns byte[]|error {
        byte[]|error r = self.oasClient->getPng(modelId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getPng(modelId, headers);
        }
        return r;
    }
    remote isolated function getRevisionPng(string revisionId, map<string|string[]> headers = {}) returns byte[]|error {
        byte[]|error r = self.oasClient->getRevisionPng(revisionId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getRevisionPng(revisionId, headers);
        }
        return r;
    }
    remote isolated function getBpmnXml(string modelId, map<string|string[]> headers = {}, *GetBpmnXmlQueries queries) returns xml|error {
        xml|error r = self.oasClient->getBpmnXml(modelId, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getBpmnXml(modelId, headers, queries);
        }
        return r;
    }
    remote isolated function getRevisionBpmnXml(string revisionId, map<string|string[]> headers = {}, *GetRevisionBpmnXmlQueries queries) returns xml|error {
        xml|error r = self.oasClient->getRevisionBpmnXml(revisionId, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getRevisionBpmnXml(revisionId, headers, queries);
        }
        return r;
    }
    remote isolated function getSvg(string modelId, map<string|string[]> headers = {}) returns http:Response|error {
        http:Response|error r = self.oasClient->getSvg(modelId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getSvg(modelId, headers);
        }
        return r;
    }
    remote isolated function getRevisionSvg(string revisionId, map<string|string[]> headers = {}) returns http:Response|error {
        http:Response|error r = self.oasClient->getRevisionSvg(revisionId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getRevisionSvg(revisionId, headers);
        }
        return r;
    }
    remote isolated function importBpmn20Xml(BpmnImportRequest payload, map<string|string[]> headers = {}) returns BpmnImportResult|error {
        BpmnImportResult|error r = self.oasClient->importBpmn20Xml(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->importBpmn20Xml(payload, headers);
        }
        return r;
    }
    remote isolated function getDmnDownloadLink(string id, map<string|string[]> headers = {}) returns DmnDownloadLinkResponse|error {
        DmnDownloadLinkResponse|error r = self.oasClient->getDmnDownloadLink(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDmnDownloadLink(id, headers);
        }
        return r;
    }
    remote isolated function downloadDmnXml(string id, map<string|string[]> headers = {}) returns byte[]|error {
        byte[]|error r = self.oasClient->downloadDmnXml(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->downloadDmnXml(id, headers);
        }
        return r;
    }
    remote isolated function uploadSchemaAndData(IngestionDataRequest payload, map<string|string[]> headers = {}) returns UploadSchemaAndDataResponseDto|error {
        UploadSchemaAndDataResponseDto|error r = self.oasClient->uploadSchemaAndData(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->uploadSchemaAndData(payload, headers);
        }
        return r;
    }
    remote isolated function getStatus(string executionId, map<string|string[]> headers = {}) returns ExecutionStatusDto|error {
        ExecutionStatusDto|error r = self.oasClient->getStatus(executionId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getStatus(executionId, headers);
        }
        return r;
    }
    remote isolated function listInitiatives(map<string|string[]> headers = {}, *ListInitiativesQueries queries) returns Initiative[]|error {
        Initiative[]|error r = self.oasClient->listInitiatives(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listInitiatives(headers, queries);
        }
        return r;
    }
    remote isolated function createInitiative(IncomingInitiative payload, map<string|string[]> headers = {}) returns Initiative|error {
        Initiative|error r = self.oasClient->createInitiative(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createInitiative(payload, headers);
        }
        return r;
    }
    remote isolated function getInitiative(UUID initiativeId, map<string|string[]> headers = {}) returns Initiative|error {
        Initiative|error r = self.oasClient->getInitiative(initiativeId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getInitiative(initiativeId, headers);
        }
        return r;
    }
    remote isolated function updateInitiative(UUID initiativeId, IncomingInitiative payload, map<string|string[]> headers = {}) returns Initiative|error {
        Initiative|error r = self.oasClient->updateInitiative(initiativeId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateInitiative(initiativeId, payload, headers);
        }
        return r;
    }
    remote isolated function deleteInitiative(UUID initiativeId, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->deleteInitiative(initiativeId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteInitiative(initiativeId, headers);
        }
        return r;
    }
    remote isolated function listAssetsInitiative(UUID initiativeId, map<string|string[]> headers = {}) returns Asset[]|error {
        Asset[]|error r = self.oasClient->listAssetsInitiative(initiativeId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listAssetsInitiative(initiativeId, headers);
        }
        return r;
    }
    remote isolated function createAssetInitiative(UUID initiativeId, IncomingAsset payload, map<string|string[]> headers = {}) returns Asset|error {
        Asset|error r = self.oasClient->createAssetInitiative(initiativeId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createAssetInitiative(initiativeId, payload, headers);
        }
        return r;
    }
    remote isolated function getAssetInitiative(UUID assetId, UUID initiativeId, map<string|string[]> headers = {}) returns Asset|error {
        Asset|error r = self.oasClient->getAssetInitiative(assetId, initiativeId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getAssetInitiative(assetId, initiativeId, headers);
        }
        return r;
    }
    remote isolated function updateAssetInitiative(UUID assetId, UUID initiativeId, IncomingAsset payload, map<string|string[]> headers = {}) returns Asset|error {
        Asset|error r = self.oasClient->updateAssetInitiative(assetId, initiativeId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateAssetInitiative(assetId, initiativeId, payload, headers);
        }
        return r;
    }
    remote isolated function deleteAssetInitiative(UUID assetId, UUID initiativeId, map<string|string[]> headers = {}) returns Asset|error {
        Asset|error r = self.oasClient->deleteAssetInitiative(assetId, initiativeId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteAssetInitiative(assetId, initiativeId, headers);
        }
        return r;
    }
    remote isolated function listInsightsInInitiative(string initiativeId, map<string|string[]> headers = {}, *ListInsightsInInitiativeQueries queries) returns Insight[]|error {
        Insight[]|error r = self.oasClient->listInsightsInInitiative(initiativeId, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listInsightsInInitiative(initiativeId, headers, queries);
        }
        return r;
    }
    remote isolated function getInsightInInitiative(UUID initiativeId, UUID insightId, map<string|string[]> headers = {}) returns Insight|error {
        Insight|error r = self.oasClient->getInsightInInitiative(initiativeId, insightId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getInsightInInitiative(initiativeId, insightId, headers);
        }
        return r;
    }
    remote isolated function listInsights(map<string|string[]> headers = {}, *ListInsightsQueries queries) returns Insight[]|error {
        Insight[]|error r = self.oasClient->listInsights(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listInsights(headers, queries);
        }
        return r;
    }
    remote isolated function createInsight(IncomingInsight payload, map<string|string[]> headers = {}) returns Insight|error {
        Insight|error r = self.oasClient->createInsight(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createInsight(payload, headers);
        }
        return r;
    }
    remote isolated function getInsight(UUID insightId, map<string|string[]> headers = {}) returns Insight|error {
        Insight|error r = self.oasClient->getInsight(insightId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getInsight(insightId, headers);
        }
        return r;
    }
    remote isolated function updateInsight(UUID insightId, IncomingInsight payload, map<string|string[]> headers = {}) returns Insight|error {
        Insight|error r = self.oasClient->updateInsight(insightId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateInsight(insightId, payload, headers);
        }
        return r;
    }
    remote isolated function deleteInsight(UUID insightId, map<string|string[]> headers = {}) returns json|error {
        json|error r = self.oasClient->deleteInsight(insightId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteInsight(insightId, headers);
        }
        return r;
    }
    remote isolated function retrieveModel(string id, map<string|string[]> headers = {}) returns ModelResourceResponse[]|error {
        ModelResourceResponse[]|error r = self.oasClient->retrieveModel(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->retrieveModel(id, headers);
        }
        return r;
    }
    remote isolated function updateModel(string id, ModelRequest payload, map<string|string[]> headers = {}, *UpdateModelQueries queries) returns ModelResourceResponse[]|error {
        ModelResourceResponse[]|error r = self.oasClient->updateModel(id, payload, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateModel(id, payload, headers, queries);
        }
        return r;
    }
    remote isolated function deleteModel(string id, map<string|string[]> headers = {}) returns SuccessResponse|error {
        SuccessResponse|error r = self.oasClient->deleteModel(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteModel(id, headers);
        }
        return r;
    }
    remote isolated function createModel(ModelRequest payload, map<string|string[]> headers = {}, *CreateModelQueries queries) returns ModelResponse|error {
        ModelResponse|error r = self.oasClient->createModel(payload, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createModel(payload, headers, queries);
        }
        return r;
    }
    remote isolated function listModelRevisions(string modelId, map<string|string[]> headers = {}, *ListModelRevisionsQueries queries) returns ModelRevisionsResponse[]|error {
        ModelRevisionsResponse[]|error r = self.oasClient->listModelRevisions(modelId, headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listModelRevisions(modelId, headers, queries);
        }
        return r;
    }
    remote isolated function updateModelInfo(string modelId, ModelInfoRequest payload, map<string|string[]> headers = {}) returns ModelInfoResponse|error {
        ModelInfoResponse|error r = self.oasClient->updateModelInfo(modelId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateModelInfo(modelId, payload, headers);
        }
        return r;
    }
    remote isolated function checkSyntax(SyntaxCheckRequest payload, map<string|string[]> headers = {}) returns SyntaxCheckResponse|error {
        SyntaxCheckResponse|error r = self.oasClient->checkSyntax(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->checkSyntax(payload, headers);
        }
        return r;
    }
    remote isolated function createDiagramDraft(map<string|string[]> headers = {}, *CreateDiagramDraftQueries queries) returns DiagramDraftResponse|error {
        DiagramDraftResponse|error r = self.oasClient->createDiagramDraft(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createDiagramDraft(headers, queries);
        }
        return r;
    }
    remote isolated function getMetaInfo(map<string|string[]> headers = {}) returns MetaResponseItem[]|error? {
        MetaResponseItem[]|error? r = self.oasClient->getMetaInfo(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getMetaInfo(headers);
        }
        return r;
    }
    remote isolated function createMetaInfo(MetaInfoRequest payload, map<string|string[]> headers = {}) returns MetaResponseItem|error {
        MetaResponseItem|error r = self.oasClient->createMetaInfo(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createMetaInfo(payload, headers);
        }
        return r;
    }
    remote isolated function getExpirationDate(string modelID, map<string|string[]> headers = {}) returns ExpirationDate|error {
        ExpirationDate|error r = self.oasClient->getExpirationDate(modelID, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getExpirationDate(modelID, headers);
        }
        return r;
    }
    remote isolated function updateExpirationDate(string modelID, ExpirationDate payload, map<string|string[]> headers = {}) returns ExpirationDate|error {
        ExpirationDate|error r = self.oasClient->updateExpirationDate(modelID, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateExpirationDate(modelID, payload, headers);
        }
        return r;
    }
    remote isolated function createExpirationDate(string modelID, ExpirationDate payload, map<string|string[]> headers = {}) returns ExpirationDate|error {
        ExpirationDate|error r = self.oasClient->createExpirationDate(modelID, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createExpirationDate(modelID, payload, headers);
        }
        return r;
    }
    remote isolated function deleteExpirationDate(string modelID, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->deleteExpirationDate(modelID, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteExpirationDate(modelID, headers);
        }
        return r;
    }
    remote isolated function listObjectives(map<string|string[]> headers = {}, *ListObjectivesQueries queries) returns ObjectivesResponse|error {
        ObjectivesResponse|error r = self.oasClient->listObjectives(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listObjectives(headers, queries);
        }
        return r;
    }
    remote isolated function getObjective(string objectiveSid, map<string|string[]> headers = {}) returns Objective|error {
        Objective|error r = self.oasClient->getObjective(objectiveSid, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getObjective(objectiveSid, headers);
        }
        return r;
    }
    remote isolated function getInitiativesByObjective(string objectiveSid, map<string|string[]> headers = {}) returns InitiativeSummaryForObjective[]|error {
        InitiativeSummaryForObjective[]|error r = self.oasClient->getInitiativesByObjective(objectiveSid, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getInitiativesByObjective(objectiveSid, headers);
        }
        return r;
    }
    remote isolated function search(map<string|string[]> headers = {}, *SearchQueries queries) returns http:Response|error {
        http:Response|error r = self.oasClient->search(headers, queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->search(headers, queries);
        }
        return r;
    }
    remote isolated function getServiceDocument(map<string|string[]> headers = {}) returns ServiceDocument|error {
        ServiceDocument|error r = self.oasClient->getServiceDocument(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getServiceDocument(headers);
        }
        return r;
    }
    remote isolated function getMetadata(map<string|string[]> headers = {}) returns xml|error {
        xml|error r = self.oasClient->getMetadata(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getMetadata(headers);
        }
        return r;
    }
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
