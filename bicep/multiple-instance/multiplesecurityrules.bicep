@description('An array that contains objects with properties for the security rules. For format, see multiplesecurityrules.parameters.json.')
param securityRules array

var securityRulesVar = [for item in securityRules: {
  name: item.name
  properties: {
    description: item.description
    priority: item.priority
    protocol: item.protocol
    sourcePortRange: item.sourcePortRange
    destinationPortRange: item.destinationPortRange
    sourceAddressPrefix: item.sourceAddressPrefix
    destinationAddressPrefix: item.destinationAddressPrefix
    access: item.access
    direction: item.direction
  }
}]

resource netSG 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: 'NSG1'
  location: resourceGroup().location
  properties: {
    securityRules: securityRulesVar
  }
}
