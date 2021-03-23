resource my_subnet 'Microsoft.Network/virtualNetworks/subnets@2020-08-01' existing = {
  name: 'foobarvnet-blueprint/foobarsubnet-blueprint'
  scope: resourceGroup('alex-test-feb')
}

output prop string = my_subnet.properties.addressPrefix
