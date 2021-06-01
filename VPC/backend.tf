terraform {
    backend "s3" {
        bucket = "jehangir-state-vpc"
        key    = "terraform.tfstate"
        region = "us-east-2"
        dynamodb_table = "terraformstatevpc"
  }
}