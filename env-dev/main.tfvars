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


docdb = {
  main = {
    vpc_name = "main"
    subnets_name = "db"
    engine_version = "4.0.0"
    number_of_instances = 1
    instance_class = "db.t3.medium"
  }
}
# WE ARE HARDCODED VPC_NAME, SUBNET_NAME BECAUSE TOMORROW IF WE HAVE 2 VPC'S OR 2 DATABASES THEN WE CAN CLEARLY SAY WHICH VPC/DB WE NEED

rds = {
  main = {
    vpc_name = "main"
    subnets_name = "db"
    engine = "mysql"
    engine_version = "5.7.mysql_aurora.2.03.2"
    number_of_instances = 1
    instance_class = "db.t3.micro"
  }
}


# WE ARE RUNNING TWO LOOPS: public_subnets , private_subnets
# CREATED SUBNETS INSIDE THE VPC BLOCK