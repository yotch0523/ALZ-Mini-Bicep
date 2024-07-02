using '../vnetPeering.bicep'

param parSourceVirtualNetworkName = 'alz-hub-japaneast'
param parDestinationVirtualNetworkName = 'alz-vnet-landingzone01'
param parAllowVirtualNetworkAccess = true
param parAllowForwardedTraffic = true
param parAllowGatewayTransit = false
param parUseRemoteGateways = false
param parTelemetryOptOut = false
