targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: 'adotfrank-rg'
  location: deployment().location
}

module appPlanDeploy 'appPlan.bicep' = {
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

output siteUrls array = [for (site, i) in websites: siteDeploy[i].outputs.siteUrl]
