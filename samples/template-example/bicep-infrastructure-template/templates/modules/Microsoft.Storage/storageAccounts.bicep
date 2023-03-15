param location string 

@minLength(3)
@maxLength(24)
param storageName string

@allowed([
  'Cool'
  'Hot'
  'Premium'
])
param accessTier string

@allowed([
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GRS'
  'Standard_GZRS'
  'Standard_LRS'
  'Standard_RAGRS'
  'Standard_RAGZRS'
  'Standard_ZRS'
])
param skuName string

@allowed([
  'BlobStorage'
  'BlockBlobStorage'
  'FileStorage'
  'Storage'
  'StorageV2'
])
param kind string 

resource storageAcc 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  kind: kind
  location:location
  name: storageName
  sku: {
    name: skuName 
  }
  properties:{
    accessTier:accessTier
  }
}
