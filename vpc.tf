resource "aws_vpc" "vpc144" {
  cidr_block = "10.144.0.0/16"
  tags {
    Name = "${var.vpc_name}"
  }
}

resource "aws_internet_gateway" "vpc144" {
  vpc_id = "${aws_vpc.vpc144.id}"
}

# NAT instance

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
    cidr_blocks = ["${aws_subnet.us-east-2b-private.cidr_block}"]
  }
  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["${aws_subnet.us-east-2c-private.cidr_block}"]
  }

  vpc_id = "${aws_vpc.vpc144.id}"
}

resource "aws_instance" "nat" {
  ami = "${var.aws_nat_ami}"
  availability_zone = "us-east-2b"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_name}"
  security_groups = ["${aws_security_group.nat.id}"]
  subnet_id = "${aws_subnet.us-east-2b-public.id}"
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

# Public subnets

resource "aws_subnet" "us-east-2b-public" {
  vpc_id = "${aws_vpc.vpc144.id}"

  cidr_block = "10.144.0.0/24"
  availability_zone = "us-east-2b"
}

resource "aws_subnet" "us-east-2c-public" {
  vpc_id = "${aws_vpc.vpc144.id}"

  cidr_block = "10.144.2.0/24"
  availability_zone = "us-east-2c"
}

# Routing table for public subnets

#resource "aws_route_table" "us-east-2-public" {
resource "aws_route_table" "us-east-2-public" {
  vpc_id = "${aws_vpc.vpc144.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc144.id}"
  }
}

resource "aws_route_table_association" "us-east-2b-public" {
  subnet_id = "${aws_subnet.us-east-2b-public.id}"
  route_table_id = "${aws_route_table.us-east-2-public.id}"
}

resource "aws_route_table_association" "us-east-2c-public" {
  subnet_id = "${aws_subnet.us-east-2c-public.id}"
  route_table_id = "${aws_route_table.us-east-2-public.id}"
}

# Private subsets

resource "aws_subnet" "us-east-2b-private" {
  vpc_id = "${aws_vpc.vpc144.id}"

  cidr_block = "10.144.1.0/24"
  availability_zone = "us-east-2b"
}

resource "aws_subnet" "us-east-2c-private" {
  vpc_id = "${aws_vpc.vpc144.id}"

  cidr_block = "10.144.3.0/24"
  availability_zone = "us-east-2c"
}

# Routing table for private subnets

resource "aws_route_table" "us-east-2-private" {
  vpc_id = "${aws_vpc.vpc144.id}"

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
}

resource "aws_route_table_association" "us-east-2b-private" {
  subnet_id = "${aws_subnet.us-east-2b-private.id}"
  route_table_id = "${aws_route_table.us-east-2-private.id}"
}

resource "aws_route_table_association" "us-east-2c-private" {
  subnet_id = "${aws_subnet.us-east-2c-private.id}"
  route_table_id = "${aws_route_table.us-east-2-private.id}"
}

# Bastion

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

  vpc_id = "${aws_vpc.vpc144.id}"
}

resource "aws_instance" "bastion" {
  ami = "${var.aws_linux_ami}"
  availability_zone = "us-east-2b"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_name}"
  security_groups = ["${aws_security_group.bastion.id}"]
  subnet_id = "${aws_subnet.us-east-2b-public.id}"
  tags {
    Name = "${var.vpc_name}-bastion"
  }
}

resource "aws_eip" "bastion" {
  instance = "${aws_instance.bastion.id}"
  vpc = true
}
