param activityLogAlertName string = uniqueString(resourceGroup().id)
param actionGroupName string = 'oncallactiongroup'

resource actionGroup 'Microsoft.Insights/actionGroups@2021-09-01' existing = {
  name: actionGroupName
}

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
      actionGroups: [
        {
          actionGroupId: actionGroup.id
        }
      ]
    }
  }
}
