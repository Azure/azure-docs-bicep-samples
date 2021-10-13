targetScope = 'subscription'

@minLength(3)
@maxLength(11)
param namePrefix string

resource demoRG 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: 'demogroup1'
}

module stgModule '../create-storage-account/main.bicep' = {
  name: 'storageDeploy'
  scope: demoRG
  params: {
    storagePrefix: namePrefix
    location: demoRG.location
  }
}

output storageEndpoint object = stgModule.outputs.storageEndpoint
