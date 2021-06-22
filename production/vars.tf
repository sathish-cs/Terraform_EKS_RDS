variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_cidr" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_cidr" {
  type    = list(any)
  default = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "avail_zone" {
  type    = list(any)
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "public_subnet_names" {
  type    = list(any)
  default = ["Production-Public-Subnet-1", "Production-Public-Subnet-2"]
}

variable "private_subnet_names" {
  type    = list(any)
  default = ["Production-Private-Subnet-1", "Production-Private-Subnet-2"]
}

variable "tags" {
  type    = string
  default = "Production"
}


variable "ami_id" {
  type    = string
  default = "ami-0bad4a5e987bdebde"
}

variable "int_type" {
  type    = string
  default = "t2.small"

}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = "3306"

}

variable "name" {
  description = "Name given resources"
  type        = string
  default     = "db-subnet"
}

variable "cluster_name" {
  type    = string
  default = "aurora-production"
}

variable "instance_class" {
  type    = string
  default = "db.t2.small"
}

variable "db" {
  type = string
  default = "Production"  
}
variable "username" {
  type    = string
  default = "master"
}

variable "password" {
  type    = string
  default = "password"
}

variable "engine" {
  description = "Aurora database engine type"
  type        = string
  default     = "aurora"
}

variable "engine_version" {
  description = "Aurora database engine version."
  type        = string
  default     = "5.6.10a"
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true."
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "How long to keep backups for (in days)"
  type        = string
  default     = 7
}

variable "apply_immediately" {
  description = "Determines whether or not any DB modifications are applied immediately, or during the maintenance window"
  type        = bool
  default     = false
}

variable "backup_window" {
  description = "The daily time range ( in UTC ) during which automated backups are created if they are enabled"
  type        = string
  default     = "09:00-10:00"
}

variable "final_snapshot" {
  description = "Ignoring final snapshot due to bug which does'nt allow to destroy"
  type        = bool
  default     = true
}

variable "cluster-name" {
  type    = string
  default = "Production-EKS"
}

variable "cluster_role_name" {
  description = "Role Name of cluster"
  default     = "Production-EKS-Role"
}
variable "node_role_name" {
  description = "Role Name of Node"
  default     = "Production-EKS-Node-Role"

}
variable "node_group_name" {
  description = "Name of Node Group"
  default     = "Production"
}

variable "security_group_name" {
  description = "The name of EKS Cluster Security Group"
  default     = "EKS-Production"
}

variable "security_group_bastion" {
  description = "The name of bastion server Security Group"
  default     = "bastion-sg"
}


variable "security_group_aurora" {
  description = "The name of bastion server Security Group"
  default     = "rds-aurora-sg"
}

variable "eks_cluster_name" {
  default  = "EKS-Cluster-Production"
}