using '../resourceGroup.bicep'

param parProjectPrefix = 'alz'
param parLocation = 'japaneast'
param parResourceGroupName = 'ALZ-Identity-RG'
param parResourceLockConfig = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Resource Group Module.'
}
param parTags = {
  environment: 'test'
}
param parTelemetryOptOut = false
