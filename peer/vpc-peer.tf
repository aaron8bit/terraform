resource "aws_vpc_peering_connection" "vpc144vpc145peer" {
  peer_vpc_id   = "${aws_vpc.vpc144.id}"
  vpc_id        = "${aws_vpc.vpc145.id}"
  auto_accept   = true

  tags {
    Name = "VPC peering of vpc145 to vpc144"
  }
}
