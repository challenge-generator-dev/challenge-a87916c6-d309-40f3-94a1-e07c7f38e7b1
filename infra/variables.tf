# Definición de variables globales para la infraestructura
# Estas variables se utilizan para parametrizar los scripts de Terraform.
# SUPERFICIE DE PRÁCTICA: El estudiante debe completar las descripciones y valores por defecto.

variable "aws_region" {
  description = "Región principal de AWS donde se aprovisionarán los recursos"
  type        = string
  # default     = "us-east-1"
}

variable "aws_secondary_region" {
  description = "Región secundaria de AWS para recursos multi-región"
  type        = string
  # default     = "us-west-2"
}

variable "environment" {
  description = "Entorno de despliegue (dev, prod, etc.)"
  type        = string
  # default     = "dev"
}

variable "orders_service_name" {
  description = "Nombre del servicio de órdenes para nombrar recursos"
  type        = string
  # default     = "orders-service"
}

variable "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB para órdenes"
  type        = string
  # default     = "orders-table"
}

variable "sqs_queue_name" {
  description = "Nombre de la cola SQS para eventos de órdenes"
  type        = string
  # default     = "orders-events-queue"
}

variable "lambda_function_name" {
  description = "Nombre de la función Lambda para procesar órdenes"
  type        = string
  # default     = "process-order"
}