env = "prod"
default_vpc_id = "vpc-0380e34c4b82831a1"
bastion_cidr = ["172.31.14.81/32"]
monitor_cidr   = ["172.31.4.226/32"]


vpc = {
  main = {
    cidr_block = "10.100.0.0/16"
    availability_zone = ["us-east-1a", "us-east-1b"]
    public_subnets = {
      public = {
        name = "public"
        cidr_block = ["10.100.0.0/24", "10.100.1.0/24"]
        internet_gw = true
      }
    }
    private_subnets = {
      web = {
        name = "web"
        cidr_block = ["10.100.2.0/24", "10.100.3.0/24"]
        nat_gw = true
      }
      app = {
        name = "app"
        cidr_block = ["10.100.4.0/24", "10.100.5.0/24"]
        nat_gw = true
      }
      db = {
        name = "db"
        cidr_block = ["10.100.6.0/24", "10.100.7.0/24"]
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
    engine = "aurora-mysql"
    engine_version = "5.7.mysql_aurora.2.11.1"
    number_of_instances = 1
    instance_class = "db.t3.small"
  }
}

elasticache = {
  main = {
    vpc_name = "main"
    subnets_name = "db"
    num_cache_nodes = 1
    node_type       = "cache.t3.micro"
    engine_version  = "6.x"
  }
}

rabbitmq = {
  main = {
    vpc_name = "main"
    subnets_name = "db"
    engine_type = "RabbitMQ"
    engine_version = "3.10.10"
    host_instance_type = "mq.t3.micro"
    deployment_mode = "SINGLE_INSTANCE"
  }
}
# WE ARE SENDING THIS RABBITMQ FOR_EACH LOOP OUT TO MAIN.TF IN INFRA AND WE DECLARED ITS VARIABLE

alb = {
  public = {
    vpc_name = "main"
    subnets_type = "public_subnet_ids"
    subnets_name = "public"
    internal = false
    dns_domain = "www.raviteja.online"
  }
  private = {
    vpc_name = "main"
    subnets_type = "private_subnet_ids"
    subnets_name = "app"
    internal = true
    dns_domain = ''
  }
}
# SUBNET_TYPE IS BASED ON OUTPUTS WE DECLARED IN VPC MODULE


apps = {
  frontend = {
    component = "frontend"
    vpc_name = "main"
    subnets_type = "private_subnet_ids"
    subnets_name = "web"
    allow_cidr_subnets_type = "public_subnets"
    allow_cidr_subnets_name = "public"
    app_port = 80
    max_size = 5
    min_size = 2
    desired_capacity = 2
    instance_type = "t3.micro"
    alb = "public"
    listener_priority = 0
  }
  catalogue = {
    component = "catalogue"
    vpc_name = "main"
    subnets_type = "private_subnet_ids"
    subnets_name = "app"
    allow_cidr_subnets_type = "private_subnets"
    allow_cidr_subnets_name = "app"
    app_port = 8080
    max_size = 5
    min_size = 2
    desired_capacity = 2
    instance_type = "t3.micro"
    alb = "private"
    listener_priority = 100
  }
  user = {
    component = "user"
    vpc_name = "main"
    subnets_type = "private_subnet_ids"
    subnets_name = "app"
    allow_cidr_subnets_type = "private_subnets"
    allow_cidr_subnets_name = "app"
    app_port = 8080
    max_size = 5
    min_size = 2
    desired_capacity = 2
    instance_type = "t3.micro"
    alb = "private"
    listener_priority = 101
  }
  cart = {
    component = "cart"
    vpc_name = "main"
    subnets_type = "private_subnet_ids"
    subnets_name = "app"
    allow_cidr_subnets_type = "private_subnets"
    allow_cidr_subnets_name = "app"
    app_port = 8080
    max_size = 5
    min_size = 2
    desired_capacity = 2
    instance_type = "t3.micro"
    alb = "private"
    listener_priority = 102
  }
  shipping = {
    component = "shipping"
    vpc_name = "main"
    subnets_type = "private_subnet_ids"
    subnets_name = "app"
    allow_cidr_subnets_type = "private_subnets"
    allow_cidr_subnets_name = "app"
    app_port = 8080
    max_size = 5
    min_size = 2
    desired_capacity = 2
    instance_type = "t3.small"
    alb = "private"
    listener_priority = 103
  }
  payment = {
    component = "payment"
    vpc_name = "main"
    subnets_type = "private_subnet_ids"
    subnets_name = "app"
    allow_cidr_subnets_type = "private_subnets"
    allow_cidr_subnets_name = "app"
    app_port = 8080
    max_size = 5
    min_size = 2
    desired_capacity = 2
    instance_type = "t3.micro"
    alb = "private"
    listener_priority = 104
  }
}

# WE ARE RUNNING TWO LOOPS: public_subnets , private_subnets
# CREATED SUBNETS INSIDE THE VPC BLOCK