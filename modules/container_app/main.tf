# Recursos necesarios para la Aplicación Contenedora

resource "azurerm_log_analytics_workspace" "log-iship-178-001" {
  name                = "log-iship-178-001"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_container_app_environment" "env-iship-178-001" {
  name                       = "env-iship-178-001"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log-iship-178-001.id
}

# Recurso de la Aplicación Contenedora

resource "azurerm_container_app" "app-iship-178-001" {
  name                         = "app-iship-178-001"
  container_app_environment_id = azurerm_container_app_environment.env-iship-178-001.id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  registry {
    server                  = "containerregistryiship178001.azurecr.io"
    username                = "containerregistryiship178001"
    password_secret_name    = "registry-username"
  }

  ingress {
    allow_insecure_connections = true
    external_enabled           = true
    target_port                = 80
    transport                  = "http"
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  template {
    container {
      name   = "presta-app-iship-178-001"
      image  = "prestashop:latest"
      cpu    = 2
      memory = "4Gi"
    }
  }

  secret {
    name  = "registry-username"
    value = "secret-key-value-here"
  }
}
