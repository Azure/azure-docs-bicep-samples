param identity string
param utcValue string = utcNow()

resource runBashWithOutputs 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'runBashWithOutputs'
  location: resourceGroup().location
  kind: 'AzureCLI'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${identity}': {}
    }
  }
  properties: {
    forceUpdateTag: utcValue
    azCliVersion: '2.28.0'
    timeout: 'PT30M'
    arguments: '\'foo\' \'bar\''
    scriptContent: 'result=$(az keyvault list); echo "arg1 is: $1"; echo "arg2 is: $2"; echo $result | jq -c \'{Result: map({id: .id})}\' > $AZ_SCRIPTS_OUTPUT_PATH'
    cleanupPreference: 'OnSuccess'
    retentionInterval: 'P1D'
  }
}

output result object = runBashWithOutputs.properties.outputs
