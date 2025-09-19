param location string = resourceGroup().location
param storageName string = 'funcdemostore${uniqueString(resourceGroup().id)}'
param cosmosName string = 'funcdemocosmos${uniqueString(resourceGroup().id)}'
param functionAppName string = 'funcdemo${uniqueString(resourceGroup().id)}'
param gitRepoUrl string
param gitBranch string = 'main'

resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource cosmos 'Microsoft.DocumentDB/databaseAccounts@2023-04-15' = {
  name: cosmosName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
        failoverPriority: 0
      }
    ]
  }
}

resource cosmosDb 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2023-04-15' = {
  name: '${cosmos.name}/MyDB'
  properties: {
    resource: { id: 'MyDB' }
    options: {}
  }
}

resource cosmosContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2023-04-15' = {
  name: '${cosmosDb.name}/Items'
  properties: {
    resource: {
      id: 'Items'
      partitionKey: { paths: ['/id'], kind: 'Hash' }
    }
    options: {}
  }
}

resource plan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: '${functionAppName}-plan'
  location: location
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
  }
}

resource func 'Microsoft.Web/sites@2023-12-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: plan.id
    siteConfig: {
      appSettings: [
        { name: 'AzureWebJobsStorage', value: storage.properties.primaryEndpoints.blob }
        { name: 'FUNCTIONS_EXTENSION_VERSION', value: '~4' }
        { name: 'FUNCTIONS_WORKER_RUNTIME', value: 'node' }
        { name: 'CosmosDBConnection', value: 'AccountEndpoint=${cosmos.properties.documentEndpoint};AccountKey=<to-be-patched>' }
      ]
    }
  }
}

resource srcControl 'Microsoft.Web/sites/sourcecontrols@2022-03-01' = {
  name: '${func.name}/web'
  properties: {
    repoUrl: gitRepoUrl
    branch: gitBranch
    isManualIntegration: true
    isGitHubAction: true
  }
}
