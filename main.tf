terraform {

  cloud {
    organization = "tareq_terra"

    workspaces {
      name = "Discord-Project-TF"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }



  required_version = ">= 0.15"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2-instance" {
  ami           = "ami-0230bd60aa48260c6"
  instance_type = "t2.micro"
  tags = {
    Name        = "TF Discord"
    Environment = "Development"
    Owner       = "YourName"

  }

}
