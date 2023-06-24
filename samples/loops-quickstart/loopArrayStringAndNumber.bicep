param rgLocation string = resourceGroup().location
param storageNames array = [
  'contoso'
  'fabrikam'
]

resource createStorages 'Microsoft.Storage/storageAccounts@2022-09-01' = [for (name, i) in storageNames: {
  name: '${i}${name}${uniqueString(resourceGroup().id)}'
  location: rgLocation
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}]
