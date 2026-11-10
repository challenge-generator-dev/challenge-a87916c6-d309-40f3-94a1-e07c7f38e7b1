# Configuración de variables para el entorno de desarrollo
# Estos valores se cargan automáticamente al ejecutar terraform en este directorio

aws_region           = "us-east-1"
aws_secondary_region = "us-west-2"
environment          = "dev"
orders_service_name  = "orders-service"
dynamodb_table_name  = "orders-table-dev"
sqs_queue_name       = "orders-queue-dev"
lambda_function_name = "orders-handler-dev"

# Configuración de capacidad de DynamoDB
# Ajustar según necesidades de lectura/escritura del entorno
dynamodb_read_capacity  = 5
dynamodb_write_capacity = 5

# Configuración de SQS
# Delay seconds controla el tiempo que un mensaje permanece invisible
sqs_delay_seconds = 0

# Configuración de Lambda
# Timeout: tiempo máximo de ejecución en segundos
# Memory_size: memoria asignada en MB (afecta también CPU)
lambda_timeout     = 30
lambda_memory_size = 256
lambda_runtime     = "python3.12"

# Etiquetas para recursos
# Incluir environment, equipo, proyecto y cualquier otra etiqueta relevante
tags = {
  environment = "dev"
  team        = "orders-team"
  project     = "orders-service"
  cost_center = "engineering"
  managed_by  = "terraform"
  compliance  = "pci-ready"
}