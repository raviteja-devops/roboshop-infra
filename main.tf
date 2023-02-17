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


module "docdb" {
  source = "github.com/raviteja-devops/tf-module-docdb.git"
  env = var.env

  for_each = var.docdb
  subnet_ids = lookup(lookup(lookup(lookup(module.vpc, each.value.vpc_name, null), "private_subnet_ids", null), each.value.subnets_name, null), "subnet_ids", null)
}

# we lookup for module vpc, inside vpc module we look for vpc name(which we provide at main.tfvars),
# we used each.value because we declared vpc_name value as main in docdb at main.tfvars
# inside vpc_name again we need to look for private subnet id's, so again we use lookup of lookup
# inside that we have app, db, web, so we need db, again lookup and we declared subnets_name at .tfvars so we use its value
# inside db we have subnet_ids, one more lookup
# this id's were fetched by main.tf of docdb module for grouping purpose only

# Everything we need to maintain is modules from git-side

