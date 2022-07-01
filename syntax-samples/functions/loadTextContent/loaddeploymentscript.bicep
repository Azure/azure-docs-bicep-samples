resource exampleScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'exampleScript'
  location: resourceGroup().location
  kind: 'AzurePowerShell'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/{sub-id}/resourcegroups/{rg-name}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{id-name}': {}
    }
  }
  properties: {
    azPowerShellVersion: '3.0'
    scriptContent: loadTextContent('myscript.ps1')
    retentionInterval: 'P1D'
  }
}
