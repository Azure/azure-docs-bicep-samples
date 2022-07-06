@sys.description('Azure Frontdoor WAF Name')
var wafPolicyName = 'EdgeFrontDoorCdnStageWAF'

@sys.description('WAF resource group name')
var wafResourceGroup  = 'wus-edge-afd-cdn-stg-waf-rg'

@sys.description('WAF Subsciption Id')
var wafSubsciptionId = '9aab410b-0fc2-4ca4-9342-d81a962f1921'


@sys.description('Origin details')
var origins = [
  {
    hostname: 'static-src.linkedin.com'
    originGroupName: 'static-src-origin-group'
    patternsToMatch: [
      '/*'
    ]
    enabledState: true
  } 
]

@sys.description('Custom Domain Array')
var customDomains = [
  {
    hostname: 'static-example.licdn.com'
  }
]  

@sys.description('State of the afdEndpoint. Disable it to stop CDN Profile Endpoint taking traffic.')
var enableAfdEndpoint = true

@sys.description('Environment Name')
var envName = 'stg'

@sys.description('Profile Short Name')
var propertyName = 'static'

@sys.description('Event Hub Name')
var eventHubName = 'azureafdcdnlogs'

@sys.description('Event Hub Namespace Name')
var eventHubNamespace = 'cdnlog-eventhub'

@sys.description('Event Hub Namespace Subscription Id.')
var eventHubNamespaceSubscriptionId = '9aab410b-0fc2-4ca4-9342-d81a962f1921' 

@sys.description('Event Hub Namespace Resource Group')
var eventHubNamespaceResourceGroup = 'wus-edge-cdn-prod-eventhub-rg'

@sys.description('Tags to identify resource owner')
var cdnProfileTags = {
  cdnCiProperty: 'linkedin.static'
  supportGroup: 'ask_orc@linkedin.com'
  environment: envName
}

module li_static_prod 'profile/main.bicep' = {
  name: 'afdcdn-${envName}-${propertyName}'
  params: {
    envName: envName
    propertyName: propertyName
    wafResourceGroup: wafResourceGroup
    wafSubsciptionId: wafSubsciptionId
    wafPolicyName: wafPolicyName
    origins: origins
    customDomains: customDomains
    enableAfdEndpoint: enableAfdEndpoint
    cdnProfileTags: cdnProfileTags
    eventHubName: eventHubName
    eventHubNamespace: eventHubNamespace
    eventHubNamespaceSubscriptionId: eventHubNamespaceSubscriptionId
    eventHubNamespaceResourceGroup: eventHubNamespaceResourceGroup

  }
}
