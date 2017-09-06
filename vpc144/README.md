# Terraform Basic VPC Test
Creates a VPC with a public subnet and a private subnet. The public
subnet contains a bastion host that is accessible from the Internet
and a NAT gateway. The private subnet contains a test host that can
be reached only through the bastion host and has Internet access via
the NAT gateway.
