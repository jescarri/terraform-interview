resource "aws_security_group" "sg" {
  name   = "my-app_sg"
  vpc_id = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = -1
    from_port   = 0
    to_port     = 0
  }

  /*ICMP echo reply*/
  ingress {
    cidr_blocks = ["0.0.0.0/0"]

    protocol  = "icmp"
    from_port = 0
    to_port   = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 0
    to_port     = 0
  }

  tags = tomap(
    { "Name"        = "myapp",
      "Environment" = var.environment,
    }
  )
}
