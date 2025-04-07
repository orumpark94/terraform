# EC2 Web 인스턴스 출력
output "web_instance_id" {
  description = "Web EC2 인스턴스의 ID"
  value       = aws_instance.web_instance.id
}

output "web_instance_public_ip" {
  description = "Web EC2 인스턴스의 퍼블릭 IP 주소"
  value       = aws_instance.web_instance.public_ip
}

# RDS MySQL 인스턴스 출력
output "rds_endpoint" {
  description = "RDS 인스턴스의 엔드포인트 주소"
  value       = aws_db_instance.mysql.endpoint
}

output "rds_port" {
  description = "RDS 인스턴스의 포트"
  value       = aws_db_instance.mysql.port
}
