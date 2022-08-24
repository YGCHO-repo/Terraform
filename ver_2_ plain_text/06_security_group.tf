# Default SG Network Disable
resource "aws_default_security_group" "this" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "test-tf-default-sg" }
}

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#                        Bastion SVR SG
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
resource "aws_security_group" "bastion_sg" {
  description = "Bastion Server Security group"
  name        = "Bastion-SG"
  vpc_id      = aws_vpc.this.id

  # ingress{
  #     description = "SSH Inbound Port"
  #     protocol = "tcp"
  #     from_port = 22
  #     to_port = 22
  #     cidr_blocks = ["0.0.0.0/0"]
  # }
  egress {
    description = "SSH Outbound Port"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = { Name = "test-tf-bastion-sg" }
}

# WEB SVR SG
resource "aws_security_group" "web_sg" {
  description = "WEB Server Security group"
  name        = "WEB-SG"
  vpc_id      = aws_vpc.this.id

  # ingress{
  #     description = "WEB server Security group"
  #     protocol = "tcp"
  #     from_port = 80
  #     to_port = 80
  #     cidr_blocks = ["0.0.0.0/0"]
  # }
  egress {
    description = "WEB server Security group"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = { Name = "test-tf-web-sg" }
}

# WAS SVR SG
resource "aws_security_group" "was_sg" {
  description = "WAS Server Security group"
  name        = "WAS-SG"
  vpc_id      = aws_vpc.this.id

  # ingress{
  #     description = "WAS server Security group"
  #     protocol = "tcp"
  #     from_port = 8080
  #     to_port = 8080
  #     cidr_blocks = ["0.0.0.0/0"]
  # }
  egress {
    description = "WAS server Security group"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = { Name = "test-tf-was-sg" }
}

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#                         RDS AuroraDB SG
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
resource "aws_security_group" "rds_sg" {
  description = "RDS Datebase Security group"
  name        = "RDS-SG"
  vpc_id      = aws_vpc.this.id

  # ingress {
  #     description = "RDS Datebase Security group"
  #     protocol = "tcp"
  #     from_port = 3306
  #     to_port = 3306
  #     cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    description = "RDS Datebase Security group"
    protocol    = "tcp"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = ["${aws_security_group.was_sg.id}"]
  }
  tags = { Name = "test-tf-rds-sg" }
}


# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#                       ELB SG (ALB type)
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#                       Front (Public zone)
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
resource "aws_security_group" "front_alb_sg" {
  description = "Front ALB Security group"
  name        = "Front-ALB-SG"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Front ALB Security group"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Front ALB Security group"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = { Name = "test-tf-front-alb-sg" }
}

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#                   Backend (Private zone)
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
resource "aws_security_group" "backend_alb_sg" {
  description = "Backend ALB Security group"
  name        = "backend-ALB-SG"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Backend ALB Security group"
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Backend ALB Security group"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = { Name = "test-tf-backend-alb-sg" }
}