module "vpc" {
  source = "github.com/raviteja-devops/tf-module-vpc.git"
  env = var.env
  default_vpc_id = var.default_vpc_id

  for_each = var.vpc
  cidr_block = each.value.cidr_block
  public_subnets = each.value.public_subnets
  private_subnets   = each.value.private_subnets
  availability_zone = each.value.availability_zone
}


#module "subnets" {
#  source = "github.com/raviteja-devops/tf-module-subnets.git"
#  env = var.env
#  default_vpc_id = var.default_vpc_id
#
#  for_each = var.subnets
#  cidr_block = each.value.cidr_block
#  availability_zone = each.value.availability_zone
#  name = each.value.name
#  vpc_id = lookup(lookup(module.vpc, each.value.vpc_name, null), "vpc_id", null)
#  vpc_peering_connection_id = lookup(lookup(module.vpc, each.value.vpc_name, null), "vpc_peering_connection_id", null)
#  internet_gw = lookup(each.value, "internet_gw", false)
#  nat_gw = lookup(each.value, "nat_gw", false)
#}

# looking for internet_gw, if there use that value, if not there take false
# we call this module
# this same information goes to tf-modules -- vars.tf

# To Refer Particular Module
# Everything we need to maintain is modules from git-side
# we are trying to maintain the uniformity of the variables also
