module "dynamodb" {
  source       = "./modules/dynamodb"
  project_name = var.project_name
  environment  = var.environment
}

module "api" {
  source                       = "./modules/api"
  project_name                 = var.project_name
  environment                  = var.environment
  lambda_runtime               = var.lambda_runtime
  lambda_timeout_seconds       = var.lambda_timeout_seconds
  api_lambda_package_path      = var.api_lambda_package_path
  advancer_lambda_package_path = var.advancer_lambda_package_path
  dynamodb_table_name          = module.dynamodb.table_name
}

module "events" {
  source               = "./modules/events"
  project_name         = var.project_name
  environment          = var.environment
  advancer_lambda_arn  = module.api.advancer_lambda_arn
  advancer_lambda_name = module.api.advancer_lambda_name
}

module "frontend" {
  source       = "./modules/frontend"
  project_name = var.project_name
  environment  = var.environment
  region       = var.region
}
