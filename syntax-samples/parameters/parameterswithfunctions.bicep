param siteName string = 'site${uniqueString(resourceGroup().id)}'
param hostingPlanName string = '${siteName}-plan'

output siteNameOutput string = siteName
output hostingPlanOutput string = hostingPlanName
