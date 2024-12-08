resource "aws_ecr_repository" "sd2195_ecr" {
  name                 = "sd2195_ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}