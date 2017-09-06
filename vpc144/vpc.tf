##################################################
# VPC vpc144

resource "aws_vpc" "vpc144" {
  cidr_block = "10.144.0.0/16"
  tags {
    Name = "${var.vpc_name}"
  }
}
