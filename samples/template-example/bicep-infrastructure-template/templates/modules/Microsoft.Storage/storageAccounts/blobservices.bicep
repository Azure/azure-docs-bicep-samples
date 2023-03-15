param retentionDays int
param conatinerRetentionDays int 
param storageAccountName string

resource storageAcc 'Microsoft.Storage/storageAccounts@2022-05-01'existing={
  name:storageAccountName
}
@description('blob service ')
resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2022-05-01'={
  name:'default'
  parent:storageAcc
  properties:{
    automaticSnapshotPolicyEnabled:true
    changeFeed:{
      enabled:true
      retentionInDays: retentionDays
    }
    containerDeleteRetentionPolicy:{
      allowPermanentDelete:true
      days:conatinerRetentionDays
      enabled:true 
    }
  }
}
