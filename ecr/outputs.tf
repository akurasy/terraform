output "ecr_repository_urls" {
  value = {
    redis              = aws_ecr_repository.redis.repository_url
    mc_backend_service = aws_ecr_repository.mc_backend_service.repository_url
  }
}
