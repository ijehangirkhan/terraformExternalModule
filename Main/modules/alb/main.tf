resource "aws_lb_target_group" "TargetGroup" {
  name     = "${terraform.workspace}-TargetGroup"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = var.vpc_details.vpc_id
  tags = {
    Name = "${terraform.workspace}-TargetGroup"
  }
}

resource "aws_lb_listener" "ALBListener" {
  load_balancer_arn = aws_lb.ApplicationLB.arn
  port              = "80"
  protocol          = "HTTP"
  tags = {
    Name = "${terraform.workspace}-ALBListener"
  }
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TargetGroup.arn
  }
}


resource "aws_lb" "ApplicationLB" {
  name               = "${terraform.workspace}-ApplicationLB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_details.alb_sg_id]
  subnets            = var.vpc_details.public_subnet.*.id

  tags = {
    Name = "${terraform.workspace}-ApplicationLB"
  }
}