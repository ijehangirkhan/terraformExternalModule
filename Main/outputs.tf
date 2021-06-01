output "output_data" {
    value = {
        vpc_id = data.terraform_remote_state.vpc.outputs.output_data.vpc_id
        public_subnet_id = data.terraform_remote_state.vpc.outputs.output_data.public_subnet.*.id
        private_subnet_id = data.terraform_remote_state.vpc.outputs.output_data.private_subnet.*.id
        vpc_azs_sum = data.terraform_remote_state.vpc.outputs.output_data.sum_of_vpc_azs
        alb_sg = module.SG.sg_output.alb_sg_id
        web_sg = module.SG.sg_output.web_sg_id
        db_sg = module.SG.sg_output.db_sg_id
        alb_dns = module.ALB.alb_output.ALB_Dns
        db_instance_private_ip = module.DB.db_output.private_ip
    }
}