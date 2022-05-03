resource customerManagedKey 'Microsoft.KeyVault/vaults/keys@2021-10-01' = {
  name: keyName
  parent: keyVault
  properties: {
    kty: 'RSA'
  }
}

resource synapseWorkspace 'Microsoft.Synapse/workspaces@2021-06-01' = {
  name: workspaceName
  properties: {
    encryption: {
      cmk: {
        key: {
          name: keyName
          keyVaultUrl: customerManagedKey.properties.keyUri
        }
      }
    }   
  }
}

resource workspaceKey 'Microsoft.Synapse/workspaces/keys@2021-06-01' = {
  name: keyName
  parent: synapseWorkspace
}
