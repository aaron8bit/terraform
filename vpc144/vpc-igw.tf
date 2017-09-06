##################################################
# Internet gateway

resource "aws_internet_gateway" "vpc144" {
  vpc_id = "${aws_vpc.vpc144.id}"
}
