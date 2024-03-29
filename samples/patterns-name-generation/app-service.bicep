param location string = resourceGroup().location
param environmentName string
param appServiceAppName string = 'app-contoso-${environmentName}-${uniqueString(resourceGroup().id)}'
param appServicePlanName string = 'plan-contoso-${environmentName}-${uniqueString(resourceGroup().id)}'

resource appServiceApp 'Microsoft.Web/sites@2022-09-01' = {
  name: appServiceAppName
  // ...
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  // ...
  location: location
  sku: {
    name: 'S1'
    capacity: 1
  }
}
