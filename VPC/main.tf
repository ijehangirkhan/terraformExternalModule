terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.42.0"
    }
  }
}

module "VPC" {
  source              = "./modules/vpc"
  main_settings = var.settings
}