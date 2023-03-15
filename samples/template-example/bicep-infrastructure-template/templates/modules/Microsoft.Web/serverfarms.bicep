
param location string

@minLength(1) 
@maxLength(40)
param planName  string

@allowed([
  'linux'
  'windows'
])
param operatingSys string 

param skuName string
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  location:location
  name:planName
  kind: operatingSys
  properties:{
    reserved:true
  }
  sku:{
    name: skuName 
  }
}
