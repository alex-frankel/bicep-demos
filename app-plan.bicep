// app service plan

param namePrefix string
param sku string = 'B1'

resource plan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: '${namePrefix}-plan'
  location: resourceGroup().location
  kind: 'linux'
  sku: {
    name: sku
  }
  properties: {
    reserved: true
  }
}

output planId string = plan.id