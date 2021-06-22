module "vpc" {
  source               = "../modules/vpc/"
  vpc_cidr             = var.vpc_cidr
  public_cidr          = var.public_cidr
  private_cidr         = var.private_cidr
  avail_zone           = var.avail_zone
  public_subnet_names  = var.public_subnet_names
  private_subnet_names = var.private_subnet_names
  vpc_id               = module.vpc.vpc
  tags                 = var.tags
}

module "rds" {
  source                  = "../modules/rds/"
  port                    = var.port
  name                    = var.name
  cluster_name            = var.cluster_name
  instance_class          = var.instance_class
  db                      = var.db
  username                = var.username
  password                = var.password
  engine                  = var.engine
  engine_version          = var.engine_version
  deletion_protection     = var.deletion_protection
  backup_retention_period = var.backup_retention_period
  apply_immediately       = var.apply_immediately
  backup_window           = var.backup_window
  final_snapshot          = var.final_snapshot
  public_subnet           = module.vpc.public_subnet[0]
  rds_subnet              = module.vpc.private_subnet
  vpc                     = module.vpc.vpc
  tags                    = var.tags
}

module "eks" {
  source              = "../modules/eks_cluster/"
  vpc                 = module.vpc.vpc
  public_subnet       = module.vpc.public_subnet
  private_subnet      = module.vpc.private_subnet
  eks-cluster-name    = "EKS-Cluster-Staging"
  cluster_role_name   = "EKS-Role-Staging"
  node_role_name      = "EKS-Node-Role-Staging"
  node_group_name     = "EKS-Workers-Staging"
  security_group_name = "EKS-Cluster-Staging"
  key                 = module.rds.ssh_key
  security_group      = module.rds.bastion_security_group
  tags                = var.tags
}