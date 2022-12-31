

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.48.0"
    }
  }
}


provider "aws" {
access_key = var.AWS_ACCESS_KEY
secret_key = var.AWS_SECRET_KEY
region = "ap-south-1"
}