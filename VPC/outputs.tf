output "output_data" {
    value = {
        vpc_id = module.VPC.vpc_output.vpc_id
        public_subnet = module.VPC.vpc_output.public_subnet.*
        private_subnet = module.VPC.vpc_output.private_subnet.*
        sum_of_vpc_azs = module.VPC.vpc_output.vpc_azs
    }
}