using '../resourceGroup.bicep'

param parLocation = 'japaneast'
param parResourceGroupName = 'your-resourceGroup'
param parResourceLockConfig = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Resource Group Module.'
}
param parTags = {
  tagName: 'tagValue'
}
param parTelemetryOptOut = false
