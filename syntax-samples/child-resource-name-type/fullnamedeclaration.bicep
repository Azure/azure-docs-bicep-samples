resource storage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'examplestorage'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource service 'Microsoft.Storage/storageAccounts/fileServices@2021-02-01' = {
  name: 'examplestorage/default'
  dependsOn: [
    storage
  ]
}

resource share 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-02-01' = {
  name: 'examplestorage/default/exampleshare'
  dependsOn: [
    service
  ]
}
    
