param name string = '\\"John Dole\\"'
param utcValue string = utcNow()

resource runPowerShellInlineWithOutput 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'runPowerShellInlineWithOutput'
  location: resourceGroup().location
  kind: 'AzurePowerShell'
  properties: {
    forceUpdateTag: utcValue
    azPowerShellVersion: '6.4'
    scriptContent: '''
      param([string] $name)
      $output = "Hello {0}" -f $name
      Write-Output $output
      $DeploymentScriptOutputs = @{}
      $DeploymentScriptOutputs["text"] = $output
    '''
    arguments: '-name ${name}'
    timeout: 'PT1H'
    cleanupPreference: 'OnSuccess'
    retentionInterval: 'P1D'
  }
}

output result string = runPowerShellInlineWithOutput.properties.outputs.text
