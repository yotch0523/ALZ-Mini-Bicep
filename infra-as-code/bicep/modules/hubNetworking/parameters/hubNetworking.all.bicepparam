using '../hubNetworking.bicep'

param parLocation = 'japaneast'
param parCompanyPrefix = 'alz'
param parHubNetworkName = 'alz-hub-japaneast'
param parHubNetworkAddressPrefix = '10.0.0.0/16'
param parSubnets = [
  {
    name: 'AzureBastionSubnet'
    ipAddressRange: '10.0.0.0/26'
    networkSecurityGroupId: ''
    routeTableId: ''
  }
  {
    name: 'GatewaySubnet'
    ipAddressRange: '10.0.254.0/27'
    networkSecurityGroupId: ''
    routeTableId: ''
  }
  {
    name: 'AzureFirewallSubnet'
    ipAddressRange: '10.0.255.0/24'
    networkSecurityGroupId: ''
    routeTableId: ''
  }
  {
    name: 'AzureFirewallManagementSubnet'
    ipAddressRange: '10.0.253.0/24'
    networkSecurityGroupId: ''
    routeTableId: ''
  }
]
param parDnsServerIps = []
param parPublicIpSku = 'Standard'
param parPublicIpPrefix = ''
param parPublicIpSuffix = '-PublicIP'
param parAzBastionEnabled = false
param parAzBastionName = 'alz-bastion'
param parAzBastionSku = 'Standard'
param parAzBastionTunneling = false
param parAzBastionNsgName = 'nsg-AzureBastionSubnet'
param parDdosEnabled = false
param parDdosPlanName = 'alz-ddos-plan'
param parAzFirewallEnabled = false
param parAzFirewallName = 'alz-azfw-eastus'
param parAzFirewallPoliciesName = 'alz-azfwpolicy-eastus'
param parAzFirewallTier = 'Standard'
param parAzFirewallIntelMode = 'Alert'
param parAzFirewallAvailabilityZones = []
param parAzErGatewayAvailabilityZones = []
param parAzVpnGatewayAvailabilityZones = []
param parAzFirewallDnsProxyEnabled = false
param parAzFirewallDnsServers = []
param parHubRouteTableName = 'alz-hub-routetable'
param parDisableBgpRoutePropagation = false
param parPrivateDnsZonesEnabled = false
param parPrivateDnsZones = [
  'privatelink.${parLocation}.azmk8s.io'
  'privatelink.${parLocation}.batch.azure.com'
  'privatelink.${parLocation}.kusto.windows.net'
  'privatelink.jpe.backup.windowsazure.com'
  'privatelink.adf.azure.com'
  'privatelink.adf.azure.com'
  'privatelink.afs.azure.net'
  'privatelink.agentsvc.azure-automation.net'
  'privatelink.analysis.windows.net'
  'privatelink.api.azureml.ms'
  'privatelink.azconfig.io'
  'privatelink.azure-api.net'
  'privatelink.azure-automation.net'
  'privatelink.azurecr.io'
  'privatelink.azure-devices.net'
  'privatelink.azure-devices-provisioning.net'
  'privatelink.azuredatabricks.net'
  'privatelink.azurehdinsight.net'
  'privatelink.azurehealthcareapis.com'
  'privatelink.azurestaticapps.net'
  'privatelink.azuresynapse.net'
  'privatelink.azurewebsites.net'
  'privatelink.batch.azure.com'
  'privatelink.blob.core.windows.net'
  'privatelink.cassandra.cosmos.azure.com'
  'privatelink.cognitiveservices.azure.com'
  'privatelink.database.windows.net'
  'privatelink.datafactory.azure.net'
  'privatelink.dev.azuresynapse.net'
  'privatelink.dfs.core.windows.net'
  'privatelink.dicom.azurehealthcareapis.com'
  'privatelink.digitaltwins.azure.net'
  'privatelink.directline.botframework.com'
  'privatelink.documents.azure.com'
  'privatelink.eventgrid.azure.net'
  'privatelink.file.core.windows.net'
  'privatelink.gremlin.cosmos.azure.com'
  'privatelink.guestconfiguration.azure.com'
  'privatelink.his.arc.azure.com'
  'privatelink.kubernetesconfiguration.azure.com'
  'privatelink.managedhsm.azure.net'
  'privatelink.mariadb.database.azure.com'
  'privatelink.media.azure.net'
  'privatelink.mongo.cosmos.azure.com'
  'privatelink.monitor.azure.com'
  'privatelink.mysql.database.azure.com'
  'privatelink.notebooks.azure.net'
  'privatelink.ods.opinsights.azure.com'
  'privatelink.oms.opinsights.azure.com'
  'privatelink.pbidedicated.windows.net'
  'privatelink.postgres.database.azure.com'
  'privatelink.prod.migration.windowsazure.com'
  'privatelink.purview.azure.com'
  'privatelink.purviewstudio.azure.com'
  'privatelink.queue.core.windows.net'
  'privatelink.redis.cache.windows.net'
  'privatelink.redisenterprise.cache.azure.net'
  'privatelink.search.windows.net'
  'privatelink.service.signalr.net'
  'privatelink.servicebus.windows.net'
  'privatelink.siterecovery.windowsazure.com'
  'privatelink.sql.azuresynapse.net'
  'privatelink.table.core.windows.net'
  'privatelink.table.cosmos.azure.com'
  'privatelink.tip1.powerquery.microsoft.com'
  'privatelink.token.botframework.com'
  'privatelink.vaultcore.azure.net'
  'privatelink.web.core.windows.net'
  'privatelink.webpubsub.azure.com'
]
param parPrivateDnsZoneAutoMergeAzureBackupZone = false
param parVpnGatewayEnabled = false
param parVpnGatewayConfig = {
  name: 'alz-Vpn-Gateway'
  gatewayType: 'Vpn'
  sku: 'VpnGw1'
  vpnType: 'RouteBased'
  generation: 'Generation1'
  enableBgp: false
  activeActive: false
  enableBgpRouteTranslationForNat: false
  enableDnsForwarding: false
  bgpPeeringAddress: ''
  bgpsettings: {
    asn: '65515'
    bgpPeeringAddress: ''
    peerWeight: '5'
  }
  vpnClientConfiguration: {}
}
param parExpressRouteGatewayEnabled = false
param parExpressRouteGatewayConfig = {
  name: 'alz-ExpressRoute-Gateway'
  gatewayType: 'ExpressRoute'
  sku: 'Standard'
  vpnType: 'RouteBased'
  generation: 'None'
  enableBgp: false
  activeActive: false
  enableBgpRouteTranslationForNat: false
  enableDnsForwarding: false
  bgpPeeringAddress: ''
  bgpsettings: {
    asn: '65515'
    bgpPeeringAddress: ''
    peerWeight: '5'
  }
}
param parTags = {
  Environment: 'test'
  Workload: 'Connectivity'
}
param parTelemetryOptOut = false
param parBastionOutboundSshRdpPorts = [
  '22'
  '3389'
]
param parGlobalResourceLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Hub Networking Module.'
}
param parVirtualNetworkLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Hub Networking Module.'
}
param parBastionLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Hub Networking Module.'
}
param parDdosLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Hub Networking Module.'
}
param parAzureFirewallLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Hub Networking Module.'
}
param parHubRouteTableLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Hub Networking Module.'
}
param parPrivateDNSZonesLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Hub Networking Module.'
}
param parVirtualNetworkGatewayLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Hub Networking Module.'
}
