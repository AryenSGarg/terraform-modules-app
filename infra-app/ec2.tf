resource "aws_key_pair" "terra-server-key" {
  key_name   = "${var.env}-infra-app-key"
  public_key = file("${path.module}/../terra-key-ec2.pub")
  tags = {
    Environment = var.env
  }
}
resource "aws_default_vpc" "default" {
}
resource "aws_security_group" "My_SG" {
  name        = "${var.env}-infra-app-sg"
  description = "this will add a TF generated sg"
  vpc_id      = aws_default_vpc.default.id #interpolation
  tags = {
    Name = "${var.env}-infra-app-sg"
    Environment = var.env
  }
  #inbound rule
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH from anywhere"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP from anywhere"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all out bound traffic"
  }
}
resource "aws_instance" "My_EC2" {
  count = var.instance_count #meta argument to create n instances
#   for_each = tomap({
#     "ts-automate-micro" = "t3.micro"
#     "ts-automate-medium" = "c7i-flex.large"
#     "ts-automate-small" = "t3.small"
#   }) #meta argument to create n instances with different types
  depends_on = [ aws_security_group.My_SG, aws_key_pair.terra-server-key ]
  key_name        = aws_key_pair.terra-server-key.key_name
  security_groups = [aws_security_group.My_SG.name]
  ami             = var.ec2_ami_id 
  instance_type   = var.instance_type
  root_block_device {
    volume_size = var.env == "prod" ? 20 : 10
    volume_type = "gp3"
  }
  tags = {
    Name = "${var.env}-infra-app-instance"
    Environment = var.env
  }
  
}
