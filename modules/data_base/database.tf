resource "azurerm_mysql_flexible_server" "mysql-flexible-iship-178-001" {
  name                   = "iship-178-001-fs"
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = "psqladmin"
  administrator_password = "Apri2k25!"
  backup_retention_days  = 7
  delegated_subnet_id    = var.subnet_id
  private_dns_zone_id    = var.pdns_zone_id
  sku_name               = "GP_Standard_D2ds_v4"

  depends_on = [ var.pdns_zone ]
}