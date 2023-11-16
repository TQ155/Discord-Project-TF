output "instance_public_ip" {
  description = "Public IP of the created EC2 instance"
  value       = aws_instance.ec2-instance.public_ip
}

output "instance_private_ip" {
  description = "Public IP of the created EC2 instance"
  value       = aws_instance.ec2-instance.private_ip
}
