##################################################
# Bastion instance

resource "aws_instance" "bastion" {
  ami = "${var.aws_linux_ami}"
  availability_zone = "${var.vpc_az1}"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_name}"
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
  subnet_id = "${aws_subnet.public1.id}"
  tags {
    Name = "${var.vpc_name}-bastion"
  }
}

resource "aws_eip" "bastion" {
  instance = "${aws_instance.bastion.id}"
  vpc = true
}

resource "aws_security_group" "bastion" {
  name = "${var.vpc_name}-bastion-sg"
  description = "Allow SSH traffic from the internet"
  tags {
    Name = "${var.vpc_name}-bastion-sg"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.vpc144.id}"
}
