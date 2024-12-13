resource "aws_ecr_repository" "sd2195_ecr_backend" {
  name                 = "sd2195_ecr_backend"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "sd2195_ecr_frontend" {
  name                 = "sd2195_ecr_frontend"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}