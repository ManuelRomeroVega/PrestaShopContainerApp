resource "azurerm_resource_group" "rg-iship-178-001" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location

  depends_on          = [ azurerm_resource_group.rg-iship-178-001 ]
}

module "container_app" {
  source              = "./modules/container_app"
  resource_group_name = var.resource_group_name
  location            = var.location

  depends_on          = [ module.network ]
}

module "data_base" {
  source               = "./modules/data_base"
  resource_group_name  = var.resource_group_name
  location             = var.location
  subnet_id            = module.network.subnet_id
  pdns_zone_id         = module.network.private_dns_zone_id
  pdns_zone            = module.network.private_dns_zone

  depends_on           = [ module.container_app ]
}