terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.42.0"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  workspace = "${terraform.workspace}"
  config = {
    bucket    = "jehangir-state-vpc"
    key       = "terraform.tfstate"
    region    = "us-east-2"
  }
}


module "SG" {
  source = "./modules/sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.output_data.vpc_id
}

module "ALB" {
  source      = "./modules/alb"
  vpc_details = data.terraform_remote_state.vpc.outputs.output_data
  sg_details  = module.SG.sg_output
}

module "DB" {
  source      = "./modules/db"
  main_settings = var.settings
  vpc_details = data.terraform_remote_state.vpc.outputs.output_data
  sg_details  = module.SG.sg_output
}

module "ASG" {
  source      = "./modules/asg"
  depends_on = [module.DB]
  main_settings = var.settings
  db_private_ip = module.DB.db_output.private_ip
  alb_details  = module.ALB.alb_output
  vpc_details = data.terraform_remote_state.vpc.outputs.output_data
  sg_details  = module.SG.sg_output
}