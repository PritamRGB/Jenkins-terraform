variable "vpcid"{
type = string
default = "vpc-0e151f684cded6328"
}

resource "aws_security_group" "terraform_sg" {
  name        = "terraform_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${var.vpcid}"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    description      = "for all outgoing traffics"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }


  tags = {
    Name = "allow_tls"
  }
}

#resource "aws_security_group" "ecn_sg" {}

variable "amiid" {

default = "ami-0069d66985b09d219"

}

data "aws_subnet" "my_subnet" {
  tags = {
    Name = "ecn1-PrivateSubnet2"
  }
}

resource "aws_instance" "terraform_ec2" {
  ami           = "${var.amiid}"
  instance_type = "t3.micro"
  subnet_id              = data.aws_subnet.my_subnet.id
  availability_zone = "eu-west-1b"
  key_name = "awsfortifydev01-windows"
  #user_data = "${file("mydata.sh")}"
#  security_groups  = ["ericsson-ecn-default-vpc-0e151f684cded6328"]
  security_groups = ["${aws_security_group.terraform_sg.id}"]

  tags = {
    Name = "Terraform_EC2"
  }
}
