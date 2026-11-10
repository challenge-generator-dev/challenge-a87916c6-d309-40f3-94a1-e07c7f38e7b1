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