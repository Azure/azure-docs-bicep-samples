@sys.description('Name of CDN Profile. For chaining, use output from parent module')
param cdnProfileName string

resource cdn 'Microsoft.Cdn/profiles@2021-06-01' existing = {
  name: cdnProfileName
  scope: resourceGroup()
}

// Rule Sets

@sys.description('Default global ruleset')
resource drs_global_rulesets 'Microsoft.Cdn/profiles/rulesets@2021-06-01' = {
  parent: cdn
  name: 'DrsGlobal'
}

// Rules
// We can have maximum 5 rule in a batch. Multiple batch can be added to a ruleset
@sys.description('Modify other request-response headers and add to global rulesets')
resource drs_global_overwriteResponseHeaders_rule 'Microsoft.Cdn/profiles/rulesets/rules@2021-06-01' = {
  parent: drs_global_rulesets
  name: 'OverwriteResponseHeaders'
  properties: {
    order: 1
    conditions: []
    actions: [
      {
        name: 'ModifyResponseHeader'
        parameters: {
          typeName: 'DeliveryRuleHeaderActionParameters'
          headerAction: 'Overwrite'
          headerName: 'X-CDN'
          value: 'AZUR'
        }
      }
      {
        name: 'ModifyRequestHeader'
        parameters: {
          typeName: 'DeliveryRuleHeaderActionParameters'
          headerAction: 'Overwrite'
          headerName: 'User-Agent'
          value: 'CDN-AZUR'
        }
      }
      {
        name: 'ModifyResponseHeader'
        parameters: {
          typeName: 'DeliveryRuleHeaderActionParameters'
          headerAction: 'Overwrite'
          headerName: 'X-CDN-Version'
          value: 'Azure-FrontDoor'
        }
      }
    ]
    matchProcessingBehavior: 'Continue'
  }
}

output defaultRuleSets array = [
  {
    id: drs_global_rulesets.id
  }
]
