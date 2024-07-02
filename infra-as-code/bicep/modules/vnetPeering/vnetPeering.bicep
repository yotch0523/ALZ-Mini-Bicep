metadata name = 'ALZ Bicep - Virtual Network Peering module'
metadata description = 'Module used to set up Virtual Network Peering between Virtual Networks'

@sys.description('Name of source Virtual Network we are peering.')
param parSourceVirtualNetworkName string

@sys.description('Virtual Network Name of Virtual Network destination.')
param parDestinationVirtualNetworkName string

@sys.description('Switch to enable/disable Virtual Network Access for the Network Peer.')
param parAllowVirtualNetworkAccess bool = true

@sys.description('Switch to enable/disable forwarded traffic for the Network Peer.')
param parAllowForwardedTraffic bool = true

@sys.description('Switch to enable/disable gateway transit for the Network Peer.')
param parAllowGatewayTransit bool = false

@sys.description('Switch to enable/disable remote gateway for the Network Peer.')
param parUseRemoteGateways bool = false

@sys.description('Set Parameter to true to Opt-out of deployment telemetry.')
param parTelemetryOptOut bool = false

@sys.description('Virtual Network ID of Virtual Network destination.')
var varDestinationVirtualNetworkId = resourceId('Microsoft.Network/virtualNetworks', parDestinationVirtualNetworkName)

// Customer Usage Attribution Id
var varCuaId = uniqueString(parSourceVirtualNetworkName, '-', parDestinationVirtualNetworkName)

resource resVirtualNetworkPeer 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-02-01' = {
  name: '${parSourceVirtualNetworkName}/${parSourceVirtualNetworkName}-${parDestinationVirtualNetworkName}'
  properties: {
    allowVirtualNetworkAccess: parAllowVirtualNetworkAccess
    allowForwardedTraffic: parAllowForwardedTraffic
    allowGatewayTransit: parAllowGatewayTransit
    useRemoteGateways: parUseRemoteGateways
    remoteVirtualNetwork: {
      id: varDestinationVirtualNetworkId
    }
  }
}

// Optional Deployment for Customer Usage Attribution
module modCustomerUsageAttribution '../../CRML/customerUsageAttribution/cuaIdResourceGroup.bicep' = if (!parTelemetryOptOut) {
  #disable-next-line no-loc-expr-outside-params //Only to ensure telemetry data is stored in same location as deployment. See https://github.com/Azure/ALZ-Bicep/wiki/FAQ#why-are-some-linter-rules-disabled-via-the-disable-next-line-bicep-function for more information
  name: 'pid-${varCuaId}-${uniqueString(resourceGroup().location)}'
  params: {}
}
