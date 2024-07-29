output "oidc_url" {
  value       = module.kubernetes.oidc_issuer_url
  description = "value of the oidc url"
}

output "external_secrets_operator_managed_identity_principal_id" {
  value       = azurerm_user_assigned_identity.external_secrets_operator_managed_identity.principal_id
  description = "value of the external secrets operator managed identity principal id"
}


output "external_secrets_operator_managed_identity_client_id" {
  value       = azurerm_user_assigned_identity.external_secrets_operator_managed_identity.client_id
  description = "value of the external secrets operator managed identity principal id"
}


output "external_dns_managed_identity_principal_id" {
  value       = azurerm_user_assigned_identity.external_dns_managed_identity.principal_id
  description = "value of the external dns managed identity principal id"
}

output "external_dns_managed_identity_client_id" {
  value       = azurerm_user_assigned_identity.external_dns_managed_identity.client_id
  description = "value of the external dns managed identity principal id"
}

output "cert_manager_managed_identity_principal_id" {
  value       = azurerm_user_assigned_identity.cert_manager_managed_identity.principal_id
  description = "value of the cert manager managed identity principal id"
}

output "cert_manager_managed_identity_client_id" {
  value       = azurerm_user_assigned_identity.cert_manager_managed_identity.client_id
  description = "value of the cert manager managed identity principal id"
}
