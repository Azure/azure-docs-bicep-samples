param rgLocation string = resourceGroup().location
param storageCount int = 2
param createNewStorage bool = true

resource createStorages 'Microsoft.Storage/storageAccounts@2022-09-01' = [for i in range(0, storageCount): if(createNewStorage) {
  name: '${i}storage${uniqueString(resourceGroup().id)}'
  location: rgLocation
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}]
