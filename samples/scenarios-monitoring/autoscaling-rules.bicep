param location string = resourceGroup().location
param appPlanName string = '${uniqueString(resourceGroup().id)}asp'

var appPlanSkuName = 'S1'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: appPlanName
  location: location
  sku: {
    name: appPlanSkuName
    capacity: 1
  } 
}

resource scaleOutRule 'Microsoft.Insights/autoscalesettings@2021-05-01-preview' = {
  name: appServicePlan.name
  location: location
  properties: {
    profiles: [
      {
        name: 'Scale up condition'
        capacity: {
          maximum: '3'
          default: '1'
          minimum: '1'
        }
        rules: [
          {
            scaleAction: {
              type: 'ChangeCount'
              direction: 'Increase'
              cooldown: 'PT5M'
              value: '1'
            }
            metricTrigger: {
              metricName: 'CpuPercentage'
              operator: 'GreaterThan'
              timeAggregation: 'Average'
              threshold: 70
              metricResourceUri: appServicePlan.id
              timeWindow: 'PT10M'
              timeGrain: 'PT1M'
              statistic: 'Average'
            }
          }
        ]
      }
    ]
  }
}
