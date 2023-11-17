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
      version = ">= 5.0.0"
    }
  }

  required_version = ">= 0.15"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "instance-security-group" {
  name        = "instance-security-group"
  description = "Security group for the EC2 instance"

  // Other rules...

  ingress = [
    {
      description      = "Allow HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
			prefix_list_ids  = []
			security_groups = []
			self = false# Allow HTTP access from anywhere (Update as needed for security)
  },
  {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["81.110.22.2/32"]
    ipv6_cidr_blocks = []
		prefix_list_ids  = []
		ecurity_groups = []
		self = false
  }
  ]

  egress = [
    {
			description = "outgoing traffic"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
			prefix_list_ids  = []
			security_groups = []
			self = false
    }
  ]
  
}

// Create An EC2 instance
resource "aws_instance" "ec2-instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  user_data = data.template_file.user_data.rendered
  tags = {
    Name        = "TF Discord Project"
    Environment = "Development"
    Owner       = "Tareq B. M. AlQazzaz"
  }
  // Attach the security Group to the instance
  vpc_security_group_ids = [
    aws_security_group.instance-security-group.id # Replace with your actual security group ID
  ]

  provisioner "remote-exec" {
    inline = [
      "echo \"mars\" >> /home/ec2-user/barsoon/txt"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/root/.ssh/my_key") // 
      host        = "${self.public_ip}"
    }
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjmXlbiHLRjsVzZW2ygs+aSXH/PWHu1KyNqJ/5R2WWFjCWpyN4d8aLys3Pg7Ha8/dDmsUs4NygYZ4jvvgTEF5Ih2AsKF2F2TzG5KJcOF3g5TS61mi27+urF8m56O9hO2AU5GN7tS2/olQPfo92gKR8GD7TYJf/SvnZc3EktVQ9Uwa8CRIPomOi+t6Ok9ZxclZNZ6GodcXDsiULDAP4eJb+m++uYk4iugVhLntlz2jJHa3VhI4qGJgcmXkHRmIqoJgBwqZeUb0KQqf3yXFn+VP0pIZ1z2jgfV5Rd7TBfZWYP8Joh+cuRdb0GQP23rVa4kiaVd3k+ii+b8gJHxvu6Jcj tariq@DESKTOP-25A1M4E"
}

data "template_file" "user_data" {
	template = file("./userdata.yaml")
}

