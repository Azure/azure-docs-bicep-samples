param org array = [
  'contoso'
  'fabrikam'
  'coho'
]

param rgLocation string = resourceGroup().location

resource storageAcct 'Microsoft.Storage/storageAccounts@2021-02-01' = [for item in org: {
  name: '${item}${uniqueString(resourceGroup().id)}'
  location: rgLocation
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
}]
