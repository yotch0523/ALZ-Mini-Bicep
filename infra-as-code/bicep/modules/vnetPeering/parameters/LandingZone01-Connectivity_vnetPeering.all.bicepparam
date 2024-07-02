using '../vnetPeering.bicep'

param parSourceVirtualNetworkName = 'alz-vnet-landingzone01'
param parDestinationVirtualNetworkResourceGroupName = 'ALZ-Connectivity-RG'
param parDestinationVirtualNetworkName = 'alz-hub-japaneast'
param parAllowVirtualNetworkAccess = true
param parAllowForwardedTraffic = true
param parAllowGatewayTransit = false
param parUseRemoteGateways = false
param parTelemetryOptOut = false
