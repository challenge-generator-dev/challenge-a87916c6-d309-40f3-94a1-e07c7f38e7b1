# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `infra/versions.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/orders_service/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/orders_service/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/orders_service/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/dev/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/prod/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `api` | `api/` | chapter, support | server | Java | - |

## Orden de arranque

1. `cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate` — componente `infra` (practice).
2. `cd api && mvn clean compile` — componente `api` (chapter, support).

### Contratos entre componentes

- `api` expone http (api: http://localhost:8080):
  - `POST /api/orders`
  - `GET /api/orders/{id}`

## Herramientas

- **Terraform**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).
- **Java**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `api/src/main/java/com/pragma/orders/application/OrderService.java` — `OrderItemResponseDTO`: OrderItemResponseDTO se usa en el cuerpo del archivo pero no esta importado. El proyecto lo declara en com.pragma.orders.application.dto.OrderItemResponseDTO.

## Como saber que terminaste

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd api && mvn clean compile)
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Backend, Especialidad Desarrollador, Tecnología Java, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform (corrida e2e 20261110141755634), Aprovisiona con Terraform la infraestructura AWS que necesita el servicio de ordenes

### Misión / candidato
Versionar la infraestructura del servicio

### Reto
- Tema: Infraestructura como codigo para el servicio de ordenes
- Seniority: senior-l2
- Tipo: practical
- Título: Versionado de Infraestructura con Terraform para el Servicio de Ordenes
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Exploración y Configuración Inicial — objetivo: Configurar el entorno de Terraform y comprender las necesidades del servicio de ordenes. — entregable (NO resolver): Documento de configuración inicial que detalla los componentes de AWS y las decisiones tomadas.
- Fase 2: Aprovisionamiento de Infraestructura — objetivo: Crear los scripts de Terraform para aprovisionar la infraestructura necesaria. — entregable (NO resolver): Scripts de Terraform que aprovisionan la infraestructura de AWS para el servicio de ordenes.
- Fase 3: Versionado y Gestión de Cambios — objetivo: Implementar un sistema de versionado para la infraestructura y gestionar cambios. — entregable (NO resolver): Repositorio de versionado con los scripts de Terraform y documentación del proceso de gestión de cambios.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: infra/providers.tf ===
# Configuración de providers para Terraform
# Este archivo declara los providers necesarios para aprovisionar la infraestructura en AWS.

terraform {
  required_version = "~> 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.60.0"
    }
  }
}

# Provider principal para AWS
provider "aws" {
  region = var.aws_region
}

// === ARCHIVO: infra/variables.tf ===
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

// === ARCHIVO: infra/modules/orders_service/variables.tf ===
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

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
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

// === ARCHIVO: infra/environments/dev/main.tf ===
# Stub - Superficie de práctica
# Este archivo debe ser completado por el participante

# TODO: Implementar configuración específica para el entorno de desarrollo
# Incluir overrides de variables, configuración de recursos específicos de dev,
# y cualquier ajuste necesario para el ambiente de desarrollo.

// === ARCHIVO: infra/environments/prod/main.tf ===
# Stub - Superficie de práctica
# Este archivo debe ser completado por el participante

# TODO: Implementar configuración específica para el entorno de producción
# Incluir overrides de variables, configuración de recursos específicos de prod,
# consideraciones de alta disponibilidad, y ajustes de rendimiento para producción.

// === ARCHIVO: infra/modules/orders_service/main.tf ===
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

// === ARCHIVO: infra/modules/orders_service/outputs.tf ===
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

