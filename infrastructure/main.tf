provider "aws" {
  region = var.region
}

# 1. VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "minimal-vpc"
  }
}

# 2. Subnets

# Public Subnet (EC2 용도)
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

# Private Subnet 1 (RDS 용도)
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-1"
  }
}

# Private Subnet 2 (RDS 용도 - AZ 2개 커버)
resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidr_2
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-2"
  }
}

# 3. 인터넷 게이트웨이
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "minimal-igw"
  }
}

# 4. 라우팅 테이블 (Public)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id
}

# 5. 보안 그룹

## Web용 SG (EC2)
resource "aws_security_group" "web_sg" {
  name   = "web-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

## DB용 SG (RDS)
resource "aws_security_group" "db_sg" {
  name   = "db-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id] # EC2에서만 접근 허용
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}

# 6. EC2 (Web/App)
resource "aws_instance" "web_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "web-instance"
  }
}

# 7. DB Subnet Group (AZ 2개 이상 커버)
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [
    aws_subnet.private_subnet.id,
    aws_subnet.private_subnet_2.id
  ]

  tags = {
    Name = "db-subnet-group"
  }
}

# 8. RDS 인스턴스 (MySQL)
resource "aws_db_instance" "mysql" {
  identifier              = "mydb"
  engine                  = "mysql"
  engine_version          = "8.0.35"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = "admin"
  password                = var.db_password
  db_name                    = "mydatabase"
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  publicly_accessible     = false

  tags = {
    Name = "rds-mysql"
  }
}