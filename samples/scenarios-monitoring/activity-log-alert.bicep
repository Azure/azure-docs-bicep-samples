param activityLogAlertName string = '${uniqueString(resourceGroup().id)}-alert'
param actionGroupName string = 'testactiongroup'

resource actionGroup 'Microsoft.Insights/actionGroups@2021-09-01' existing = {
  name: actionGroupName
}

resource activityLogAlert 'Microsoft.Insights/activityLogAlerts@2020-10-01' = {
  name: activityLogAlertName
  location: 'Global'
  properties: {
    condition: {
      allOf: [
        {
          field: 'category'
          equals: 'Administrative'
        }
        {
          field: 'operationName'
          equals: 'Microsoft.Resources/deployments/write'
        }
        {
          field: 'resourceType'
          equals: 'Microsoft.Resources/deployments'
        }
      ]
    }
    actions: {
      actionGroups: [
        {
          actionGroupId: actionGroup.id
        }
      ]
    }
    scopes: [
      subscription().id
    ]
  }
}
