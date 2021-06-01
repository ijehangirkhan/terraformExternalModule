resource "aws_security_group" "ALBSG" {
  name        = "ALBSG"
  description = "Security Group for Application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTPS Access from anywhere"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP Access from anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "Allow all Outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${terraform.workspace}-ALBSG"
  }
}


resource "aws_security_group" "WebSG" {
  name        = "WebSG"
  description = "Security Group for Web Server"
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTPS Access from anywhere"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP Access from anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH Access from anywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "Allow all Outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${terraform.workspace}-WebSG"
  }
}


resource "aws_security_group" "DBSG" {
  name        = "DBSG"
  description = "Security Group for Database Server"
  vpc_id      = var.vpc_id
  depends_on = [aws_security_group.WebSG]

  ingress {
    description      = "HTTPS Access from Web Server"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    security_groups  = [
      "${aws_security_group.WebSG.id}",
    ]
  }

  ingress {
    description      = "HTTP Access from Web Server"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [
      "${aws_security_group.WebSG.id}",
    ]
  }

  ingress {
    description      = "Mysql Access from Web Server"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [
      "${aws_security_group.WebSG.id}",
    ]
  }

  ingress {
    description      = "SSH Access from Web Server"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = [
      "${aws_security_group.WebSG.id}",
    ]
  }

  egress {
    description      = "Allow all Outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${terraform.workspace}-DBSG"
  }
}