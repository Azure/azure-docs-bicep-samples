@description('The site name. To use the default value, do not specify a new value.')
param siteName string = 'site${uniqueString(resourceGroup().id)}'

@description('The host name. To use the default value, do not specify a new value.')
param hostingPlanName string = '${siteName}-plan'

output siteNameOutput string = siteName
output hostingPlanOutput string = hostingPlanName