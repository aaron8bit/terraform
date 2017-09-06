##################################################
# Routing table for private subnets

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc145.id}"

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.internal-test.id}"
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
