# STUB: Módulo de Terraform para el servicio de órdenes
# Superficie de práctica - el estudiante implementará la lógica

# DynamoDB Table
resource "aws_dynamodb_table" "orders" {
  name         = var.service_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "order_id"
  range_key    = "customer_id"

  attribute {
    name = "order_id"
    type = "S"
  }

  attribute {
    name = "customer_id"
    type = "S"
  }

  attribute {
    name = "status"
    type = "S"
  }

  attribute {
    name = "created_at"
    type = "N"
  }

  global_secondary_index {
    name            = "status_created_at_index"
    hash_key        = "status"
    range_key       = "created_at"
    projection_type = "ALL"
  }

  ttl {
    attribute_name = "expires_at"
    enabled        = true
  }

  tags = merge(var.tags, {
    Name        = var.service_name
    Environment = var.environment
    ManagedBy   = "terraform"
  })
}

# SQS Queue for order processing
resource "aws_sqs_queue" "orders_queue" {
  name                      = "${var.service_name}-queue"
  delay_seconds             = var.sqs_delay_seconds
  max_message_size          = 262144
  message_retention_seconds = 345600
  receive_wait_time_seconds = 20

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.orders_dlq.arn
    maxReceiveCount     = 5
  })

  tags = merge(var.tags, {
    Name        = "${var.service_name}-queue"
    Environment = var.environment
  })
}

# SQS Dead Letter Queue
resource "aws_sqs_queue" "orders_dlq" {
  name                      = "${var.service_name}-dlq"
  max_message_size          = 262144
  message_retention_seconds = 1209600

  tags = merge(var.tags, {
    Name        = "${var.service_name}-dlq"
    Environment = var.environment
  })
}

# Lambda Function
resource "aws_lambda_function" "orders_processor" {
  filename         = "../../lambda/orders_processor.zip"
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_exec.arn
  handler          = "orders_processor.handler"
  source_code_hash = filebase64sha256("../../lambda/orders_processor.zip")

  runtime     = var.lambda_runtime
  timeout     = var.lambda_timeout
  memory_size = var.lambda_memory_size

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.orders.name
      SQS_QUEUE_URL  = aws_sqs_queue.orders_queue.url
      ENVIRONMENT    = var.environment
    }
  }

  tags = merge(var.tags, {
    Name        = var.lambda_function_name
    Environment = var.environment
  })

  depends_on = [aws_iam_role_policy_attachment.lambda_dynamodb, aws_iam_role_policy_attachment.lambda_sqs]
}

# Lambda Execution Role
resource "aws_iam_role" "lambda_exec" {
  name = "${var.service_name}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(var.tags, {
    Name        = "${var.service_name}-lambda-role"
    Environment = var.environment
  })
}

# Lambda DynamoDB Policy Attachment
resource "aws_iam_role_policy_attachment" "lambda_dynamodb" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_dynamodb_policy.arn
}

# Lambda SQS Policy Attachment
resource "aws_iam_role_policy_attachment" "lambda_sqs" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_sqs_policy.arn
}

# Lambda DynamoDB Policy
resource "aws_iam_policy" "lambda_dynamodb_policy" {
  name        = "${var.service_name}-lambda-dynamodb"
  description = "Permite acceso a DynamoDB para el procesamiento de órdenes"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = [
          aws_dynamodb_table.orders.arn,
          "${aws_dynamodb_table.orders.arn}/index/*"
        ]
      }
    ]
  })

  tags = merge(var.tags, {
    Name        = "${var.service_name}-lambda-dynamodb"
    Environment = var.environment
  })
}

# Lambda SQS Policy
resource "aws_iam_policy" "lambda_sqs_policy" {
  name        = "${var.service_name}-lambda-sqs"
  description = "Permite acceso a SQS para procesamiento de órdenes"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = aws_sqs_queue.orders_queue.arn
      },
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = aws_sqs_queue.orders_dlq.arn
      }
    ]
  })

  tags = merge(var.tags, {
    Name        = "${var.service_name}-lambda-sqs"
    Environment = var.environment
  })
}

