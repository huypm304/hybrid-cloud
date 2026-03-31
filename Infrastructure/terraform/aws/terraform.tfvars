aws_region    = "ap-southeast-1"
name_prefix   = "hybrid-cloud"
vpc_id        = "vpc-xxxxxxxx"
subnet_id     = "subnet-xxxxxxxx"
key_pair_name = "hybrid-cloud-key"
instance_type = "t3.micro"

admin_cidrs = [
  "203.0.113.10/32",
]
