data "azurerm_subscription" "current" {
}

data "azurerm_client_config" "current" {
}


data "azurerm_resource_group" "main" {
  name = module.resource_group_platform.name

  depends_on = [
    module.resource_group_platform
  ]
}

data "azurerm_kubernetes_cluster" "main" {
  name                = format("aks-%s", var.name)
  resource_group_name = module.resource_group_platform.name

  depends_on = [
    module.kubernetes
  ]
}
