@allowed([
  'default'
])
param fileServiceName string
param storageName string 

resource storageAcc 'Microsoft.Storage/storageAccounts@2022-05-01' existing = {
  name: storageName
}

resource fileServices 'Microsoft.Storage/storageAccounts/fileServices@2022-05-01' = {
  name:fileServiceName
  parent: storageAcc
  properties: {
    shareDeleteRetentionPolicy:{
      days: 30
      enabled: true
      allowPermanentDelete: true
    }
  }

}
