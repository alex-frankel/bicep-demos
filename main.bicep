targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: 'adotfrank-ignite21'
  location: deployment().location
}

module appPlanDeploy 'app-plan.bicep' = {
  name: 'appPlanDeploy'
  scope: rg
  params: {
    namePrefix: 'adotfrank'
  }
}

var websites = [
  {
    name: 'fancy'
    tag: 'latest'
  }
  {
    name: 'plain'
    tag: 'plain-text'
  }
]

module siteDeploy 'site.bicep' = [for site in websites: {
  name: '${site.name}siteDeploy'
  scope: rg
  params: {
    appPlanId: appPlanDeploy.outputs.planId
    namePrefix: site.name
    dockerImage: 'nginxdemos/hello'
    dockerImageTag: site.tag
  }
}]