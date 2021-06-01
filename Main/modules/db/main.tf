
resource "aws_instance" "DBServer" {
  key_name = "JehangirKP"
  ami           = var.main_settings.db_ami
  instance_type = var.main_settings.db_instance_type
  associate_public_ip_address = false
  vpc_security_group_ids = [var.sg_details.db_sg_id]
  subnet_id = var.vpc_details.private_subnet[0].id
  user_data =  "${file("${path.module}/scripts/DBServer.sh")}"

  tags = {
    Name = "${terraform.workspace}-DBServer"
  }
}