// === ARCHIVO: infra/policies/iam_policy.json ===
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DynamoDBOrdersTableAccess",
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:DeleteItem",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:DescribeTable",
        "dynamodb:GetRecords",
        "dynamodb:GetShardIterator"
      ],
      "Resource": [
        "arn:aws:dynamodb:*:*:table/orders",
        "arn:aws:dynamodb:*:*:table/orders/index/*"
      ],
      "Description": "Permite operaciones CRUD completas sobre la tabla de órdenes y sus índices secundarios"
    },
    {
      "Sid": "SQSOrdersQueueAccess",
      "Effect": "Allow",
      "Action": [
        "sqs:SendMessage",
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
        "sqs:GetQueueUrl",
        "sqs:ListQueues",
        "sqs:PurgeQueue",
        "sqs:SetQueueAttributes"
      ],
      "Resource": [
        "arn:aws:sqs:*:*:orders-queue",
        "arn:aws:sqs:*:*:orders-dlq"
      ],
      "Description": "Permite enviar, recibir y eliminar mensajes de las colas principal y dead letter del servicio de órdenes"
    },
    {
      "Sid": "LambdaExecution",
      "Effect": "Allow",
      "Action": [
        "lambda:InvokeFunction",
        "lambda:GetFunction",
        "lambda:GetFunctionConfiguration",
        "lambda:UpdateFunctionConfiguration",
        "lambda:UpdateFunctionCode",
        "lambda:ListVersionsByFunction",
        "lambda:ListAliases"
      ],
      "Resource": [
        "arn:aws:lambda:*:*:function:orders-processor"
      ],
      "Description": "Permite invocar y gestionar la función Lambda de procesamiento de órdenes"
    },
    {
      "Sid": "APIGatewayExecution",
      "Effect": "Allow",
      "Action": [
        "apigateway:GET",
        "apigateway:POST",
        "apigateway:PUT",
        "apigateway:DELETE",
        "apigateway:PATCH",
        "apigateway:HEAD",
        "apigateway:OPTIONS",
        "apigateway:Invoke"
      ],
      "Resource": [
        "arn:aws:apigateway:*:/restapis/*",
        "arn:aws:apigateway:*:/restapis/*/resources/*",
        "arn:aws:apigateway:*:/restapis/*/resources/*/methods/*"
      ],
      "Description": "Permite gestionar y ejecutar la API REST del servicio de órdenes"
    },
    {
      "Sid": "CloudWatchLogs",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams",
        "logs:GetLogEvents",
        "logs:FilterLogEvents"
      ],
      "Resource": [
        "arn:aws:logs:*:*:log-group:/aws/lambda/orders-processor:*",
        "arn:aws:logs:*:*:log-group:/aws/apigateway/orders-api:*"
      ],
      "Description": "Permite escribir y consultar logs de CloudWatch para Lambda y API Gateway del servicio de órdenes"
    },
    {
      "Sid": "CloudWatchMetrics",
      "Effect": "Allow",
      "Action": [
        "cloudwatch:PutMetricData",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:ListMetrics"
      ],
      "Resource": "*",
      "Description": "Permite publicar métricas personalizadas de CloudWatch para el monitoreo del servicio de órdenes"
    },
    {
      "Sid": "X-RayTracing",
      "Effect": "Allow",
      "Action": [
        "xray:PutTraceSegments",
        "xray:PutTelemetryRecords",
        "xray:GetSamplingRules",
        "xray:GetSamplingTargets"
      ],
      "Resource": "*",
      "Description": "Permite habilitar tracing con AWS X-Ray para analizar el rendimiento del servicio de órdenes"
    },
    {
      "Sid": "KMSKeyAccess",
      "Effect": "Allow",
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:GenerateDataKey",
        "kms:DescribeKey",
        "kms:ReEncrypt*"
      ],
      "Resource": "arn:aws:kms:*:*:key/*",
      "Condition": {
        "StringEquals": {
          "kms:CallerAccount": "${data.aws_caller_identity.current.account_id}"
        },
        "StringLike": {
          "kms:ResourceTag/Service": "orders"
        }
      },
      "Description": "Permite cifrar y descifrar datos sensibles en la tabla DynamoDB usando claves KMS gestionadas por el servicio"
    },
    {
      "Sid": "EventBridgeEvents",
      "Effect": "Allow",
      "Action": [
        "events:PutEvents",
        "events:DescribeEventBus",
        "events:ListRules",
        "events:ListTargetsByRule"
      ],
      "Resource": [
        "arn:aws:events:*:*:event-bus/default",
        "arn:aws:events:*:*:rule/orders-*"
      ],
      "Description": "Permite publicar y consumir eventos de EventBridge para la arquitectura basada en eventos del servicio de órdenes"
    },
    {
      "Sid": "S3ArtifactsAccess",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket",
        "s3:GetBucketLocation"
      ],
      "Resource": [
        "arn:aws:s3:::orders-artifacts",
        "arn:aws:s3:::orders-artifacts/*"
      ],
      "Description": "Permite acceder al bucket S3 donde se almacenan artefactos y archivos del servicio de órdenes"
    },
    {
      "Sid": "SecHubReadOnly",
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeVpcs",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeInstances",
        "ec2:DescribeNetworkInterfaces"
      ],
      "Resource": "*",
      "Description": "Permite describir recursos de VPC para verificar la configuración de red del servicio de órdenes"
    },
    {
      "Sid": "DenyDeleteOrdersResources",
      "Effect": "Deny",
      "Action": [
        "dynamodb:DeleteTable",
        "sqs:DeleteQueue",
        "lambda:DeleteFunction",
        "apigateway:DeleteRestApi"
      ],
      "Resource": [
        "arn:aws:dynamodb:*:*:table/orders",
        "arn:aws:sqs:*:*:orders-queue",
        "arn:aws:sqs:*:*:orders-dlq",
        "arn:aws:lambda:*:*:function:orders-processor",
        "arn:aws:apigateway:*:/restapis/*"
      ],
      "Condition": {
        "StringNotEquals": {
          "aws:PrincipalTag/Environment": "prod"
        }
      },
      "Description": "Impide la eliminación de recursos críticos del servicio de órdenes excepto en entorno de producción"
    }
  ]
}

