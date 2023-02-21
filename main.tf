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
  vpc_id = lookup(lookup(module.vpc, each.value.vpc_name, null), "vpc_id", null)
  allow_cidr = lookup(lookup(lookup(lookup(var.vpc, each.value.vpc_name, null), "private_subnets", null), "app", null), "cidr_block", null)
  engine_version = each.value.engine_version
  number_of_instances = each.value.number_of_instances
  instance_class = each.value.instance_class
}


module "rds" {
  source = "github.com/raviteja-devops/tf-module-rds.git"
  env = var.env

  for_each = var.rds
  subnet_ids = lookup(lookup(lookup(lookup(module.vpc, each.value.vpc_name, null), "private_subnet_ids", null), each.value.subnets_name, null), "subnet_ids", null)
  vpc_id = lookup(lookup(module.vpc, each.value.vpc_name, null), "vpc_id", null)
  allow_cidr = lookup(lookup(lookup(lookup(var.vpc, each.value.vpc_name, null), "private_subnets", null), "app", null), "cidr_block", null)
  engine = each.value.engine
  engine_version = each.value.engine_version
  number_of_instances = each.value.number_of_instances
  instance_class = each.value.instance_class
}


module "elasticache" {
  source = "github.com/raviteja-devops/tf-module-elasticache.git"
  env = var.env

  for_each = var.elasticache
  subnet_ids = lookup(lookup(lookup(lookup(module.vpc, each.value.vpc_name, null), "private_subnet_ids", null), each.value.subnets_name, null), "subnet_ids", null)
  vpc_id = lookup(lookup(module.vpc, each.value.vpc_name, null), "vpc_id", null)
  allow_cidr = lookup(lookup(lookup(lookup(var.vpc, each.value.vpc_name, null), "private_subnets", null), "app", null), "cidr_block", null)
  num_node_groups         = each.value.num_node_groups
  replicas_per_node_group = each.value.replicas_per_node_group
  node_type = each.value.node_type
}


module "rabbitmq" {
  source = "github.com/raviteja-devops/tf-module-rabbitmq.git"
  env = var.env

  for_each = var.rabbitmq
  subnet_ids = lookup(lookup(lookup(lookup(module.vpc, each.value.vpc_name, null), "private_subnet_ids", null), each.value.subnets_name, null), "subnet_ids", null)
  vpc_id = lookup(lookup(module.vpc, each.value.vpc_name, null), "vpc_id", null)
  allow_cidr = lookup(lookup(lookup(lookup(var.vpc, each.value.vpc_name, null), "private_subnets", null), "app", null), "cidr_block", null)
  engine_type = each.value.engine_type
  engine_version = each.value.engine_version
  host_instance_type = each.value.host_instance_type
  deployment_mode = each.value.deployment_mode
}
# THESE VARIABLES WE ARE SENDING TO VARS.TF IN RABBITMQ MODULE AND WE USE IT IN MAIN.TF OF RABBITMQ MODULE

output "vpc" {
  value = module.vpc
}
# double quote string, for expressions no need

# we lookup for module vpc, inside vpc module we look for vpc name(which we provide at main.tfvars),
# we used each.value because we declared vpc_name value as main in docdb at main.tfvars
# inside vpc_name again we need to look for private subnet id's, so again we use lookup of lookup
# inside that we have app, db, web, so we need db, again lookup and we declared subnets_name at .tfvars so we use its value
# inside db we have subnet_ids, one more lookup
# LooKup looks for data from output.tf in vpc module
# this id's were fetched by main.tf of docdb module for grouping purpose only

# Everything we need to maintain is modules from git-side

