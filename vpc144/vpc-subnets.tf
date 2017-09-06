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
# Private subnets

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
