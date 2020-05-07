module "worker_group_mgmt_one" {
  source  = "app.terraform.io/TonyPulickal/security-group/aws"
  version = "3.8.0"
  name    = "worker_group_mgmt_one"
  vpc_id = module.vpc.vpc_id
  ingress_cidr_blocks      = ["10.0.0.0/8"]
  ingress_rules           = ["ssh-tcp"] 
}

module "worker_group_mgmt_two" {
  source  = "app.terraform.io/TonyPulickal/security-group/aws"
  version = "3.8.0"
  name    = "worker_group_mgmt_two"
  vpc_id = module.vpc.vpc_id
  ingress_cidr_blocks      = ["192.168.0.0/16"]
  ingress_rules           = ["ssh-tcp"] 
}

module "all_worker_mgmt" {
  source  = "app.terraform.io/TonyPulickal/security-group/aws"
  version = "3.8.0"
  name    = "all_worker_management"
  vpc_id = module.vpc.vpc_id
  ingress_cidr_blocks      = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  ingress_rules           = ["ssh-tcp"] 
}