# API Gateway REST API
resource "aws_api_gateway_rest_api" "orders_api" {
  name        = var.service_name
  description = "API Gateway para el servicio de órdenes"

  tags = merge(var.tags, {
    Name        = var.service_name
    Environment = var.environment
  })
}

# API Gateway Resource - Orders
resource "aws_api_gateway_resource" "orders" {
  rest_api_id = aws_api_gateway_rest_api.orders_api.id
  parent_id   = aws_api_gateway_rest_api.orders_api.root_resource_id
  path_part   = "orders"
}

# API Gateway Method - GET /orders
resource "aws_api_gateway_method" "orders_get" {
  rest_api_id   = aws_api_gateway_rest_api.orders_api.id
  resource_id   = aws_api_gateway_resource.orders.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.orders_authorizer.id

  request_parameters = {
    "method.request.header.Authorization" = true
  }
}

# API Gateway Method - POST /orders
resource "aws_api_gateway_method" "orders_post" {
  rest_api_id   = aws_api_gateway_rest_api.orders_api.id
  resource_id   = aws_api_gateway_resource.orders.id
  http_method   = "POST"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.orders_authorizer.id

  request_parameters = {}

  request_models = {
    "application/json" = "OrderRequest"
  }
}

# API Gateway Resource - Order by ID
resource "aws_api_gateway_resource" "order_by_id" {
  rest_api_id = aws_api_gateway_rest_api.orders_api.id
  parent_id   = aws_api_gateway_resource.orders.id
  path_part   = "{order_id}"
}

# API Gateway Method - GET /orders/{order_id}
resource "aws_api_gateway_method" "order_by_id_get" {
  rest_api_id   = aws_api_gateway_rest_api.orders_api.id
  resource_id   = aws_api_gateway_resource.order_by_id.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.orders_authorizer.id

  request_parameters = {
    "method.request.path.order_id" = true
  }
}

# API Gateway Method - PUT /orders/{order_id}
resource "aws_api_gateway_method" "order_by_id_put" {
  rest_api_id   = aws_api_gateway_rest_api.orders_api.id
  resource_id   = aws_api_gateway_resource.order_by_id.id
  http_method   = "PUT"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.orders_authorizer.id

  request_parameters = {
    "method.request.path.order_id" = true
  }

  request_models = {
    "application/json" = "OrderUpdateRequest"
  }
}

# API Gateway Method - DELETE /orders/{order_id}
resource "aws_api_gateway_method" "order_by_id_delete" {
  rest_api_id   = aws_api_gateway_rest_api.orders_api.id
  resource_id   = aws_api_gateway_resource.order_by_id.id
  http_method   = "DELETE"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.orders_authorizer.id

  request_parameters = {
    "method.request.path.order_id" = true
  }
}

# API Gateway Authorizer
resource "aws_api_gateway_authorizer" "orders_authorizer" {
  name                   = "orders-authorizer"
  rest_api_id            = aws_api_gateway_rest_api.orders_api.id
  authorizer_uri         = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.orders_processor.arn}/invocations"
  authorizer_credentials = aws_iam_role.api_gateway_authorizer.arn
  type                   = "TOKEN"
  identity_source        = "method.request.header.Authorization"
}

# API Gateway Authorizer Role
resource "aws_iam_role" "api_gateway_authorizer" {
  name = "${var.service_name}-api-gw-authorizer-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      }
    ]
  })
}

# Lambda Permission for API Gateway
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.orders_processor.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.orders_api.execution_arn}/*/*"
}

# SQS Lambda Event Source Mapping
resource "aws_lambda_event_source_mapping" "orders_sqs" {
  event_source_arn = aws_sqs_queue.orders_queue.arn
  function_name    = aws_lambda_function.orders_processor.function_name
  batch_size       = 10
  enabled          = true
}