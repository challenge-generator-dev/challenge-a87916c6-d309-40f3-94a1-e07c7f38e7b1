output "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB"
  value       = module.orders_service.dynamodb_table_name
}

output "dynamodb_table_arn" {
  description = "ARN de la tabla DynamoDB"
  value       = module.orders_service.dynamodb_table_arn
}

output "sqs_queue_url" {
  description = "URL de la cola SQS principal"
  value       = module.orders_service.sqs_queue_url
}

output "sqs_queue_arn" {
  description = "ARN de la cola SQS principal"
  value       = module.orders_service.sqs_queue_arn
}

output "lambda_function_name" {
  description = "Nombre de la función Lambda"
  value       = module.orders_service.lambda_function_name
}

output "lambda_function_arn" {
  description = "ARN de la función Lambda"
  value       = module.orders_service.lambda_function_arn
}

output "api_gateway_endpoint" {
  description = "Endpoint de la API REST"
  value       = module.orders_service.api_gateway_endpoint
}

output "api_gateway_rest_api_id" {
  description = "ID de la API REST"
  value       = module.orders_service.api_gateway_rest_api_id
}