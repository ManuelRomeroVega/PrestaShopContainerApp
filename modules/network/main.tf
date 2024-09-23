## Virtual network y subredes

resource "azurerm_virtual_network" "vn-iship-178-001" {
  name                = "vn-iship-178-001"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "sub-pub-iship-178-001" {
  name                 = "sub-pub-iship-178-001"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.location
  address_prefixes     = ["10.0.2.0/24"]

}

resource "azurerm_subnet" "sub-priv-iship-178-001" {
  name                  = "sub-priv-iship-178-001"
  resource_group_name   = var.resource_group_name
  virtual_network_name  = azurerm_virtual_network.vn-iship-178-001.name
  address_prefixes      = ["10.0.1.0/24"]
  service_endpoints     = ["Microsoft.Storage"]
  delegation {
    name                   = "fs"
    service_delegation {
      name                 = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_public_ip" "public_ip-iship-178-001" {
  name                = "pip-iship-178-00"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

## Reglas del firewall de l subred pública

resource "azurerm_firewall" "firewall-iship-178-001" {
  name                = "firewall-iship-178-001"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.sub-pub-iship-178-001.id
    public_ip_address_id = azurerm_public_ip.public_ip-iship-178-001.id
  }
}

# Recursos necesarios para la Base de Datos

resource "azurerm_private_dns_zone" "private-dns-zone-iship-178-001" {
  name                = "iship178.mysql.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "pdns-net-link-iship-178-001" {
  name                  = "iship178VnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.private-dns-zone-iship-178-001.name
  virtual_network_id    = azurerm_virtual_network.vn-iship-178-001.id
  resource_group_name   = var.resource_group_name
}