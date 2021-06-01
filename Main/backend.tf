terraform {
    backend "s3" {
        bucket = "jehangir-state"
        key    = "terraform.tfstate"
        region = "us-east-2"
        dynamodb_table = "terraformstate"
  }
}