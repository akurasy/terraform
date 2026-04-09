variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "existing_vpc_id" {
  description = "Existing VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Existing public subnet IDs for the ALB"
  type        = list(string)
}

variable "alb_name" {
  description = "ALB name"
  type        = string
}

variable "alb_internal" {
  description = "Whether the ALB is internal"
  type        = bool
  default     = false
}

variable "alb_certificate_arn" {
  description = "ACM certificate ARN for HTTPS listener"
  type        = string
}

variable "alb_security_group_name" {
  description = "Security group name for the ALB"
  type        = string
}

variable "alb_security_group_description" {
  description = "Security group description for the ALB"
  type        = string
}

variable "allowed_ingress_cidrs" {
  description = "CIDRs allowed to reach the ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_egress_cidrs" {
  description = "CIDRs allowed outbound from the ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "app_domain_name" {
  description = "Host header for app traffic"
  type        = string
  default     = "mc-backend.wittytech.io"
}

variable "redis_domain_name" {
  description = "Host header for redis traffic"
  type        = string
  default     = "redis-mc-prod.wittytech.io"
}

variable "app_tg_name" {
  description = "Application target group name"
  type        = string
  default     = "mc-backend-tg"
}

variable "redis_tg_name" {
  description = "Redis target group name"
  type        = string
  default     = "redis-tg"
}

variable "target_type" {
  description = "Target type for target groups"
  type        = string
  default     = "instance"
}

variable "app_target_port" {
  description = "Backend port for app target group"
  type        = number
  default     = 8021
}

variable "app_target_protocol" {
  description = "Backend protocol for app target group"
  type        = string
  default     = "HTTP"
}

variable "app_health_check_path" {
  description = "Health check path for app target group"
  type        = string
  default     = "/"
}

variable "redis_target_port" {
  description = "Backend port for redis target group"
  type        = number
  default     = 6379
}

variable "redis_target_protocol" {
  description = "Backend protocol for redis target group. For ALB this must be HTTP or HTTPS."
  type        = string
  default     = "HTTP"
}

variable "redis_health_check_path" {
  description = "Health check path for redis target group"
  type        = string
  default     = "/"
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
