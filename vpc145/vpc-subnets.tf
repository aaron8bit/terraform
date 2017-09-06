##################################################
# Private subsets

resource "aws_subnet" "private1" {
  vpc_id = "${aws_vpc.vpc145.id}"

  cidr_block = "10.145.1.0/24"
  availability_zone = "${var.vpc_az1}"
}

resource "aws_subnet" "private2" {
  vpc_id = "${aws_vpc.vpc145.id}"

  cidr_block = "10.145.3.0/24"
  availability_zone = "${var.vpc_az2}"
}
