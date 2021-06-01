output "alb_output" {
  value ={
    ALB_Dns = aws_lb.ApplicationLB.dns_name
    target_group_arn = aws_lb_target_group.TargetGroup.arn
  }
}