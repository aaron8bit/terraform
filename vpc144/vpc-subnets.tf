##################################################
# Public subnets

resource "aws_subnet" "public1" {
  vpc_id = "${aws_vpc.vpc144.id}"

  cidr_block = "10.144.0.0/24"
  availability_zone = "${var.vpc_az1}"
}

resource "aws_subnet" "public2" {
  vpc_id = "${aws_vpc.vpc144.id}"

  cidr_block = "10.144.2.0/24"
  availability_zone = "${var.vpc_az2}"
}

##################################################
# Routing table for public subnets

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc144.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc144.id}"
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id = "${aws_subnet.public1.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public2" {
  subnet_id = "${aws_subnet.public2.id}"
  route_table_id = "${aws_route_table.public.id}"
}

##################################################
# Private subsets

resource "aws_subnet" "private1" {
  vpc_id = "${aws_vpc.vpc144.id}"

  cidr_block = "10.144.1.0/24"
  availability_zone = "${var.vpc_az1}"
}

resource "aws_subnet" "private2" {
  vpc_id = "${aws_vpc.vpc144.id}"

  cidr_block = "10.144.3.0/24"
  availability_zone = "${var.vpc_az2}"
}

##################################################
# Routing table for private subnets

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc144.id}"

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
}

resource "aws_route_table_association" "private1" {
  subnet_id = "${aws_subnet.private1.id}"
  route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "private2" {
  subnet_id = "${aws_subnet.private2.id}"
  route_table_id = "${aws_route_table.private.id}"
}
