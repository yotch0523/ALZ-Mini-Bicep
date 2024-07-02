using '../spokeNetworking.bicep'

@description('The location in which the resources should be deployed.')
param parLocation = 'japaneast'

@description('Indicates whether BGP route propagation is disabled on the route table.')
param parDisableBgpRoutePropagation = false

@description('The resource ID of the DDoS protection plan associated with the virtual network.')
param parDdosProtectionPlanId = ''

@description('The address prefix to use for the spoke virtual network.')
param parSpokeNetworkAddressPrefix = '10.2.0.0/16'

@description('The name of the spoke virtual network.')
param parSpokeNetworkName = 'alz-vnet-landingzone01'

@description('A list of DNS server IPs to use for the spoke virtual network.')
param parDnsServerIps = []

@description('The IP address of the next hop in the route.')
param parNextHopIpAddress = ''

@description('The name of the route table for routing from the spoke to the hub.')
param parSpokeToHubRouteTableName = 'rtb-spoke-to-hub'

@description('A map of tags to apply to the resources.')
param parTags = {
  Environment: 'Test'
  Workload: 'LandingZone01'
}

@description('Indicates whether telemetry is opted out.')
param parTelemetryOptOut = false

@description('The global resource lock configuration.')
param parGlobalResourceLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Spoke Networking Module.'
}

@description('The spoke network lock configuration.')
param parSpokeNetworkLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Spoke Networking Module.'
}

@description('The spoke route table lock configuration.')
param parSpokeRouteTableLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Spoke Networking Module.'
}
