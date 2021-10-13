param managementGroupName string

module mgDeploy 'main.bicep' = {
  name: 'deployToMG'
  scope: managementGroup(managementGroupName)
}
