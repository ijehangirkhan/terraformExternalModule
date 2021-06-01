output "db_output" {
  value ={
    private_ip = aws_instance.DBServer.private_ip
  }
}