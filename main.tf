terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"  # Replace with your desired provider version
    }
  }

  required_version = ">= 0.15"  # Replace with your desired Terraform version
}

provider "aws" {
  region = "us-east-1"  # Set the AWS region
}

resource "aws_instance" "example" {
  ami           = "ami-12345678"  # Replace with your desired AMI ID
  instance_type = "t2.micro"
  # Add other instance configuration settings as needed
}
