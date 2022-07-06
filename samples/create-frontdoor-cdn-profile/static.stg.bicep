@sys.description('Azure Frontdoor WAF Name')
var wafPolicyName = 'FrontDoorCdnStageWAF'

@sys.description('WAF resource group name')
var wafResourceGroup  = 'afd-cdn-stg-waf-rg'

@sys.description('WAF Subsciption Id')
var wafSubsciptionId = '9aaxxxx0b-xxx-4ca4-xxxx-d81axxxx1921'


@sys.description('Origin details')
var origins = [
  {
    hostname: 'static-src.example.com'
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
    hostname: 'static.example.com'
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
var eventHubNamespaceSubscriptionId = '9aaxxxx0b-xxx-4ca4-xxxx-d81axxxx1921' 

@sys.description('Event Hub Namespace Resource Group')
var eventHubNamespaceResourceGroup = 'afd-cdn-eventhub-rg'

@sys.description('Tags to identify resource owner')
var cdnProfileTags = {
  propertyName: 'static'
  supportGroup: 'support@example.com'
  environment: envName
}

module cdn_profile 'profile/main.bicep' = {
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
