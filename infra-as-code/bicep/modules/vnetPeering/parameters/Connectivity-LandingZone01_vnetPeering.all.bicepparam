using '../vnetPeering.bicep'

param parSourceVirtualNetworkName = 'alz-hub-japaneast'
param parDestinationVirtualNetworkResourceGroupName = 'ALZ-LandingZone01-RG'
param parDestinationVirtualNetworkName = 'alz-vnet-landingzone01'
param parAllowVirtualNetworkAccess = true
param parAllowForwardedTraffic = false
param parAllowGatewayTransit = false
param parUseRemoteGateways = false
param parTelemetryOptOut = false
