
resource "azurerm_key_vault_secret" "url" {
  name         = "url"
  value        = "https://linkedin.com/in/lajko"
  key_vault_id = module.key_vault.id

  depends_on = [
    module.key_vault
  ]

}
