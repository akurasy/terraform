aws_region      = "eu-west-2"
existing_vpc_id = "vpc-xxxx"

public_subnet_ids = [
  "subnet-1-id",
  "subnet-2-id",
  "subnet-3-id"
]

alb_name                       = "witty-eu-alb"
alb_internal                   = false
alb_certificate_arn            = "arn:aws:acm:eu-west-2:<aws-acct-id>:certificate/acm-id"
alb_security_group_name        = "witty-eu-alb-sg"
alb_security_group_description = "Allow HTTP and HTTPS to ALB"

allowed_ingress_cidrs = ["0.0.0.0/0"]

app_domain_name   = "app-url"
redis_domain_name = "redis-url"

app_tg_name           = "mc-backend-tg"
app_target_port       = 8021
app_target_protocol   = "HTTP"
app_health_check_path = "/"

redis_tg_name           = "redis-tg"
redis_target_port       = 6379
redis_target_protocol   = "HTTP"
redis_health_check_path = "/"

target_type = "instance"

common_tags = {
  Environment = "prod"
  Project     = "app"
}
