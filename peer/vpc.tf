#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# STATE MUST BE IMPORTED USING
#   terraform import aws_vpc.vpc144 vpc-XXXXXX
# BEFORE YOU CAN USE THIS
# FAILING TO IMPORT STATE MAY
# RESULT IN UNEXPECTED CHANGES
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

##################################################
# VPC vpc144

resource "aws_vpc" "vpc144" {
  cidr_block = "10.144.0.0/16"
  tags {
    Name = "vpc144"
  }
}

##################################################
# VPC vpc145

resource "aws_vpc" "vpc145" {
  cidr_block = "10.145.0.0/16"
  tags {
    Name = "vpc145"
  }
}
