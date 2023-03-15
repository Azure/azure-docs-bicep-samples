param userAssignedIdentityName string 
param deploymentScriptName  string 
param blobContainerName string
param location string 
param azCliVersion string 
param retentionInterval string
param pathToscript string = '../../../azCLI/scripts/test.sh'    // example 


resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' existing = {
  name: blobContainerName
}

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' existing = {
  name: userAssignedIdentityName
}

@description('deployemnt scripts')
resource deploymentScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: deploymentScriptName
  location: location
  kind: 'AzureCLI'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${userAssignedIdentity.id}': {}
    }
  }
  dependsOn: [
    blobContainer
  ]
  properties:{
    azCliVersion:azCliVersion
    retentionInterval: retentionInterval
    scriptContent: pathToscript
  }
}
