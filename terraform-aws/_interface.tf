# Required variables
variable "environment_name" {
  description = "Environment Name"
}

# Optional variables
variable "cluster_size" {
  default     = "3"
  description = "Number of instances to launch in the cluster"
}

variable "consul_as_server" {
  default     = "false"
  description = "Run the consul agent in server mode: true/false"
}

variable "consul_version" {
  default     = "0.8.3"
  description = "Consul Agent version to use ie 0.8.3"
}

variable "instance_type" {
  default     = "m4.large"
  description = "AWS instance type to use eg m4.large"
}

variable "os" {
  # case sensitive for AMI lookup
  default     = "RHEL"
  description = "Operating System to use ie RHEL or Ubuntu"
}

variable "os_version" {
  default     = "7.3"
  description = "Operating System version to use ie 7.3 (for RHEL) or 16.04 (for Ubuntu)"
}

variable "region" {
  default     = "us-west-1"
  description = "Region to deploy nomad cluster ie us-west-1"
}

variable "vault_use_tls" {
  default     = "true"
  description = "Use TLS for vault communication: true/false"
}

variable "vault_version" {
  default     = "0.7.2"
  description = "Vault version to use ie 0.7.2"
}

# Outputs
output "bastion_ips_public" {
  value = ["${module.network-aws.bastion_ips_public}"]
}

output "consul_asg_id" {
  value = "${module.consul-aws.asg_id}"
}

output "consul_client_sg_id" {
  value = "${module.consul-aws.consul_client_sg_id}"
}

output "consul_server_sg_id" {
  value = "${module.consul-aws.consul_server_sg_id}"
}

output "vault_asg_id" {
  value = "${module.vault-aws.asg_id}"
}

output "private_key_data" {
  value = "${module.ssh-keypair-aws.private_key_data}"
}

output "ssh_key_name" {
  value = "${module.ssh-keypair-aws.ssh_key_name}"
}
