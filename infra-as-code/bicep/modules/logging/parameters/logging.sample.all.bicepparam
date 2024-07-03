using '../logging.bicep'

param parLogAnalyticsWorkspaceName = 'alz-log-analytics'
param parLogAnalyticsWorkspaceLocation = 'japaneast'
param parLogAnalyticsWorkspaceSkuName = 'PerGB2018'
param parLogAnalyticsWorkspaceCapacityReservationLevel = 100
param parLogAnalyticsWorkspaceLogRetentionInDays = 365
param parLogAnalyticsWorkspaceSolutions = [
  'SecurityInsights'
]
param parDataCollectionRuleVMInsightsName = 'alz-ama-vmi-dcr'
param parDataCollectionRuleChangeTrackingName = 'alz-ama-ct-dcr'
param parDataCollectionRuleMDFCSQLName = 'alz-ama-mdfcsql-dcr'
param parUserAssignedManagedIdentityName = 'alz-umi-identity'
param parLogAnalyticsWorkspaceLinkAutomationAccount = true
param parAutomationAccountName = 'alz-automation-account'
param parAutomationAccountLocation = 'japaneast'
param parAutomationAccountUseManagedIdentity = true
param parAutomationAccountPublicNetworkAccess = true
param parTags = {
  Environment: 'Test'
  Workload: 'Management'
}
param parUseSentinelClassicPricingTiers = false
param parLogAnalyticsLinkedServiceAutomationAccountName = 'Automation'
param parTelemetryOptOut = false
param parGlobalResourceLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Logging Module.'
}
param parAutomationAccountLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Logging Module.'
}
param parLogAnalyticsWorkspaceLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Logging Module.'
}
param parLogAnalyticsWorkspaceSolutionsLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Logging Module.'
}
param parDataCollectionRuleVMInsightsLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Logging Module.'
}
param parDataCollectionRuleChangeTrackingLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Logging Module.'
}
param parDataCollectionRuleMDFCSQLLock = {
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Logging Module.'
}
