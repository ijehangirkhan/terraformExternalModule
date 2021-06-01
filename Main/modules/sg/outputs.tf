output "sg_output" {
  value ={
    alb_sg_id  = aws_security_group.ALBSG.id
    web_sg_id  = aws_security_group.WebSG.id
    db_sg_id  = aws_security_group.DBSG.id
  }
}