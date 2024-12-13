output "jenkins_url" {
  depends_on = [aws_instance.sd2195_ec2]
  value      = join("", ["http://", aws_instance.sd2195_ec2.public_ip, ":", "8080"])
}

output "ecr_backend_repo_url" {
  depends_on = [aws_ecr_repository.sd2195_ecr_backend]
  value      = aws_ecr_repository.sd2195_ecr_backend.repository_url
}

output "ecr_frontend_repo_url" {
  depends_on = [aws_ecr_repository.sd2195_ecr_frontend]
  value      = aws_ecr_repository.sd2195_ecr_frontend.repository_url
}