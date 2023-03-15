param storageAccountName string

@allowed([
  'Blob'
  'Container'
  'None'
])
param publicAcces string  

@description('existing blob service')
resource  blobService 'Microsoft.Storage/storageAccounts/blobServices@2022-05-01'existing = {
  name:'default'
  parent:storageAcc
}

resource storageAcc 'Microsoft.Storage/storageAccounts@2022-05-01' existing = {
  name:storageAccountName
}

@description('blob container ')
resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01'={
  name:'blobcontainer'
  parent:blobService
  properties:{
    publicAccess:publicAcces
  }
}
