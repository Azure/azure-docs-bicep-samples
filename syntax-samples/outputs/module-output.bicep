module publicIP 'modules/public-ip-address.bicep' = {
  name: 'public-ip-address-module'
}

resource loadBalancer 'Microsoft.Network/loadBalancers@2020-11-01' = {
  name: loadBalancerName
  location: location
  properties: {
    frontendIPConfigurations: [
      {
        name: 'name'
        properties: {
          publicIPAddress: {
            id: publicIP.outputs.resourceId
          }
        }
      }
    ]
    // ...
  }
}
