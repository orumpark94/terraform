output "instance_id" {
  value = aws_instance.minimal.id
}

output "public_ip" {
  value = aws_instance.minimal.public_ip
}
