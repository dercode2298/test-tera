
env_prefix                             = "dev"
vpc_name                               = "dev_env"
cidrvpc                                = "10.0.0.0/16"
enable_nat_gateway                     = true
single_nat_gateway                     = true
enable_dns_hostnames                   = true
create_database_subnet_group           = true
create_database_subnet_route_table     = true
create_database_internet_gateway_route = true
enable_flow_log                        = true
create_flow_log_cloudwatch_iam_role    = true
create_flow_log_cloudwatch_log_group   = true
eks_config = {
  cluster_name                                   = "der"
  cluster_version                                = "1.30"
  min_size                                       = 3
  max_size                                       = 9
  eks_managed_node_group_defaults_instance_types = ["t2.2xlarge", "t2.large"]
  instance_type                                  = "t2.2xlarge"
  instance_types                                 = ["t2.2xlarge", "t2.large"]
  manage_aws_auth_configmap                      = true
  endpoint_public_access                         = true
  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::629526135429:user/joe-dev"
      username = "joe-dev"
      groups   = ["system:masters"]
    },
  ]
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"],
  eks_cw_logging                       = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}
vm-config = {
  vm1 = {
    instance_type = "t2.small",
    tags = {
      "ext-name" = "vm2"
      "funct"    = "purpose test"
    }
  },
  vm2 = {
    instance_type = "t2.medium",
    tags          = {}
  }
}
bastion_definition = {
  "bastion" = {
    associate_public_ip_address = false
    bastion_ami                 = "ami-04a37924ffe27da53"
    bastion_instance_class      = "t2.micro"
    bastion_monitoring          = true
    bastion_name                = "bastion"
    bastion_public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWBo4K5WRbXPsldPwfV+OklXw+Sa8Rt+fJWPW4xGy/QL2M9j+PDaH4N+Lh29GanaNugMpmzGgDH0cb3DtgSbBlld9YKpO57Ew4alAjoIm/3qJRIIdTu8xMrvm8dvSEs760/MUoqxrt04ExPmvghy3hoyTBpYOwUWnc8R2KP5gmrzldbt1lyKytHujHhFel4aeefxctRFZTfbt7+2X5QE4dMB7po55soxTkcGRyghd8/RbJJYi1jvuA5zU1ecpetgu6DtPkcKWKJMz+e6y2N4xHyg8r8UU28O4eJ+LXQQA48HbX8zXzwteSOBS7b1C42yXFwnQXct+QR2X7D88GkAJt rsa-key-20220711"
    trusted_ips                 = ["58.187.120.129/32"]
    user_data_base64            = null
    ext-tags = {
      "fucnt" = "demo-tf"
    }
  }
}
cluster_endpoint_public_access = true
