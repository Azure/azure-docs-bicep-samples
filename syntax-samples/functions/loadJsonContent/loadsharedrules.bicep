param location string = resourceGroup().location

var nsgconfig = loadJsonContent('nsg-security-rules.json')

resource newNSG 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: 'example-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'SSH'
        properties: nsgconfig
      }
    ]
  }
}
