using '../vnetPeering.bicep'

param parSourceVirtualNetworkName = 'vnet-spoke'
param parDestinationVirtualNetworkResourceGroupName = 'alz-hub-eastus-rg'
param parDestinationVirtualNetworkName = 'alz-hub-eastus'
param parAllowVirtualNetworkAccess = true
param parAllowForwardedTraffic = true
param parAllowGatewayTransit = false
param parUseRemoteGateways = false
param parTelemetryOptOut = false
