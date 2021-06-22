# Bastion Server to access RDS
resource "aws_instance" "Public" {
  ami                    = var.ami_id
  instance_type          = var.int_type
  subnet_id              = var.public_subnet
  vpc_security_group_ids = ["${aws_security_group.bastion-sg.id}"]
  key_name               = aws_key_pair.key.key_name
  tags = {
    Name = "${var.tags}-bastion"
  }
}
resource "aws_key_pair" "key" {
  key_name   = "ssh-key"
  public_key = tls_private_key.ssh-key.public_key_openssh
}


resource "local_file" "pem_file" {
  filename             = pathexpand("./mykey.pem")
  file_permission      = "600"
  directory_permission = "700"
  sensitive_content    = tls_private_key.ssh-key.private_key_pem
}

resource "tls_private_key" "ssh-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_security_group" "bastion-sg" {
  vpc_id = var.vpc

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_bastion
  }
}

#DB Subnet Group for RDS
resource "aws_db_subnet_group" "main" {
  name        = var.name
  description = "For Aurora cluster var.name}"
  subnet_ids  = var.rds_subnet
  tags = {
    "Name" = "aurora"
  }
}

#Aurora RDS 
resource "aws_rds_cluster_instance" "cluster_instances" {
  identifier         = "${var.cluster_name}-instance"
  cluster_identifier = aws_rds_cluster.cluster.id
  instance_class     = var.instance_class
}

resource "aws_rds_cluster" "cluster" {
  cluster_identifier      = var.cluster_name
  engine                  = var.engine
  engine_version          = var.engine_version
  database_name           = var.db
  master_username         = var.username
  master_password         = var.password
  port                    = var.port
  skip_final_snapshot     = var.final_snapshot
  db_subnet_group_name    = aws_db_subnet_group.main.id
  vpc_security_group_ids  = ["${aws_security_group.aurora-sg.id}"]
  preferred_backup_window = var.backup_window
  deletion_protection     = var.deletion_protection
  backup_retention_period = var.backup_retention_period
}


locals {
  aurora_db_password = {
    root = "password"
  }
}

#RDS security group
resource "aws_security_group" "aurora-sg" {
  name   = "aurora-security-group"
  vpc_id = var.vpc

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "var.security_group_aurora"
    Env  = var.tags
  }
}

resource "aws_security_group_rule" "rds-ingress" {
  source_security_group_id = aws_security_group.bastion-sg.id
  from_port                = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.aurora-sg.id
  to_port                  = 3306
  type                     = "ingress"
}