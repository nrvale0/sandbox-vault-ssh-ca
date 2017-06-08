resource "random_id" "environment_name" {
  byte_length = 4
  prefix      = "${var.environment_name_prefix}-"
}

module "network-aws" {
  source           = "git@github.com:hashicorp-modules/network-aws.git?ref=2017-05-31"
  environment_name = "${random_id.environment_name.hex}"
  os               = "${var.os}"
  os_version       = "${var.os_version}"
  ssh_key_name     = "${module.ssh-keypair-aws.ssh_key_name}"
}

module "ssh-keypair-aws" {
  source       = "git@github.com:hashicorp-modules/ssh-keypair-aws.git"
  ssh_key_name = "${random_id.environment_name.hex}"
}

module "consul-aws" {
  source           = "git@github.com:hashicorp-modules/consul-aws.git?ref=2017-06-02"
  cluster_name     = "${random_id.environment_name.hex}-consul-asg"
  cluster_size     = "${var.cluster_size}"
  consul_version   = "${var.consul_version}"
  environment_name = "${random_id.environment_name.hex}"
  instance_type    = "${var.instance_type}"
  os               = "${var.os}"
  os_version       = "${var.os_version}"
  ssh_key_name     = "${module.ssh-keypair-aws.ssh_key_name}"
  subnet_ids       = "${module.network-aws.subnet_private_ids}"
  vpc_id           = "${module.network-aws.vpc_id}"
}

module "vault-aws" {
  source              = "git@github.com:hashicorp-modules/vault-aws.git?ref=2017-06-02"
  cluster_name        = "${random_id.environment_name.hex}-vault-asg"
  cluster_size        = "${var.cluster_size}"
  consul_server_sg_id = "${module.consul-aws.consul_server_sg_id}"
  consul_as_server    = "${var.consul_as_server}"
  environment_name    = "${random_id.environment_name.hex}"
  instance_type       = "${var.instance_type}"
  os                  = "${var.os}"
  os_version          = "${var.os_version}"
  ssh_key_name        = "${module.ssh-keypair-aws.ssh_key_name}"
  subnet_ids          = "${module.network-aws.subnet_private_ids}"
  vault_use_tls       = "${var.vault_use_tls}"
  vpc_id              = "${module.network-aws.vpc_id}"
}
