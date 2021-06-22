output "rds-writer" {
  value = module.rds.rds-endpoint
}

output "rds-reader" {
  value = module.rds.rds-reader
}

output "bastion-public-ip" {
  value = module.rds.bastion_public_ip
}

output "eks_cluster_endpoint" {
  value = module.eks.eks_cluster
}

output "db_user" {
  value = module.rds.rds_username
}

output "eks_cluster_name" {
  value = module.eks.eks_cluster_name
}