param azureContainerName string
param location string
param azurerContainerSku string



resource acrResource 'Microsoft.ContainerRegistry/registries@2021-09-01' = {
  name: azureContainerName
  location: location
  sku: {
    name: azurerContainerSku
  }
  properties: {
    adminUserEnabled: false
  }
}
