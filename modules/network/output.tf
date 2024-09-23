output "subnet_id" {
  value = azurerm_subnet.sub-priv-iship-178-001.id
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.private-dns-zone-iship-178-001.id
}

output "private_dns_zone" {
  value = azurerm_private_dns_zone.private-dns-zone-iship-178-001
}