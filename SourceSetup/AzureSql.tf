# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = var.sourcergname
  location = var.sourcergloc
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    environment = var.env
  }
}

resource "azurerm_mssql_server" "example" {
  name                         = "${lower(var.sourcergname)}sqlserver427371"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = var.serverloc
  version                      = "12.0"
  administrator_login          = var.servercred[0]
  administrator_login_password = var.servercred[1]
  
  azuread_administrator {
    login_username = azurerm_user_assigned_identity.example.name
    object_id      = azurerm_user_assigned_identity.example.principal_id
  }
  tags = {
    environment = var.env
  }
}

resource "azurerm_mssql_firewall_rule" "example" {
  name             = "FirewallRule1"
  server_id        = azurerm_mssql_server.example.id
  start_ip_address = var.myip
  end_ip_address   = var.myip
}

resource "azurerm_mssql_firewall_rule" "FirewallRule2" {
  name             = "FirewallRule2"
  server_id        = azurerm_mssql_server.example.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_role_assignment" "sql_adf" {
  scope                = azurerm_mssql_server.example.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.example.principal_id
}

resource "azurerm_mssql_database" "example" {
  for_each = var.databasenames
  name           = each.key
  server_id      = azurerm_mssql_server.example.id
  max_size_gb  = 2
  sku_name     = "S0"
  tags = {
    environment = var.env
  }
  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "null_resource" "apply_schema" {
  depends_on = [azurerm_mssql_database.example]

  provisioner "local-exec" {
    command = <<EOT
      for db in ${join(" ", var.databasenames)}; do
        /opt/homebrew/bin/sqlcmd -S ${azurerm_mssql_server.example.fully_qualified_domain_name} \
               -U ${azurerm_mssql_server.example.administrator_login} \
               -P ${azurerm_mssql_server.example.administrator_login_password} \
               -d "$db" -i "schema_$db.sql";
      done
    EOT
  }
}



