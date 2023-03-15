@minLength(3)
@maxLength(63)
param fileShareName string 

@allowed([
  'Cool'
  'Hot'
  'Premium'
  'TransactionOptimized'
])
param accessTier string 


@allowed([
  'NFS'
  'SMB'
])
param enabledProtocols string

param shareQuota int 

param storageName string



resource storageAcc 'Microsoft.Storage/storageAccounts@2022-05-01'existing={
  name:storageName
}

resource fileServices 'Microsoft.Storage/storageAccounts/fileServices@2022-05-01' existing = {
  name: '${storageAcc.name}/default'
}


@description('file share for storage ')
resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2022-05-01' = {
  name: '${storageAcc.name}default${fileShareName}'
  parent: fileServices
  properties:{
    accessTier: accessTier
    enabledProtocols: enabledProtocols
    shareQuota: shareQuota
  }
}
