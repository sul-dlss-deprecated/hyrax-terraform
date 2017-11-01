output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.hyrax_vpc.vpc_id}"
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = "${module.hyrax_vpc.default_security_group_id}"
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = "${join(",", module.hyrax_vpc.private_subnets)}"
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = "${join(",", module.hyrax_vpc.public_subnets)}"
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = "${join(",", module.hyrax_vpc.database_subnets)}"
}

output "database_subnet_group" {
  description = "ID of database subnet group"
  value       = "${module.hyrax_vpc.database_subnet_group}"
}

output "elasticache_subnets" {
  description = "List of IDs of elasticache subnets"
  value       = "${join(",", module.hyrax_vpc.elasticache_subnets)}"
}

output "elasticache_subnet_group" {
  description = "ID of elasticache subnet group"
  value       = "${module.hyrax_vpc.elasticache_subnet_group}"
}

output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = "${module.hyrax_vpc.nat_public_ips}"
}

output "vpc_endpoint_s3_id" {
  description = "The ID of VPC endpoint for S3"
  value       = "${module.hyrax_vpc.vpc_endpoint_s3_id}"
}

output "private_hosted_zone_id" {
  description = "The ID of the private hosted zone"
  value       = "${aws_route53_zone.hyrax.id}"
}
