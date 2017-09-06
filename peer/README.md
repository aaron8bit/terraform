# Terraform Peering Test
This will peer two existing VPCs together.

The VPCs are created from other code but the state has to be imported
before terraform can modify them. If the state is not imported, terraform
will try to create them. It's not pretty.
