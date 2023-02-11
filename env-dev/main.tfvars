env = "dev"
default_vpc_id = "vpc-0380e34c4b82831a1"

vpc = {
  main = {
    cidr_block = "10.0.0.0/16"
    subnets_cidr = ["10.0.0.0/17", "10.0.128.0/17"]
  }
}
# Want to send these details to roboshop-infra, main.tf
# we cut cidr block into 2 pieces


# 'subnets_cidr' this is the data we need to send to roboshop-infra, main.tf
# also we declare variable at 'tf-module-vpc' - vars.tf
# and we are providing that declared variable at 'tf-module-vpc' - main.tf
# because we are creating 2 subnets we use count with length function
# how many number of subnets are there those many times i want to iterate