// === ARCHIVO: infra/README.md ===
# Infraestructura como Código - Servicio de Órdenes

Este proyecto contiene la definición de infraestructura AWS para el servicio de órdenes utilizando Terraform. La arquitectura implementa un patrón modular que permite la reutilización de componentes y la separación clara entre entornos.

## Componentes de AWS Identificados

### Amazon DynamoDB
Tabla principal para almacenamiento de órdenes con las siguientes características:
- Modo de capacidad bajo demanda o aprovisionado
- Clave primaria: `order_id` (UUID)
- Índice secundario global `customer_id-index` para consultas por cliente
- Clave de ordenación `created_at` para ordenamiento temporal
- TTL habilitado en campo `expires_at` para limpieza automática
- Capacidades de lectura/escritura configurables

### Amazon SQS (Simple Queue Service)
Cola de mensajes para procesamiento asíncrono de órdenes:
- Nombre configurable mediante variable
- Retraso configurable (`delay_seconds`) para control de flujo
- Retención de mensajes de 4 días por defecto
- Cifrado en reposo con KMS
- Política de acceso restrictiva

### AWS Lambda
Funciónserverless para procesamiento de eventos de órdenes:
- Runtime configurable (nodejs20.x, python3.12, etc.)
- Timeout y memoria ajustables
- Variables de entorno para configuración
- Permisos IAM necesarios para DynamoDB y SQS
- Configuración de concurrencia si es necesario

### Amazon API Gateway (preparado para integración)
El módulo de Lambda está preparado para integración futura con API Gateway, exponiendo el ARN de la función para facilitar la configuración del trigger.

## Decisiones de Arquitectura

### Separación de Entornos
La estructura utiliza directorios separados para cada entorno (`environments/dev/`, `environments/prod/`), lo que permite:
- Aislamiento completo de recursos entre entornos
- Variables específicas por entorno en archivos `terraform.tfvars`
- Posibilidad de aplicar cambios de forma independiente
- Control de acceso diferenciado por entorno

### Módulos Reutilizables
El patrón de módulos permite:
- Abstracción de la infraestructura compleja
- Parámetros configurables mediante variables
- Salidas estandarizadas para consumo por otros módulos
- Testing individual de cada módulo
- Versionado semántico de módulos

### Seguridad Implementada
- Principio de mínimo privilegio en políticas IAM
- Cifrado en reposo para todos los servicios que lo soportan
- Variables sensibles marked como `sensitive`
- Políticas de acceso explícitas
- Tags obligatorios para trazabilidad

## Estructura del Proyecto

```
infra/
├── main.tf                    # Configuración principal que orquesta módulos
├── versions.tf                # Definición de versiones de Terraform y proveedores
├── providers.tf               # Configuración de proveedores AWS
├── variables.tf               # Variables globales del proyecto
├── outputs.tf                 # Outputs globales del proyecto
├── modules/
│   └── orders_service/        # Módulo reutilizable para el servicio
│       ├── main.tf            # Recursos del módulo
│       ├── variables.tf       # Variables del módulo
│       └── outputs.tf         # Salidas del módulo
├── environments/
│   ├── dev/                   # Entorno de desarrollo
│   │   ├── main.tf
│   │   └── terraform.tfvars
│   └── prod/                  # Entorno de producción
│       ├── main.tf
│       └── terraform.tfvars
└── policies/
    └── iam_policy.json        # Políticas IAM predefinidas
```

