##################################################
# NAT instance

resource "aws_instance" "nat" {
  ami = "${var.aws_nat_ami}"
  availability_zone = "us-east-2b"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_name}"
  security_groups = ["${aws_security_group.nat.id}"]
  subnet_id = "${aws_subnet.public1.id}"
  associate_public_ip_address = true
  source_dest_check = false
  tags {
    Name = "${var.vpc_name}-nat"
  }
}

resource "aws_eip" "nat" {
  instance = "${aws_instance.nat.id}"
  vpc = true
}

resource "aws_security_group" "nat" {
  name = "${var.vpc_name}-nat-sg"
  description = "Allow services from the private subnet through NAT"
  tags {
    Name = "${var.vpc_name}-nat-sg"
  }

  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["${aws_subnet.private1.cidr_block}"]
  }
  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["${aws_subnet.private2.cidr_block}"]
  }

  vpc_id = "${aws_vpc.vpc144.id}"
}
