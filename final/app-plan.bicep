param namePrefix string

resource farm 'microsoft.web/serverFarms@2020-06-01' = {
  name: '${namePrefix}${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  sku: {
    name: 'B1'
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

output appPlanId string = farm.id