param location string = resourceGroup().location

var nsgconfig = json(loadTextContent('nsg-security-rules.json'))

resource newNSG 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: 'example-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'SSH'
        properties: {
          description: nsgconfig.description
          protocol: nsgconfig.protocol
          sourcePortRange: nsgconfig.sourcePortRange
          destinationPortRange: nsgconfig.destinationPortRange
          sourceAddressPrefix: nsgconfig.sourceAddressPrefix
          destinationAddressPrefix: nsgconfig.destinationAddressPrefix
          access: nsgconfig.access
          priority: nsgconfig.priority
          direction: nsgconfig.direction
        }
      }
    ]
  }
}
