variable "location" {
  type = string
  description = "Localizacion"
}
variable "resource_group_name" {
  type = string
  description = "Nombre del grupo de recursos"
}
variable "subnet_id" {
  type = string
  description = "Id de la subnet"
}
variable "pdns_zone_id" {
  type = string
  description = "Id de la zona DNS Privada"
}

variable "pdns_zone" {
  type = string
  description = "Recurso DNS Zone"
}