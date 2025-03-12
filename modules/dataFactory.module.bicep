@description('The tags for the Data Factory.')
param tags object

@description('The locatio of the Data Factory.')
param location string

@description('The name of the data factory.')
param dataFactoryName string

@description('The Log Analytics workspace ID.')
param workspaceId string

resource dataFactory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: dataFactoryName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {}
}

resource logAnalyticsWorkspaceDataFactory 'Microsoft.Insights/diagnosticSettings@2017-05-01-preview' = {
  name: '${dataFactory.name}-insights-analytics'
  scope: dataFactory
  properties: {
    workspaceId: workspaceId
    logs: [
      {
        category: 'ActivityRuns'
        enabled: true
      }
      {
        category: 'PipelineRuns'
        enabled: true
      }
      {
        category: 'TriggerRuns'
        enabled: true
      }
    ]
  }
}

output dataFactoryId string = dataFactory.id
output dataFactoryName string = dataFactory.name
output dataFactoryPrincipalId string = dataFactory.identity.principalId
