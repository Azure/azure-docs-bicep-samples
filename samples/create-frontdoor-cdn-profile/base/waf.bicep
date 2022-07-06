@sys.description('WAF Subscription Id')
param wafSubsciptionId string

@sys.description('WAF resource group name')
param wafResourceGroup string

@sys.description('WAF policy name to fetch for endpoint security policies.')
param wafPolicyName string

resource waf 'Microsoft.Network/FrontDoorWebApplicationFirewallPolicies@2020-11-01' existing = {
  name: wafPolicyName
  scope: resourceGroup(wafSubsciptionId, wafResourceGroup)
}

output cdnWafId string = waf.id
