env = "dev"
default_vpc_id = "vpc-0380e34c4b82831a1"

vpc = {
  main = {
    cidr_block = "10.0.0.0/16"
    public_subnets_cidr = ["10.0.0.0/24", "10.0.1.0/24"]
    private_subnets_cidr = ["10.0.2.0/24", "10.0.3.0/24"]
  }
}
# Want to send these details to module at roboshop-infra -- main.tf
# we cut cidr block into 2 pieces


# 'subnets_cidr' this is the data we need to send to roboshop-infra, main.tf
# also we declare variable at 'tf-module-vpc' - vars.tf
# and we are providing that declared variable at 'tf-module-vpc' - main.tf
# because we are creating 2 subnets we use count with length function
# how many number of subnets are there those many times i want to iterate