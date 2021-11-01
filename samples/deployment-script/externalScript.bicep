param name string = '\\"John Dole\\"'
param utcValue string = utcNow()

resource runPowerShellInlineWithOutput 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'runPowerShellInlineWithOutput'
  location: resourceGroup().location
  kind: 'AzurePowerShell'
  properties: {
    forceUpdateTag: utcValue
    azPowerShellVersion: '5.0'
    primaryScriptURI: 'https://raw.githubusercontent.com/Azure/azure-docs-bicep-samples/main/samples/deployment-script/inlineScript.ps1'
    arguments: '-name ${name}'
    timeout: 'PT1H'
    cleanupPreference: 'OnSuccess'
    retentionInterval: 'P1D'
  }
}

output result string = runPowerShellInlineWithOutput.properties.outputs.text
