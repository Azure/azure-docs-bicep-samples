param rgLocation string
param storageNamePrefix string = 'STG'

var storageName = '${toLower(storageNamePrefix)}${uniqueString(resourceGroup().id)}'

resource demoAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageName
  location: rgLocation
  kind: 'Storage'
  sku: {
    name: 'Standard_LRS'
  }
}

output stgOutput string = storageName
