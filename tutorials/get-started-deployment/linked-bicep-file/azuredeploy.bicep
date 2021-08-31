param projectName string {
  minLength: 3
  maxLength: 11
  metadata: {
    description: 'Specify a project name that is used to generate resource names.'
  }
}
param location string {
  metadata: {
    description: 'Specify a location for the resources.'
  }
  default: resourceGroup().location
}
param linuxFxVersion string {
  metadata: {
    description: 'Specify the Runtime stack of current web app'
  }
  default: 'php|7.0'
}
param linkedTemplateUri string{
  metadata: {
    description: 'The Uri of the linked template.'
  }
}
var storageAccountName_var = concat(projectName, uniqueString(resourceGroup().id))
var webAppName_var = '${projectName}WebApp'
var appServicePlanName_var = '${projectName}Plan'

resource linkedTemplate 'Microsoft.Resources/deployments@2018-05-01' = {
  name: linkedTemplateUri

}

resource appServicePlanName 'Microsoft.Web/serverfarms@2020-09-01' = {
  name: appServicePlanName_var
  location: location
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

resource webAppName 'Microsoft.Web/sites@2020-09-01' = {
  name: webAppName_var
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlanName.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
    }
  }
}

output storageEndpoint object = reference(storageAccountName_var).primaryEndpoints