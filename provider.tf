terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.31.0"
    }
  }
  backend "s3" {
    bucket = "techru-tfstate"
    region = "ap-northeast-1"
    key = "terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region     = "ap-northeast-1"
  # Credentials should be written in ~/.credentials/aws by AWS CLI tool.
  # access_key = "AKIXXXXXXXXXXXXXXXX"
  # secret_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}