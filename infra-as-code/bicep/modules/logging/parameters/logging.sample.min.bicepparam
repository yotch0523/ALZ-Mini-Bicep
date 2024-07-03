using '../logging.bicep'

param parLogAnalyticsWorkspaceLogRetentionInDays = 365
param parLogAnalyticsWorkspaceLocation = 'japaneast'
param parLogAnalyticsWorkspaceSolutions = [
  'SecurityInsights'
]
param parAutomationAccountLocation = 'japaneast'
param parTelemetryOptOut = false
