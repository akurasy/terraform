aws_region      = "eu-west-2"

common_tags = {
  Environment = "prod"
}

ecr_repo_names  = [
  "redis",
  "mc-backend-service"
]
