variable "aws_region" {
  type        = string
  description = "AWS region for the bastion host"
  default     = "ap-southeast-1"
}

variable "name_prefix" {
  type        = string
  description = "Prefix for AWS resource names"
  default     = "hybrid-cloud"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the bastion host will be deployed"
}

variable "subnet_id" {
  type        = string
  description = "Public subnet ID for the bastion host"
}

variable "key_pair_name" {
  type        = string
  description = "EC2 key pair name for SSH access"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for the bastion host"
  default     = "t3.micro"
}

variable "admin_cidrs" {
  type        = list(string)
  description = "Allowed CIDR ranges for SSH and WireGuard access"
}
