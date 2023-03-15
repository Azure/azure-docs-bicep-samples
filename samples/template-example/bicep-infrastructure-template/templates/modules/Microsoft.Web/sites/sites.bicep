
param location string
param siteName string
param planName string 
param linuxFxVersion string 

@description('azure app service plan')
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' existing = {
  name: planName
}
@description('azure app service ')
resource sites 'Microsoft.Web/sites@2022-03-01' = {
  location: location
  name: siteName
  dependsOn:[
    appServicePlan
  ]
  properties: {
    siteConfig:{
      linuxFxVersion: linuxFxVersion
    }
    serverFarmId: appServicePlan.id
  }
}
