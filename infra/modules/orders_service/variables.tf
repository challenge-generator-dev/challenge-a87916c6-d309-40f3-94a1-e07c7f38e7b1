# Variables específicas para el módulo del servicio de órdenes
# Estas variables permiten configurar los recursos del módulo.
# SUPERFICIE DE PRÁCTICA: El estudiante debe definir las variables necesarias.

variable "service_name" {
  description = "Nombre del servicio de órdenes"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, prod, etc.)"
  type        = string
}

variable "dynamodb_read_capacity" {
  description = "Capacidad de lectura para la tabla DynamoDB"
  type        = number
}

variable "dynamodb_write_capacity" {
  description = "Capacidad de escritura para la tabla DynamoDB"
  type        = number
}

variable "sqs_delay_seconds" {
  description = "Retraso en segundos para mensajes en la cola SQS"
  type        = number
}

variable "lambda_timeout" {
  description = "Tiempo máximo de ejecución para la función Lambda en segundos"
  type        = number
}

variable "lambda_memory_size" {
  description = "Memoria asignada a la función Lambda en MB"
  type        = number
}

variable "lambda_runtime" {
  description = "Runtime para la función Lambda (ej: python3.8, nodejs14.x)"
  type        = string
}

variable "tags" {
  description = "Tags para aplicar a los recursos"
  type        = map(string)
  default     = {}
}

variable "lambda_function_name" {
  description = "Nombre de la función Lambda que procesa las órdenes"
  type        = string
}

variable "aws_region" {
  description = "Región de AWS donde se aprovisionarán los recursos"
  type        = string
}