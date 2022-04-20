param actionGroupName string = 'On-Call Team'
param location string = resourceGroup().location

resource supportTeamActionGroup 'Microsoft.Insights/actionGroups@2021-09-01' = {
  name: actionGroupName
  location: location
  properties: {
    enabled: true
    groupShortName: actionGroupName
    emailReceivers: [
      {
        name: actionGroupName
        emailAddress: 'oncallteam@contoso.com'
        useCommonAlertSchema: true
      }
    ] 
  }
}
