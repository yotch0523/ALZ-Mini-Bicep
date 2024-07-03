using '../resourceGroup.bicep'

param parLocation = 'japaneast'
param parResourceGroupName = 'ALZ-Identity-RG'
param parResourceLockConfig = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Resource Group Module.'
}
param parTags = {
  Environment: 'Test'
  Workload: 'Identity'
}
param parTelemetryOptOut = false
