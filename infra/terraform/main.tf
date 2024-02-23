terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.87.0"
    }
  }
}

provider "azurerm" {
  features {}

  skip_provider_registration = true

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

data "azurerm_subscription" "current" {
}

data "azurerm_resource_group" "tf-rg-tt-01" {
  name = var.rg_name
}

resource "azurerm_network_security_group" "tf-nsg-tt-01" {
  name                = "nsg-tt-01-${terraform.workspace}"
  location            = data.azurerm_resource_group.tf-rg-tt-01.location
  resource_group_name = var.rg_name
  tags = {
    environment = "${terraform.workspace}"
    project     = var.proj_name
  }
}

resource "azurerm_virtual_network" "tf-vnet-tt-01" {
  name                = "vnet-tt-01-${terraform.workspace}"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.tf-rg-tt-01.location
  resource_group_name = data.azurerm_resource_group.tf-rg-tt-01.name
  tags = {
    environment = "${terraform.workspace}"
    project     = var.proj_name
  }
}

resource "azurerm_subnet" "tf-snet-tt-01" {
  name                 = "snet-tt-01-${terraform.workspace}"
  address_prefixes     = ["10.0.1.0/24"]
  resource_group_name  = data.azurerm_resource_group.tf-rg-tt-01.name
  virtual_network_name = azurerm_virtual_network.tf-vnet-tt-01.name

}

resource "azurerm_subnet_network_security_group_association" "tf-nsga-tt-vnet01snet01-01" {
  subnet_id                 = azurerm_subnet.tf-snet-tt-01.id
  network_security_group_id = azurerm_network_security_group.tf-nsg-tt-01.id
}

output "current_subscription" {
  value = data.azurerm_subscription.current.display_name
}

output "current_region" {
  value = data.azurerm_resource_group.tf-rg-tt-01.location
}
