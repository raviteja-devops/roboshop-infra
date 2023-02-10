module "network" {
  source = "github.com/raviteja-devops/tf-module-vpc.git"
  env = var.env

  for_each = var.vpc
  cidr_block = each.value.cidr_block
}
# there is this one module and we are calling this module

# To Refer Particular Module
# Everything we need to maintain is modules from git-side
# we are trying to maintain the uniformity of the variables also