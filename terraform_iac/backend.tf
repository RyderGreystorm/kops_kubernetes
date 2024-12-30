provider "aws" {
  region = var.REGION
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "Hashicorp/aws"
      version = "~> 5.82.2"
    }
  }
  backend "s3" {
    bucket         = "profile-biekro"
    key            = "global/mystatefiles/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}