param rgLocation string = resourceGroup().location

resource createStorage 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'storage${uniqueString(resourceGroup().id)}'
  location: rgLocation
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
