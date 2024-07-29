# DNS
azure_cloud_zone = "<your-domain>"

# Kubernetes
kubernetes_version        = "1.29.4"
orchestrator_version      = "1.29.4"
name                      = "<replace-me>-development"
node_pool_count           = "3"
vm_size                   = "Standard_B4ms"
local_account_disabled    = true
load_balancer_sku         = "standard"
admin_list                = []
oidc_issuer_enabled       = true
workload_identity_enabled = true


# Key Vault
key_vault_name             = "<key-vault-name>"
key_vault_admin_object_ids = []

# Tags
tags = {
  TF-Managed  = "true"
  Environment = "development"
}
