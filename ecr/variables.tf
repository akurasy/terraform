variable "ecr_repo_names" {
  description = "List of ECR repository names"
  type        = list(string)
}

variable "ecr_image_tag_mutability" {
  description = "ECR image tag mutability setting"
  type        = string
  default     = "MUTABLE"
}

variable "ecr_scan_on_push" {
  description = "Enable image scan on push"
  type        = bool
  default     = true
}

variable "aws_region" {
  description = "aws region to deploy ecr"
  type        = string
}


variable "common_tags" {
  description = "environment tag"
  type        = map(string)
  default     = {}
}

