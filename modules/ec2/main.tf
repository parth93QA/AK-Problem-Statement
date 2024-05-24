data "aws_ami" "amzlinux2" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}

resource "aws_instance" "ec2" {
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.ssh_access.id]
  subnet_id     = var.public_subnet_id
  tags = {
    Name = "${var.instance_name}-ec2"
  }
}