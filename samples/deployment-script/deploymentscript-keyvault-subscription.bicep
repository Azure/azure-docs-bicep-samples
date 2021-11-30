targetScope = 'subscription'

@description('Specifies a project name that is used for generating resource group name and resource names.')
param projectName string

@description('Specifies the Azure location where the key vault should be created.')
param location string

@description('Specifies whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault.')
@allowed([
  true
  false
])
param enabledForDeployment bool = false

@description('Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys.')
@allowed([
  true
  false
])
param enabledForDiskEncryption bool = false

@description('Specifies whether Azure Resource Manager is permitted to retrieve secrets from the key vault.')
@allowed([
  true
  false
])
param enabledForTemplateDeployment bool = false

@description('Specifies the Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. Get it by using Get-AzSubscription cmdlet.')
param tenantId string = subscription().tenantId

@description('Specifies the object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies. Get it by using Get-AzADUser or Get-AzADServicePrincipal cmdlets.')
param objectId string

@description('Specifies the permissions to keys in the vault. Valid values are: all, encrypt, decrypt, wrapKey, unwrapKey, sign, verify, get, list, create, update, import, delete, backup, restore, recover, and purge.')
param keysPermissions array = [
  'list'
]

@description('Specifies the permissions to secrets in the vault. Valid values are: all, get, list, set, delete, backup, restore, recover, and purge.')
param secretsPermissions array = [
  'list'
]

@description('Specifies whether the key vault is a standard vault or a premium vault.')
@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

@description('Specifies the ID of the user-assigned managed identity.')
param identityId string

@description('Specifies the permissions to certificates in the vault. Valid values are: all, get, list, update, create, import, delete, recover, backup, restore, manage contacts, manage certificate authorities, get certificate authorities, list certificate authorities, set certificate authorities, delete certificate authorities.')
param certificatesPermissions array = [
  'get'
  'list'
  'update'
  'create'
]
param certificateName string = 'DeploymentScripts2020'
param subjectName string = 'CN=contoso.com'
param utcValue string = utcNow()

var resourceGroupName = '${projectName}rg'
var keyVaultName = '${projectName}kv'

resource kvResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  properties: {}
}

module KeyVaultDeployment './deploymentscript-keyvault.bicep' = {
  name: 'KeyVaultDeployment'
  scope: resourceGroup(resourceGroupName)
  params: {
    keyVaultName: keyVaultName
    location: location
    enabledForDeployment: enabledForDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
    enabledForTemplateDeployment: enabledForTemplateDeployment
    tenantId: tenantId
    objectId: objectId
    keysPermissions: keysPermissions
    secretsPermissions: secretsPermissions
    certificatesPermissions: certificatesPermissions
    skuName: skuName
    identityId: identityId
    utcValue: utcValue
    certificateName: certificateName
    subjectName: subjectName
  }
  dependsOn: [
    kvResourceGroup
  ]
}
