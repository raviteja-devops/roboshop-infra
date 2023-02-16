env = "dev"
default_vpc_id = "vpc-0380e34c4b82831a1"


vpc = {
  main = {
    cidr_block = "10.0.0.0/16"
    availability_zone = ["us-east-1a", "us-east-1b"]
    public_subnets = {
      public = {
        name = "public"
        cidr_block = ["10.0.0.0/24", "10.0.1.0/24"]
        internet_gw = true
      }
    }
    private_subnets = {
      web = {
        name = "web"
        cidr_block = ["10.0.2.0/24", "10.0.3.0/24"]
        nat_gw = true
      }
      app = {
        name = "app"
        cidr_block = ["10.0.4.0/24", "10.0.5.0/24"]
        nat_gw = true
      }
      db = {
        name = "db"
        cidr_block = ["10.0.6.0/24", "10.0.7.0/24"]
        nat_gw = true
      }
    }

  }
}

# WE ARE RUNNING TWO LOOPS: public_subnets , private_subnets
# CREATED SUBNETS INSIDE THE VPC BLOCK