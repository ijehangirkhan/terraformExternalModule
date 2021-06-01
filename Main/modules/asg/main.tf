data "template_file" "init" {
  template = "${file("${path.module}/scripts/WebServer.sh")}"
  vars = {
    private_ip = "${var.db_private_ip}"
  }
}


resource "aws_launch_template" "LaunchTemplate" {
  name = "${terraform.workspace}-LaunchTemplate"
  description = "Launch Template for Web Server"
  image_id = var.main_settings.db_ami
  instance_type = var.main_settings.db_instance_type
  key_name = var.main_settings.keypair

  vpc_security_group_ids = [var.sg_details.web_sg_id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${terraform.workspace}-WebServer"
    }
  }

  user_data = "${base64encode(data.template_file.init.rendered)}"

  tags = {
    Name = "${terraform.workspace}-LaunchTemplate"
  }
}


resource "aws_autoscaling_group" "ASG" {
  desired_capacity    = var.main_settings.desired_size
  max_size            = var.main_settings.maximum_size
  min_size            = var.main_settings.minimum_size
  health_check_grace_period = var.main_settings.health_check_time
  target_group_arns = [var.alb_details.target_group_arn]
  
  vpc_zone_identifier = var.vpc_details.public_subnet.*.id
  launch_template {
    id      = aws_launch_template.LaunchTemplate.id
    version = "$Latest"
  }
}
