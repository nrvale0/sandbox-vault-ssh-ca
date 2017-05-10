module "network-aws" {
  source           = "git@github.com:hashicorp-modules/network-aws.git"
  environment_name = "${var.environment_name}"
  os               = "${var.os}"
  os_version       = "${var.os_version}"
  ssh_key_name     = "${module.ssh-keypair-aws.ssh_key_name}"
}

module "ssh-keypair-aws" {
  source       = "git@github.com:hashicorp-modules/ssh-keypair-aws.git"
  ssh_key_name = "${var.environment_name}"
}

module "consul-aws" {
  source       = "git@github.com:hashicorp-modules/consul-aws.git"
  cluster_name = "${var.environment_name}-consul-asg"
  os           = "${var.os}"
  os_version   = "${var.os_version}"
  ssh_key_name = "${module.ssh-keypair-aws.ssh_key_name}"
  subnet_ids   = "${module.network-aws.subnet_private_ids}"
  vpc_id       = "${module.network-aws.vpc_id}"
}

module "vault-aws" {
  source              = "git@github.com:hashicorp-modules/vault-aws.git"
  cluster_name        = "${var.environment_name}-vault-asg"
  consul_server_sg_id = "${module.consul-aws.consul_server_sg_id}"
  consul_as_server    = "${var.consul_as_server}"
  os                  = "${var.os}"
  os_version          = "${var.os_version}"
  ssh_key_name        = "${module.ssh-keypair-aws.ssh_key_name}"
  subnet_ids          = "${module.network-aws.subnet_private_ids}"
  vpc_id              = "${module.network-aws.vpc_id}"
}
