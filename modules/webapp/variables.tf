variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0230bd60aa48260c6"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
}