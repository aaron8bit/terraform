##################################################
# Internal test instance

resource "aws_instance" "internal-test" {
  ami = "${var.aws_linux_ami}"
  availability_zone = "us-east-2b"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_name}"
  security_groups = ["${aws_security_group.internal-test.id}"]
  subnet_id = "${aws_subnet.private1.id}"
  tags {
    Name = "${var.vpc_name}-internal-test"
  }
}

resource "aws_security_group" "internal-test" {
  name = "${var.vpc_name}-internal-test-sg"
  description = "Allow SSH traffic from the internet"
  tags {
    Name = "${var.vpc_name}-internal-test-sg"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.vpc145.id}"
}
