# Módulo del servicio de órdenes
# Superficie de práctica: el estudiante debe implementar la lógica del módulo

provider "aws" {
  alias  = "primary"
  region = var.aws_region
}

provider "aws" {
  alias  = "secondary"
  region = var.aws_secondary_region
}

module "orders_service" {
  source = "./modules/orders_service"

  service_name            = var.orders_service_name
  environment             = var.environment
  dynamodb_read_capacity  = 5
  dynamodb_write_capacity = 5
  sqs_delay_seconds       = 0
  lambda_timeout          = 30
  lambda_memory_size      = 256
  lambda_runtime          = "python3.12"
  lambda_function_name    = var.lambda_function_name
  aws_region              = var.aws_region
  tags                    = {}
}