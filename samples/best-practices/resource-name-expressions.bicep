param shortAppName string = 'toy'
param shortEnvironmentName string = 'prod'
param appServiceAppName string = '${shortAppName}-${shortEnvironmentName}-${uniqueString(resourceGroup().id)}'
