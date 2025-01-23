provider aws {
  region = "us-east-2"

}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")

}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


  resource "aws_instance" "web" {
  ami           = aws_ami.ubuntu.id
  instance_type = "t2.micro"
  #availability_zone = "us-east-2b"

  subnet_id = "subnet-069aaad6989596cb1"
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = file ("apache.sh")


  tags = {
    Name = "HelloWorld"
  }
}

output ec2 {
value = aws_instance.web.public_ip
sensitive = true
}