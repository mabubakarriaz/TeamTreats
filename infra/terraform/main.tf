provider "azurerm" {
  features {}
  skip_provider_registration = true
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "1-8afab751-playground-sandbox"
}

output "vnet_id" {
  value = azurerm_virtual_network.example.id
}
