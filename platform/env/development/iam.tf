##### External DNS
resource "azurerm_role_assignment" "external_dns_dns_zone_contributor" {
  scope                = module.dns_zone.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.external_dns_managed_identity.principal_id

  depends_on = [
    module.kubernetes
  ]
}

resource "azurerm_role_assignment" "external_dns_rg_reader" {
  scope                = data.azurerm_resource_group.main.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.external_dns_managed_identity.principal_id

  depends_on = [
    module.kubernetes
  ]
}

resource "azurerm_user_assigned_identity" "external_dns_managed_identity" {
  name                = format("external-dns-%s", var.name)
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
}

resource "azurerm_federated_identity_credential" "external_dns_zone_access" {
  name                = format("external-dns-zone-access-%s", var.name)
  resource_group_name = data.azurerm_resource_group.main.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = data.azurerm_kubernetes_cluster.main.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.external_dns_managed_identity.id
  subject             = "system:serviceaccount:external-dns:external-dns"

  depends_on = [
    azurerm_user_assigned_identity.external_dns_managed_identity
  ]
}



##### Cert Manager
resource "azurerm_role_assignment" "cert_manager_dns_zone_contributor" {
  scope                = module.dns_zone.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.cert_manager_managed_identity.principal_id

  depends_on = [
    module.kubernetes
  ]
}

resource "azurerm_user_assigned_identity" "cert_manager_managed_identity" {
  name                = format("cert-manager-%s", var.name)
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
}

resource "azurerm_federated_identity_credential" "cert_manager_zone_access" {
  name                = format("cert-manager-zone-access-%s", var.name)
  resource_group_name = data.azurerm_resource_group.main.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = data.azurerm_kubernetes_cluster.main.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.cert_manager_managed_identity.id
  subject             = "system:serviceaccount:cert-manager:cert-manager"

  depends_on = [
    azurerm_user_assigned_identity.cert_manager_managed_identity
  ]
}



##### External Secrets Operator
resource "azurerm_role_assignment" "external_secrets_operator_key_vault_officer" {

  scope                = module.key_vault.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = azurerm_user_assigned_identity.external_secrets_operator_managed_identity.principal_id

  depends_on = [
    module.key_vault
  ]
}


resource "azurerm_user_assigned_identity" "external_secrets_operator_managed_identity" {
  name                = format("external-secrets-operator-%s", var.name)
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
}


resource "azurerm_federated_identity_credential" "argocd_key_vault_access" {
  name                = format("argocd-key-vault-access-%s", var.name)
  resource_group_name = data.azurerm_resource_group.main.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = data.azurerm_kubernetes_cluster.main.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.external_secrets_operator_managed_identity.id
  subject             = "system:serviceaccount:argocd:external-secrets"

  depends_on = [
    azurerm_user_assigned_identity.external_secrets_operator_managed_identity
  ]
}

resource "azurerm_federated_identity_credential" "app_1_vault_access" {
  name                = format("app-1-key-vault-access-%s", var.name)
  resource_group_name = data.azurerm_resource_group.main.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = data.azurerm_kubernetes_cluster.main.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.external_secrets_operator_managed_identity.id
  subject             = "system:serviceaccount:app-1:external-secrets"

  depends_on = [
    azurerm_user_assigned_identity.external_secrets_operator_managed_identity
  ]
}
