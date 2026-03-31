output "bastion_public_ip" {
  value       = aws_instance.bastion.public_ip
  description = "Public IP address of the AWS bastion host"
}

output "bastion_instance_id" {
  value       = aws_instance.bastion.id
  description = "Instance ID of the AWS bastion host"
}

output "bastion_security_group_id" {
  value       = aws_security_group.bastion.id
  description = "Security group ID for the AWS bastion host"
}
