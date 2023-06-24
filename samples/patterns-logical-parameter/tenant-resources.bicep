param location string
param sqlServerName string
param frontDoorProfileName string
param tenant object

var frontDoorCustomDomainName = replace(tenant.domainName, '.', '-')

// Deploy a database for the tenant.
resource sqlServer 'Microsoft.Sql/servers@2022-11-01-preview' existing = {
  name: sqlServerName
}

resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2022-11-01-preview' = {
  parent: sqlServer
  name: tenant.id
  location: location
}

// Deploy a Front Door custom domain for the tenant.
resource frontDoorProfile 'Microsoft.Cdn/profiles@2023-05-01' existing = {
  name: frontDoorProfileName
}

resource frontDoorCustomDomain 'Microsoft.Cdn/profiles/customDomains@2023-05-01' = {
  parent: frontDoorProfile
  name: frontDoorCustomDomainName
  properties: {
    hostName: tenant.domainName
  }
}

output frontDoorCustomDomainId string = frontDoorCustomDomain.id
