param name string = 'John Dole'
param utcValue string = utcNow()
param location string = resourceGroup().location

resource scriptInTemplate1 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'scriptInTemplate1'
  location: location
  kind: 'AzurePowerShell'
  properties: {
    forceUpdateTag: utcValue
    azPowerShellVersion: '8.3'
    timeout: 'PT1H'
    arguments: '-name \\"${name}\\"'
    scriptContent: '''
      param([string] $name)
      $output = 'Hello {0}' -f $name
      Write-Output $output
      $DeploymentScriptOutputs = @{}
      $DeploymentScriptOutputs['text'] = $output
    '''
    cleanupPreference: 'Always'
    retentionInterval: 'P1D'
  }
}

resource scriptInTemplate2 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'scriptInTemplate2'
  location: location
  kind: 'AzurePowerShell'
  properties: {
    forceUpdateTag: utcValue
    azPowerShellVersion: '6.4'
    timeout: 'PT1H'
    arguments: '-textToEcho \\"${scriptInTemplate1.properties.outputs.text}\\"'
    scriptContent: '''
      param([string] $textToEcho)
      Write-Output $textToEcho
      $DeploymentScriptOutputs = @{}
      $DeploymentScriptOutputs['text'] = $textToEcho
    '''
    cleanupPreference: 'Always'
    retentionInterval: 'P1D'
  }
}

output result string = scriptInTemplate2.properties.outputs.text
