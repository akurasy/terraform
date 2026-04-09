provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "redis" {
  name                 = var.ecr_repo_names[0]
  image_tag_mutability = var.ecr_image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.ecr_scan_on_push
  }

  tags = merge(
    var.common_tags,
    {
      Name = var.ecr_repo_names[0]
    }
  )
}

resource "aws_ecr_repository" "mc_backend_service" {
  name                 = var.ecr_repo_names[1]
  image_tag_mutability = var.ecr_image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.ecr_scan_on_push
  }

  tags = merge(
    var.common_tags,
    {
      Name = var.ecr_repo_names[1]
    }
  )
}
