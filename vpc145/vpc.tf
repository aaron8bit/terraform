##################################################
# VPC vpc145

resource "aws_vpc" "vpc145" {
  cidr_block = "10.145.0.0/16"
  tags {
    Name = "${var.vpc_name}"
  }
}
