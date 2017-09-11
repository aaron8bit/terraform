# CloudFormation Basic VPC Test
After deploying vpc144 using Terraform I used CloudFormer to create
a CloudFormation stack with a similar configuration so I could 
compare Terraform and CloudFormation.

Creates a VPC with a public subnet and a private subnet. The public
subnet contains a bastion host that is accessible from the Internet
and a NAT gateway. The private subnet contains a test host that can
be reached only through the bastion host and has Internet access via
the NAT gateway.
