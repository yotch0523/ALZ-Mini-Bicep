using '../vnetPeering.bicep'

param parSourceVirtualNetworkName = 'alz-vnet-identity'
param parDestinationVirtualNetworkResourceGroupName = 'ALZ-Connectivity-RG'
param parDestinationVirtualNetworkName = 'alz-hub-japaneast'
param parAllowVirtualNetworkAccess = true
param parAllowForwardedTraffic = false
param parAllowGatewayTransit = false
param parUseRemoteGateways = false
param parTelemetryOptOut = false
