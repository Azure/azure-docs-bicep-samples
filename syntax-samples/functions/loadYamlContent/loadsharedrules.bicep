param location string = resourceGroup().location

var nsgconfig = loadYamlContent('nsg-security-rules.yaml')

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
