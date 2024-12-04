resource "aws_instance" "sd2195_ec2" {
  ami                         = var.ami
  availability_zone           = var.availability_zones[0]
  associate_public_ip_address = true
  instance_type               = var.instance_type
  key_name                    = "ec2key"
  subnet_id                   = aws_subnet.sd2195_public_subnet_1.id
  vpc_security_group_ids      = [aws_security_group.sd2195_ec2_sg.id]
  user_data                   = file("init-installation.sh")

  tags = {
    Name = "sd2195_ec2"
  }
}