module "network" {
  source = "github.com/raviteja-devops/tf-module-vpc.git"

  for_each = var.vpc
  cidr_block = each.value.cidr_block
}
# To Refer Particular Module
# Everything we need to maintain is modules from git-side
# we are trying to maintain the uniformity of the variables also