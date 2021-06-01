provider "aws" {
  profile = "default"
  region = "${var.settings.AWS_REGION}"
}