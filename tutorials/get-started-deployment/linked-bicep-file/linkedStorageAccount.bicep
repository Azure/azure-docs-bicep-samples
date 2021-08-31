param storageAccountName string {
  metadata: {
    description: 'Specify the storage account name.'
  }
}
param location string {
  metadata: {
    description: 'Specify a location for the resources.'
  }
}
param storageSKU string {
  allowed: [
    'Standard_LRS'
    'Standard_GRS'
    'Standard_RAGRS'
    'Standard_ZRS'
    'Premium_LRS'
    'Premium_ZRS'
    'Standard_GZRS'
    'Standard_RAGZRS'
  ]
  metadata: {
    description: 'Specify the storage account type.'
  }
  default: 'Standard_LRS'
}

resource storageAccountName_resource 'Microsoft.Storage/storageAccounts@2019-04-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageSKU
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

output storageEndpoint object = reference(storageAccountName).primaryEndpoints