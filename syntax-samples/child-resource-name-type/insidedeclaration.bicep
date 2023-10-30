resource storage 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'examplestorage'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }

  resource service 'fileServices' = {
    name: 'default'

    resource share 'shares' = {
      name: 'exampleshare'
    }
  }
  
  //Or create several blob containers
  resource service 'blobServices' = {
    name: 'default'
    resource container 'containers@2021-04-01' = [for name in containerNames: {
      name: name
    }]
  }
}
