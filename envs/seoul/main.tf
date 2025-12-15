module "network" {
  source = "../../modules/network"

  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  rds_subnets     = var.rds_subnets
  existing_nat_gateway_id  = var.existing_nat_gateway_id
}


module "rds" {
  source = "../../modules/rds"

  cluster_identifier = var.cluster_identifier

  engine         = var.engine
  engine_version = var.engine_version

  master_username = var.master_username
  master_password = var.master_password

  instance_class = var.instance_class
  instance_count = var.instance_count
  instance_identifiers = var.instance_identifiers

  db_subnet_group_name = var.db_subnet_group_name
  subnet_ids           = var.subnet_ids

  vpc_security_group_ids = var.vpc_security_group_ids

  storage_encrypted   = var.storage_encrypted
  kms_key_id           = var.kms_key_id
  deletion_protection = var.deletion_protection

  monitoring_interval  = var.monitoring_interval
  monitoring_role_arn = var.monitoring_role_arn

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
}

module "security_group" {
  source = "../../modules/security-group"

  project_name = var.project_name
  vpc_id       = module.network.vpc_id
  app_port     = var.app_port
  db_port      = var.db_port
}

module "alb" {
  source = "../../modules/alb"

  alb_name            = "gfs-alb"
  vpc_id              = module.network.vpc_id
  subnet_ids         = values(module.network.public_subnet_ids)
  security_group_ids  = [module.security_group.alb_sg_id]

  target_group_name     = "gfs-target"
  target_group_port     = 8080
  target_group_protocol = "HTTP"

  listener_port     = 80
  listener_protocol = "HTTP"
}

module "compute" {
  source = "../../modules/compute"

  launch_template_name = var.launch_template_name
  ami_id               = var.ami_id
  instance_type        = var.instance_type

  iam_instance_profile = var.iam_instance_profile
  security_group_ids   = var.security_group_ids

  user_data_path = var.user_data_path

  key_name              = var.key_name
  enable_monitoring     = var.enable_monitoring

  metadata_http_endpoint = var.metadata_http_endpoint
  metadata_http_tokens   = var.metadata_http_tokens
  metadata_hop_limit     = var.metadata_hop_limit
  instance_metadata_tags = var.instance_metadata_tags

  root_device_name = var.root_device_name
  root_volume_size = var.root_volume_size
  root_volume_type = var.root_volume_type
}

module "asg" {
  source = "../../modules/asg"

  asg_name      = var.asg_name
  instance_name = var.instance_name

  subnet_ids = var.asg_subnet_ids   # ← 여기

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  health_check_grace_period = var.health_check_grace_period

  target_group_arns  = var.target_group_arns
  launch_template_id = var.launch_template_id
}
