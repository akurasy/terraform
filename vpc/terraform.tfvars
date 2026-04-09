aws_region = "eu-west-2"

vpc_name = "WITTY-EU-VPC"
vpc_cidr = "10.0.0.0/16"

availability_zones = [
  "eu-west-2a",
  "eu-west-2b",
  "eu-west-2c"
]

public_subnet_cidrs = [
  "10.0.0.0/19",
  "10.0.32.0/19",
  "10.0.64.0/19"
]

private_subnet_cidrs = [
  "10.0.96.0/19",
  "10.0.128.0/19",
  "10.0.160.0/19"
]

allowed_ingress_ports = [22, 8021, 6379]

allowed_ingress_cidrs = [
  "0.0.0.0/0"
]

security_group_name        = "witty-eu-sg"
security_group_description = "Allow SSH, 8021 and Redis access"

common_tags = {
  Environment = "prod"
  Project     = "witty"
}
