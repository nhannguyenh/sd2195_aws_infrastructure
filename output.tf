# print the url of the jenkins server
output "jenkins_url" {
  depends_on = [aws_instance.sd2195_ec2]
  value      = join("", ["http://", aws_instance.sd2195_ec2.public_dns, ":", "8080"])
}