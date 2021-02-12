targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: 'alfranIgnite21'
  location: deployment().location
}

module appPlan 'app-plan.bicep' = {
  name: 'appPlanDeploy'
  scope: rg
  params: {
    namePrefix: 'adotfrank'
  }
}

var websites = [
  {
    name: 'fancy-site'
    tag: 'latest'
  }
  {
    name: 'plain-site'
    tag: 'plain-text'
  }
]

module siteDeploy 'site.bicep' = [for site in websites: {
  scope: rg
  name: 'siteDeploy-${site.name}'
  params: {
    namePrefix: site.name
    appPlanId: appPlan.outputs.appPlanId
    dockerImage: 'nginxdemos/hello'
    dockerImageTag: site.tag
  }
}]