locals {
  common_tags = {
    "ManagedBy"  = "terraform"
    "Environment" = "dev"
    "Project"     = "todoapp"
  }
}


module "rg" {
  source      = "../../modules/azurerm_resource_group"
  rg_name     = "rg-dev-todoapp"
  rg_location = "centralindia"
  tags        = local.common_tags
}

module "acr" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_container_registry"
  acr_name   = "acrdevtodoapp"
  location   = "centralindia"
  rg_name    = "rg-dev-todoapp"
  tags       = local.common_tags
}

module "sql_server" {
  depends_on      = [module.rg]
  source          = "../../modules/azurerm_sql_server"
  sql_server_name = "sqlserver-dev-todoapp"
  admin_user_name = "devopsadmin"
  admin_password  = "P@ssword@123"
  location        = "centralindia"
  rg_name         = "rg-dev-todoapp"
  tags            = local.common_tags
}

module "sql_db" {
  depends_on  = [module.sql_server]
  source      = "../../modules/azuterm_sql_database"
  sql_db_name = "sqldb-dev-todoapp"
  server_id   = module.sql_server.server_id
  max_size_gb = 2
  tags        = local.common_tags
}

module "aks" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_kubernetes_cluster"
  aks_name   = "aks-dev-todoapp"
  location   = "centralindia"
  rg_name    = "rg-dev-todoapp"
  dns_prefix = "aks-dev-todoapp"
  tags       = local.common_tags
}

