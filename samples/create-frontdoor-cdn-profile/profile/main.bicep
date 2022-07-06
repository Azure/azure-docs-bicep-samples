@allowed([
  'static'
  'media'
  'video'
])
@sys.description('CDN property Name')
param propertyName string

@allowed([
  'stg'
  'prod'
  'test'
])
@sys.description('Environment Name')
param envName string

@sys.description('Name of CDN Profile')
param cdnProfileName string = 'afd-cdn-${envName}-${propertyName}-profile'

@sys.description('Name of AFD endpoint')
param afdEndpointName string  = 'afd-cdn-${envName}-${propertyName}'

@sys.description('AFD Endpoint State')
param enableAfdEndpoint bool

@sys.description('WAF resource group name')
param wafResourceGroup string

@sys.description('Azure Frontdoor WAF Name')
param wafPolicyName string

@sys.description('WAF Subsciption Id')
param wafSubsciptionId string

@sys.description('Origin details')
param origins array

@sys.description('Custom Domain Array')
param customDomains array

@sys.description('Tags to identify resource owner')
param cdnProfileTags object

@sys.description('Event Hub Name')
param eventHubName string

@sys.description('Event Hub Namespace Name')
param eventHubNamespace string

@sys.description('Event Hub Namespace Subscription Id.')
param eventHubNamespaceSubscriptionId string 

@sys.description('Event Hub Namespace Resource Group')
param eventHubNamespaceResourceGroup string


module profile '../base/main.bicep' = {
  name: 'afdcdn-${envName}-${propertyName}-profile-module'
  scope: resourceGroup()
  params:  {
    afdEndpointName: afdEndpointName
    enableAfdEndpoint: enableAfdEndpoint
    wafPolicyName: wafPolicyName
    wafResourceGroup: wafResourceGroup
    wafSubsciptionId: wafSubsciptionId
    eventHubName: eventHubName
    eventHubNamespace: eventHubNamespace
    eventHubNamespaceResourceGroup: eventHubNamespaceResourceGroup
    eventHubNamespaceSubscriptionId: eventHubNamespaceSubscriptionId
    customDomains: customDomains
    cdnProfileName: cdnProfileName
    origins: origins
    cdnProfileTags: cdnProfileTags
  }
}
