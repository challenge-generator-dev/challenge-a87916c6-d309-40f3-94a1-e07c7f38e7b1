# STUB: Outputs del módulo del servicio de órdenes
# Superficie de práctica - el estudiante definirá los outputs necesarios

output "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB de órdenes"
  value       = aws_dynamodb_table.orders.name
}

output "dynamodb_table_arn" {
  description = "ARN de la tabla DynamoDB de órdenes"
  value       = aws_dynamodb_table.orders.arn
}

output "dynamodb_table_stream_arn" {
  description = "ARN del stream de DynamoDB para procesamiento de eventos"
  value       = aws_dynamodb_table.orders.stream_arn
  depends_on  = [aws_dynamodb_table.orders]
}

output "sqs_queue_url" {
  description = "URL de la cola SQS de órdenes"
  value       = aws_sqs_queue.orders_queue.url
}

output "sqs_queue_arn" {
  description = "ARN de la cola SQS de órdenes"
  value       = aws_sqs_queue.orders_queue.arn
}

output "sqs_dlq_url" {
  description = "URL de la cola SQS dead letter"
  value       = aws_sqs_queue.orders_dlq.url
}

output "sqs_dlq_arn" {
  description = "ARN de la cola SQS dead letter"
  value       = aws_sqs_queue.orders_dlq.arn
}

output "lambda_function_name" {
  description = "Nombre de la función Lambda"
  value       = aws_lambda_function.orders_processor.function_name
}

output "lambda_function_arn" {
  description = "ARN de la función Lambda"
  value       = aws_lambda_function.orders_processor.arn
}

output "lambda_role_name" {
  description = "Nombre del rol de ejecución de Lambda"
  value       = aws_iam_role.lambda_exec.name
}

output "lambda_role_arn" {
  description = "ARN del rol de ejecución de Lambda"
  value       = aws_iam_role.lambda_exec.arn
}

output "api_gateway_rest_api_id" {
  description = "ID de la API REST de API Gateway"
  value       = aws_api_gateway_rest_api.orders_api.id
}

output "api_gateway_rest_api_arn" {
  description = "ARN de la API REST de API Gateway"
  value       = aws_api_gateway_rest_api.orders_api.arn
}

output "api_gateway_execution_arn" {
  description = "ARN de ejecución de API Gateway"
  value       = aws_api_gateway_rest_api.orders_api.execution_arn
}

output "api_gateway_endpoint" {
  description = "Endpoint de la API Gateway"
  value       = aws_api_gateway_rest_api.orders_api.execution_arn
}

output "orders_resource_id" {
  description = "ID del recurso /orders en API Gateway"
  value       = aws_api_gateway_resource.orders.id
}

output "order_by_id_resource_id" {
  description = "ID del recurso /orders/{order_id} en API Gateway"
  value       = aws_api_gateway_resource.order_by_id.id
}

output "authorizer_id" {
  description = "ID del autorizador de API Gateway"
  value       = aws_api_gateway_authorizer.orders_authorizer.id
}