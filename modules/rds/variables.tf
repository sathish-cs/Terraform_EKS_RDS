variable "ami_id" {
  type    = string
  default = "ami-0e8e39877665a7c92" # Amazon Linux  
}

variable "int_type" {
  type    = string
  default = "t2.small"

}

variable "public_subnet" {}

variable "rds_subnet" {}

variable "vpc" {}

variable "tags" {}

variable "db" {}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = "3306"

}

variable "name" {
  type    = string
  default = "db-subnet"
}

variable "cluster_name" {}

variable "instance_class" {
  type    = string
  default = "db.t2.small"
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

variable "security_group_bastion" {
  description = "The name of bastion server Security Group"
  default     = "bastion-sg"
}

variable "security_group_aurora" {
  description = "The name of aurora server Security Group"
  default     = "rds-aurora-sg"
}