param location string = resourceGroup().location
param tables object = {
  abc: [
    {
      partitionKey: 'emotion'
      rowKey: 'happy'
      blah: 'asdf'
      test: 5
    }
    {
      partitionKey: 'emotion'
      rowKey: 'angry'
      blah: 'bdfae'
      test: 221
      another: 'testing'
    }
  ]
  def: [
    {
      partitionKey: 'emotion'
      rowKey: 'sad'
      blah: 'jiuo'
      test: 2
    }
  ]
  ghi: []
}

var apostrophe = '\''

resource runPowerShellInline 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'runPowerShellInline'
  location: location
  kind: 'AzurePowerShell'
  properties: {
    forceUpdateTag: '1'
    azPowerShellVersion: '8.3'
    arguments: '-tables ${apostrophe}${replace(string(tables), '"', '\\"')}${apostrophe}'
    scriptContent: '''
      param([string] $tables)
      $output = ConvertFrom-Json $tables -AsHashtable | ConvertTo-Json -Depth 5 -Compress
      $DeploymentScriptOutputs = @{}
      $DeploymentScriptOutputs['text'] = $output
    '''
    supportingScriptUris: []
    timeout: 'PT10M'
    cleanupPreference: 'OnSuccess'
    retentionInterval: 'P1D'
  }
}

output result string = runPowerShellInline.properties.outputs.text