## Restricciones y Consideraciones

### Límites de AWS a Considerar
- Límites regionales por defecto: 250 tablas DynamoDB por región
- Cuotas de Lambda: 1000 concurrencia por región (ajustable)
- SQS: máximo 120,000 mensajes en vuelo por cola
- API Gateway: 10,000 solicitudes por segundo por región

### Costos Estimados
Los costos dependen del entorno y uso:
- **Dev**: Entorno de desarrollo típicamente usa capacidad bajo demanda
- **Prod**: Requiere planificación de capacidad y reservas para optimización

### Buenas Prácticas Incluidas
- State remoto recomendado para trabajo en equipo (S3 con DynamoDB para locking)
- Habilitar el logging de todos los servicios
- Usar tags consistentes en todos los recursos
- Implementar pipelines de CI/CD para cambios de infraestructura
- Revisiones obligatorias de código para cambios en Terraform

## Uso del Módulo Orders Service

### Integración en Entorno
```hcl
module "orders_service" {
  source = "../modules/orders_service"
  
  service_name             = "orders"
  environment              = "dev"
  dynamodb_read_capacity   = 5
  dynamodb_write_capacity  = 5
  sqs_delay_seconds        = 0
  lambda_timeout           = 30
  lambda_memory_size       = 256
  lambda_runtime           = "nodejs20.x"
  tags                     = {
    Team     = "Platform"
    Project  = "OrderService"
  }
}
```

### Outputs Disponibles
- `dynamodb_table_arn`: ARN de la tabla DynamoDB
- `dynamodb_table_name`: Nombre de la tabla
- `sqs_queue_url`: URL de la cola SQS
- `sqs_queue_arn`: ARN de la cola SQS
- `lambda_function_arn`: ARN de la función Lambda
- `lambda_function_name`: Nombre de la función

## Siguientes Pasos

1. **Configurar credenciales AWS** en el entorno local
2. **Inicializar Terraform** con `terraform init`
3. **Validar configuración** con `terraform validate`
4. **Planificar cambios** con `terraform plan`
5. **Aplicar infraestructura** con `terraform apply`

## Notas Pedagógicas

Este proyecto forma parte de un ejercicio de versionado de infraestructura. Los archivos de configuración están estructurados para demostrar:
- Modularización de infraestructura
- Separación de entornos
- Principios de seguridad en IaC
- Gestión de estado remoto
- Drift detection y gestión de cambios

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.9.0"

}

// === ARCHIVO: infra/main.tf ===
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

// === ARCHIVO: infra/outputs.tf ===
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

// === ARCHIVO: api/pom.xml ===
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.5.6</version>
        <relativePath/>
    </parent>

    <groupId>com.pragma</groupId>
    <artifactId>orders</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>orders</name>
    <description>Servicio de órdenes con infraestructura AWS</description>

    <properties>
        <java.version>21</java.version>
        <aws.sdk.version>2.25.25</aws.sdk.version>
        <lombok.version>1.18.34</lombok.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>software.amazon.awssdk</groupId>
            <artifactId>dynamodb</artifactId>
            <version>${aws.sdk.version}</version>
        </dependency>
        <dependency>
            <groupId>software.amazon.awssdk</groupId>
            <artifactId>sqs</artifactId>
            <version>${aws.sdk.version}</version>
        </dependency>
        <dependency>
            <groupId>software.amazon.awssdk</groupId>
            <artifactId>lambda</artifactId>
            <version>${aws.sdk.version}</version>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>${lombok.version}</version>
            <scope>provided</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <excludes>
                        <exclude>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                        </exclude>
                    </excludes>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>

// === ARCHIVO: api/src/main/resources/application.yml ===
spring:
  application:
    name: orders-service
  profiles:
    active: dev
  
server:
  port: 8080
  
aws:
  region: us-east-1
  dynamodb:
    endpoint: http://localhost:8000
    table-name: Orders
  sqs:
    order-events-queue: order-events-queue
    
