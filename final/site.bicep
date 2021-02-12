param namePrefix string
param location string = resourceGroup().location

param dockerImage string
param dockerImageTag string

param appPlanId string

resource site 'microsoft.web/sites@2020-06-01' = {
  name: '${namePrefix}-site'
  location: location
  properties: {
    siteConfig: {
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://index.docker.io'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: ''
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: ''
        }
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
      ]
      linuxFxVersion: 'DOCKER|${dockerImage}:${dockerImageTag}'
    }
    serverFarmId: appPlanId
  }
}

// var farmName = '${namePrefix}-farm'

// resource farm 'microsoft.web/serverFarms@2020-06-01' = {
//   name: farmName
//   location: location
//   sku: {
//     name: 'B1'
//     tier: 'Basic'
//   }
//   kind: 'linux'
//   properties: {
//     targetWorkerSizeId: 0
//     targetWorkerCount: 1
//     reserved: true
//   }
// }