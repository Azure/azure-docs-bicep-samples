module stgModule '../storageAccount.bicep' = {
  name: 'storageDeploy'
  params: {
    storagePrefix: 'examplestg1'
  }
}
