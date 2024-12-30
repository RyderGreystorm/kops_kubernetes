module "kops-server" {
  source             = "./modules"
  cidr               = var.cidr
  availability_zones = var.availability_zones
  pub-cidr           = var.pub-cidr
  pub-key            = var.priv-key
  priv-key           = var.priv-key
  instance-type      = var.instance-type
  volume-size        = var.volume-size
}

# Output the name servers from the module
output "route53_name_servers" {
  value = module.kops-server.name_servers
}