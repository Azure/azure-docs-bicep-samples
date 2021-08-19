param vNetSettings object = {
  name: 'VNet1'
  addressPrefixes: [
    {
      name: 'firstPrefix'
      addressPrefix: '10.0.0.0/22'
    }
  ]
  subnets: [
    {
      name: 'firstSubnet'
      addressPrefix: '10.0.0.0/24'
    }
    {
      name: 'secondSubnet'
      addressPrefix: '10.0.1.0/24'
    }
  ]
}

output name string = vNetSettings.name
output addressPrefix string = vNetSettings.addressPrefixes[0].addressPrefix
output subnet1 string = vNetSettings.subnets[0].addressPrefix
output subnet2 string = vNetSettings.subnets[1].addressPrefix