param activityLogAlertName string = uniqueString(resourceGroup().id)

resource resourceHealthAlert 'Microsoft.Insights/activityLogAlerts@2020-10-01' = {
  name: activityLogAlertName
  location: 'global'
  properties: {
    condition: {
      allOf: [
        { 
          field: 'category'
          equals: 'ServiceHealth'
        }
      ]
    }
    scopes: [
      subscription().id
    ]
    actions: {
    }
  }
}
