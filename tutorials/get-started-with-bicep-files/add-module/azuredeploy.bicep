@minLength(3)
@maxLength(11)
param storagePrefix string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
])
param storageSKU string = 'Standard_LRS'

param location string = resourceGroup().location
param appServicePlanName string = 'exampleplan'
param webAppName string {
  minLength: 2
  metadata: {
    description: 'Base name of the resource such as web app name and app service plan '
  }
}
param linuxFxVersion string {
  metadata: {
    description: 'The Runtime stack of current web app'
  }
  default: 'php|7.0'
}
param resourceTags object = {
  Environment: 'Dev'
  Project: 'Tutorial'
}

var uniqueStorageName = '${storagePrefix}${uniqueString(resourceGroup().id)}'
var webAppPortalName = '${webAppName}${uniqueString(resourceGroup().id)}'

module stg './storage.bicep' = {
  name: 'storageDeploy'
  params: {
    storagePrefix: storagePrefix
    location: location
    resourceTags: resourceTags
  }
}

resource appPlan 'Microsoft.Web/serverfarms@2016-09-01' = {
  name: appServicePlanName
  location: location
  tags: resourceTags
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    family: 'B'
    capacity: 1
  }
  kind: 'linux'
  properties: {
    perSiteScaling: false
    reserved: true
    targetWorkerCount: 0
    targetWorkerSizeId: 0
  }
}

resource site 'Microsoft.Web/sites@2016-08-01' = {
  name: webAppPortalName
  location: location
  tags: resourceTags
  kind: 'app'
  properties: {
    serverFarmId: appPlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
    }
  }
}

output storageEndpoint object = stg.outputs.storageEndpoint