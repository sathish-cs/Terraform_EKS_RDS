output "rds-endpoint" {
  value = aws_rds_cluster.cluster.endpoint
}

output "rds-reader" {
  value = aws_rds_cluster.cluster.reader_endpoint
}

output "rds_username" {
  value = aws_rds_cluster.cluster.master_username
}

output "bastion_security_group" {
  value = aws_security_group.bastion-sg.id
}

output "bastion_public_ip" {
  value = aws_instance.Public.public_ip

}

output "ssh_key" {
  value = aws_key_pair.key.key_name
}