---
# Perfil de desarrollo
spring:
  config:
    activate:
      on-profile: dev
  datasource:
    url: jdbc:h2:mem:ordersdb
    driver-class-name: org.h2.Driver
    username: sa
    password: ""
  h2:
    console:
      enabled: true
      path: /h2-console
  jpa:
    database-platform: org.hibernate.dialect.H2Dialect
    hibernate:
      ddl-auto: update

---
# Perfil de producción
spring:
  config:
    activate:
      on-profile: prod
  datasource:
    url: ${DB_URL}
    username: ${DB_USERNAME}
    password: ${DB_PASSWORD}
    driver-class-name: org.postgresql.Driver
  jpa:
    database-platform: org.hibernate.dialect.PostgreSQLDialect
    hibernate:
      ddl-auto: validate

// === ARCHIVO: api/src/main/java/com/pragma/orders/domain/Order.java ===
package com.pragma.orders.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;
import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Order {
    private String id;
    
    @NotNull(message = "El cliente es obligatorio")
    @Size(min = 1, max = 50, message = "El ID del cliente debe tener entre 1 y 50 caracteres")
    private String customerId;
    
    @NotNull(message = "Los ítems de la orden no pueden ser nulos")
    private List<OrderItem> items;
    
    @NotNull(message = "El estado de la orden es obligatorio")
    private OrderStatus status;
    
    @Positive(message = "El total debe ser un valor positivo")
    private double totalAmount;
    
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public enum OrderStatus {
        CREATED,
        PROCESSING,
        COMPLETED,
        CANCELLED
    }
    
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class OrderItem {
        @NotNull(message = "El ID del producto es obligatorio")
        private String productId;
        
        @Positive(message = "La cantidad debe ser positiva")
        private int quantity;
        
        @Positive(message = "El precio debe ser positivo")
        private double price;
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/domain/OrderRepository.java ===
package com.pragma.orders.domain;

import java.util.Optional;

public interface OrderRepository {
    Order save(Order order);
    Optional<Order> findById(String id);
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/application/dto/OrderRequestDTO.java ===
package com.pragma.orders.application.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Positive;
import java.util.List;

public class OrderRequestDTO {

    @NotBlank(message = "El ID del cliente es obligatorio")
    private String customerId;

    @NotEmpty(message = "La orden debe contener al menos un item")
    private List<OrderItemRequestDTO> items;

    public OrderRequestDTO() {}

    public OrderRequestDTO(String customerId, List<OrderItemRequestDTO> items) {
        this.customerId = customerId;
        this.items = items;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public List<OrderItemRequestDTO> getItems() {
        return items;
    }

    public void setItems(List<OrderItemRequestDTO> items) {
        this.items = items;
    }

    public static class OrderItemRequestDTO {

        @NotBlank(message = "El ID del producto es obligatorio")
        private String productId;

        @Positive(message = "La cantidad debe ser mayor a cero")
        private int quantity;

        @Positive(message = "El precio unitario debe ser mayor a cero")
        private double unitPrice;

        public OrderItemRequestDTO() {}

        public OrderItemRequestDTO(String productId, int quantity, double unitPrice) {
            this.productId = productId;
            this.quantity = quantity;
            this.unitPrice = unitPrice;
        }

        public String getProductId() {
            return productId;
        }

        public void setProductId(String productId) {
            this.productId = productId;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }

        public double getUnitPrice() {
            return unitPrice;
        }

        public void setUnitPrice(double unitPrice) {
            this.unitPrice = unitPrice;
        }
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/application/dto/OrderResponseDTO.java ===
package com.pragma.orders.application.dto;

import java.time.LocalDateTime;
import java.util.List;

public class OrderResponseDTO {

    private String id;
    private String customerId;
    private List<OrderItemResponseDTO> items;
    private String status;
    private double totalAmount;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public OrderResponseDTO() {}

    public OrderResponseDTO(String id, String customerId, List<OrderItemResponseDTO> items,
                           String status, double totalAmount, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.customerId = customerId;
        this.items = items;
        this.status = status;
        this.totalAmount = totalAmount;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public List<OrderItemResponseDTO> getItems() {
        return items;
    }

    public void setItems(List<OrderItemResponseDTO> items) {
        this.items = items;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public static class OrderItemResponseDTO {
        private String productId;
        private int quantity;
        private double unitPrice;
        private double subtotal;

        public OrderItemResponseDTO() {}

        public OrderItemResponseDTO(String productId, int quantity, double unitPrice, double subtotal) {
            this.productId = productId;
            this.quantity = quantity;
            this.unitPrice = unitPrice;
            this.subtotal = subtotal;
        }

        public String getProductId() {
            return productId;
        }

        public void setProductId(String productId) {
            this.productId = productId;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }

        public double getUnitPrice() {
            return unitPrice;
        }

        public void setUnitPrice(double unitPrice) {
            this.unitPrice = unitPrice;
        }

        public double getSubtotal() {
            return subtotal;
        }

        public void setSubtotal(double subtotal) {
            this.subtotal = subtotal;
        }
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/application/OrderService.java ===
package com.pragma.orders.application;

import com.pragma.orders.application.dto.OrderRequestDTO;
import com.pragma.orders.application.dto.OrderResponseDTO;
import com.pragma.orders.domain.Order;
import com.pragma.orders.domain.Order.OrderItem;
import com.pragma.orders.domain.Order.OrderStatus;
import com.pragma.orders.domain.OrderRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class OrderService {

    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    public OrderResponseDTO createOrder(OrderRequestDTO request) {
        Order order = mapRequestToOrder(request);
        Order savedOrder = orderRepository.save(order);
        return mapOrderToResponse(savedOrder);
    }

    public Optional<OrderResponseDTO> getOrder(String id) {
        return orderRepository.findById(id)
                .map(this::mapOrderToResponse);
    }

    private Order mapRequestToOrder(OrderRequestDTO request) {
        String orderId = UUID.randomUUID().toString();
        LocalDateTime now = LocalDateTime.now();

        List<OrderItem> items = request.getItems().stream()
                .map(itemDTO -> new OrderItem(
                        itemDTO.getProductId(),
                        itemDTO.getQuantity(),
                        itemDTO.getUnitPrice()
                ))
                .collect(Collectors.toList());

        double totalAmount = items.stream()
                .mapToDouble(item -> item.getQuantity() * item.getPrice())
                .sum();

        Order order = new Order();
        order.setId(orderId);
        order.setCustomerId(request.getCustomerId());
        order.setItems(items);
        order.setStatus(OrderStatus.valueOf("PENDING"));
        order.setTotalAmount(totalAmount);
        order.setCreatedAt(now);
        order.setUpdatedAt(now);

        return order;
    }

    private OrderResponseDTO mapOrderToResponse(Order order) {
        List<OrderResponseDTO.OrderItemResponseDTO> itemResponses = order.getItems().stream()
                .map(item -> new OrderResponseDTO.OrderItemResponseDTO(
                        item.getProductId(),
                        item.getQuantity(),
                        item.getPrice(),
                        item.getQuantity() * item.getPrice()
                ))
                .collect(Collectors.toList());

        return new OrderResponseDTO(
                order.getId(),
                order.getCustomerId(),
                itemResponses,
                order.getStatus().name(),
                order.getTotalAmount(),
                order.getCreatedAt(),
                order.getUpdatedAt()
        );
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/adapters/OrderDynamoDBAdapter.java ===
package com.pragma.orders.infrastructure.adapters;

import com.pragma.orders.domain.Order;
import com.pragma.orders.domain.Order.OrderItem;
import com.pragma.orders.domain.Order.OrderStatus;
import com.pragma.orders.domain.OrderRepository;
import org.springframework.stereotype.Repository;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Repository
public class OrderDynamoDBAdapter implements OrderRepository {

    private static final String TABLE_NAME = "orders";
    private static final String ID_ATTRIBUTE = "id";
    private static final String CUSTOMER_ID_ATTRIBUTE = "customerId";
    private static final String ITEMS_ATTRIBUTE = "items";
    private static final String STATUS_ATTRIBUTE = "status";
    private static final String TOTAL_AMOUNT_ATTRIBUTE = "totalAmount";
    private static final String CREATED_AT_ATTRIBUTE = "createdAt";
    private static final String UPDATED_AT_ATTRIBUTE = "updatedAt";

    private final DynamoDbClient dynamoDbClient;

    public OrderDynamoDBAdapter(DynamoDbClient dynamoDbClient) {
        this.dynamoDbClient = dynamoDbClient;
    }

    @Override
    public Order save(Order order) {
        Map<String, AttributeValue> item = new HashMap<>();
        item.put(ID_ATTRIBUTE, AttributeValue.builder().s(order.getId()).build());
        item.put(CUSTOMER_ID_ATTRIBUTE, AttributeValue.builder().s(order.getCustomerId()).build());
        item.put(ITEMS_ATTRIBUTE, AttributeValue.builder().l(mapItemsToAttributeValue(order.getItems())).build());
        item.put(STATUS_ATTRIBUTE, AttributeValue.builder().s(order.getStatus().name()).build());
        item.put(TOTAL_AMOUNT_ATTRIBUTE, AttributeValue.builder().n(String.valueOf(order.getTotalAmount())).build());
        item.put(CREATED_AT_ATTRIBUTE, AttributeValue.builder().s(order.getCreatedAt().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME)).build());
        item.put(UPDATED_AT_ATTRIBUTE, AttributeValue.builder().s(order.getUpdatedAt().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME)).build());

        PutItemRequest request = PutItemRequest.builder()
                .tableName(TABLE_NAME)
                .item(item)
                .build();

        dynamoDbClient.putItem(request);
        return order;
    }

    @Override
    public Optional<Order> findById(String id) {
        GetItemRequest request = GetItemRequest.builder()
                .tableName(TABLE_NAME)
                .key(Map.of(ID_ATTRIBUTE, AttributeValue.builder().s(id).build()))
                .build();

        GetItemResponse response = dynamoDbClient.getItem(request);

        if (!response.hasItem() || response.item().isEmpty()) {
            return Optional.empty();
        }

        return Optional.of(mapAttributeValueToOrder(response.item()));
    }

    private List<AttributeValue> mapItemsToAttributeValue(List<OrderItem> items) {
        return items.stream()
                .map(item -> {
                    Map<String, AttributeValue> itemMap = new HashMap<>();
                    itemMap.put("productId", AttributeValue.builder().s(item.getProductId()).build());
                    itemMap.put("quantity", AttributeValue.builder().n(String.valueOf(item.getQuantity())).build());
                    itemMap.put("unitPrice", AttributeValue.builder().n(String.valueOf(item.getPrice())).build());
                    return AttributeValue.builder().m(itemMap).build();
                })
                .collect(Collectors.toList());
    }

    private Order mapAttributeValueToOrder(Map<String, AttributeValue> item) {
        Order order = new Order();
        order.setId(item.get(ID_ATTRIBUTE).s());
        order.setCustomerId(item.get(CUSTOMER_ID_ATTRIBUTE).s());
        order.setItems(mapAttributeValueToItems(item.get(ITEMS_ATTRIBUTE).l()));
        order.setStatus(OrderStatus.valueOf(item.get(STATUS_ATTRIBUTE).s()));
        order.setTotalAmount(Double.parseDouble(item.get(TOTAL_AMOUNT_ATTRIBUTE).n()));
        order.setCreatedAt(LocalDateTime.parse(item.get(CREATED_AT_ATTRIBUTE).s(), DateTimeFormatter.ISO_LOCAL_DATE_TIME));
        order.setUpdatedAt(LocalDateTime.parse(item.get(UPDATED_AT_ATTRIBUTE).s(), DateTimeFormatter.ISO_LOCAL_DATE_TIME));
        return order;
    }

    private List<OrderItem> mapAttributeValueToItems(List<AttributeValue> items) {
        return items.stream()
                .map(attr -> {
                    Map<String, AttributeValue> itemMap = attr.m();
                    return new OrderItem(
                            itemMap.get("productId").s(),
                            Integer.parseInt(itemMap.get("quantity").n()),
                            Double.parseDouble(itemMap.get("unitPrice").n())
                    );
                })
                .collect(Collectors.toList());
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/controllers/OrderController.java ===
package com.pragma.orders.infrastructure.controllers;

import com.pragma.orders.application.dto.OrderRequestDTO;
import com.pragma.orders.application.dto.OrderResponseDTO;
import com.pragma.orders.application.OrderService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @PostMapping
    public ResponseEntity<OrderResponseDTO> createOrder(@Valid @RequestBody OrderRequestDTO request) {
        OrderResponseDTO response = orderService.createOrder(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderResponseDTO> getOrder(@PathVariable String id) {
        return orderService.getOrder(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<Map<String, String>> handleException(Exception ex) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Map.of("error", ex.getMessage()));
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/config/AwsConfig.java ===
package com.pragma.orders.infrastructure.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.dynamodb.DynamoDbAsyncClient;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.sqs.SqsClient;

import java.net.URI;

@Configuration
public class AwsConfig {

    @Value("${AWS_ACCESS_KEY_ID:#{systemEnvironment['AWS_ACCESS_KEY_ID']}}")
    private String accessKeyId;

    @Value("${AWS_SECRET_ACCESS_KEY:#{systemEnvironment['AWS_SECRET_ACCESS_KEY']}}")
    private String secretAccessKey;

    @Value("${AWS_REGION:us-east-1}")
    private String region;

    @Value("${AWS_DYNAMODB_ENDPOINT:#{systemEnvironment['AWS_DYNAMODB_ENDPOINT']}}")
    private String dynamoDbEndpoint;

    @Value("${AWS_SQS_ENDPOINT:#{systemEnvironment['AWS_SQS_ENDPOINT']}}")
    private String sqsEndpoint;

    @Value("${AWS_LAMBDA_ENDPOINT:#{systemEnvironment['AWS_LAMBDA_ENDPOINT']}}")
    private String lambdaEndpoint;

    @Bean
    public AwsBasicCredentials awsBasicCredentials() {
        if (accessKeyId == null || secretAccessKey == null || accessKeyId.isEmpty() || secretAccessKey.isEmpty()) {
            throw new IllegalStateException(
                "AWS credentials not configured. Set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables."
            );
        }
        return AwsBasicCredentials.create(accessKeyId, secretAccessKey);
    }

    @Bean
    public Region awsRegion() {
        return Region.of(region);
    }

    @Bean
    public StaticCredentialsProvider staticCredentialsProvider(AwsBasicCredentials awsBasicCredentials) {
        return StaticCredentialsProvider.create(awsBasicCredentials);
    }

    @Bean
    public DynamoDbClient dynamoDbClient(Region awsRegion, StaticCredentialsProvider staticCredentialsProvider) {
        var builder = DynamoDbClient.builder()
            .region(awsRegion)
            .credentialsProvider(staticCredentialsProvider);

        if (dynamoDbEndpoint != null && !dynamoDbEndpoint.isEmpty()) {
            builder.endpointOverride(URI.create(dynamoDbEndpoint));
        }

        return builder.build();
    }

    @Bean
    public DynamoDbAsyncClient dynamoDbAsyncClient(Region awsRegion, StaticCredentialsProvider staticCredentialsProvider) {
        var builder = DynamoDbAsyncClient.builder()
            .region(awsRegion)
            .credentialsProvider(staticCredentialsProvider);

        if (dynamoDbEndpoint != null && !dynamoDbEndpoint.isEmpty()) {
            builder.endpointOverride(URI.create(dynamoDbEndpoint));
        }

        return builder.build();
    }

    @Bean
    public SqsClient sqsClient(Region awsRegion, StaticCredentialsProvider staticCredentialsProvider) {
        var builder = SqsClient.builder()
            .region(awsRegion)
            .credentialsProvider(staticCredentialsProvider);

        if (sqsEndpoint != null && !sqsEndpoint.isEmpty()) {
            builder.endpointOverride(URI.create(sqsEndpoint));
        }

        return builder.build();
    }

    @Bean
    public LambdaClient lambdaClient(Region awsRegion, StaticCredentialsProvider staticCredentialsProvider) {
        var builder = LambdaClient.builder()
            .region(awsRegion)
            .credentialsProvider(staticCredentialsProvider);

        if (lambdaEndpoint != null && !lambdaEndpoint.isEmpty()) {
            builder.endpointOverride(URI.create(lambdaEndpoint));
        }

        return builder.build();
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/OrdersApplication.java ===
package com.pragma.orders;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = {
    "com.pragma.orders.domain",
    "com.pragma.orders.application",
    "com.pragma.orders.infrastructure"
})
public class OrdersApplication {

    public static void main(String[] args) {
        SpringApplication.run(OrdersApplication.class, args);
    }
}
```
