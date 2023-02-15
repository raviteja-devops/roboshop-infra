env = "dev"
default_vpc_id = "vpc-0380e34c4b82831a1"


vpc = {
  main = {
    cidr_block = "10.0.0.0/16"
  }
}


subnets = {
  public = {
    name = "public"
    vpc_name = "main"
    cidr_block = ["10.0.0.0/24", "10.0.1.0/24"]
    availability_zone = ["us-east-1a", "us-east-1b"]
  }
#  web = {

#  }
#  app = {

#  }
#  db = {

#  }
}


# Want to send these details to module at roboshop-infra -- main.tf



# availability_zones create the subnets in given availability_zones only
# 'subnets_cidr' this is the data we need to send to roboshop-infra, main.tf
# also we declare variable at 'tf-module-vpc' - vars.tf
# and we are providing that declared variable at 'tf-module-vpc' - main.tf
# because we are creating 2 subnets we use count with length function
# how many number of subnets are there those many times i want to iterate