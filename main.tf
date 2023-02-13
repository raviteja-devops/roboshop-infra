module "network" {
  source = "github.com/raviteja-devops/tf-module-vpc.git"
  env = var.env
  default_vpc_id = var.default_vpc_id

  for_each = var.vpc
  cidr_block = each.value.cidr_block
  public_subnets_cidr = each.value.public_subnets_cidr
  private_subnets_cidr = each.value.private_subnets_cidr
}
# we call this module
# this same information goes to tf-modules -- vars.tf

# To Refer Particular Module
# Everything we need to maintain is modules from git-side
# we are trying to maintain the uniformity of the variables also
