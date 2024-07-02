using '../publicIp.bicep'

param parLocation = 'japaneast'
param parPublicIpName = 'alz'
param parPublicIpSku = {
    name: 'Standard'
    tier: 'Regional'
}
param parPublicIpProperties = {
    publicIpAddressVersion: 'IPv4'
    publicIpAllocationMethod: 'Dynamic'
    deleteOption: 'Delete'
    idleTimeoutInMinutes: 4
}
param parAvailabilityZones = []
param parTags = {
    Environment: 'test'
}
param parTelemetryOptOut = false
