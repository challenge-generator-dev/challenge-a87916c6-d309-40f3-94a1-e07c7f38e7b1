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