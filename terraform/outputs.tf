output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "user_id" {
  value = data.aws_caller_identity.current.user_id
}

output "region" {
  value = data.aws_region.current.name
}

output "private_ip_instance" {
  value = aws_instance.netology_ubuntu.private_ip
}

output "network_id" {
  value = aws_instance.netology_ubuntu.subnet_id
}