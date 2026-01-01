module "network" {
  source = "../../modules/network"

  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  rds_subnets     = var.rds_subnets
  use_existing_nat_gateway = true
  existing_nat_gateway_id = "nat-085fbb51331ff6972"
}

module "security_group" {
  source = "../../modules/security-group"

  project_name                  = var.project_name
  vpc_id                        = module.network.vpc_id
  app_port                      = var.app_port
  db_port                       = var.db_port
  additional_db_source_sg_ids = var.additional_db_source_sg_ids
}

module "rds" {
  source = "../../modules/rds"

  is_primary = false

  global_cluster_identifier = "gfs-global-db"
  cluster_identifier        = "gfs-virginia-db"

  engine         = "aurora-mysql"
  engine_version = "8.0.mysql_aurora.3.04.1"

  subnet_ids             = values(module.network.rds_subnet_ids)
  vpc_security_group_ids = [module.security_group.db_sg_id]

  instance_class = "db.r6g.large"
  instance_count = 1

  deletion_protection = false
}

module "asg" {
  source = "../../modules/asg"

  asg_name      = var.asg_name
  instance_name = var.instance_name

  subnet_ids = values(module.network.private_subnet_ids)

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  health_check_grace_period = var.health_check_grace_period

  target_group_arns  = [module.alb.target_group_arn]
  launch_template_id = module.compute.launch_template_id
}

module "alb" {
  source = "../../modules/alb"

  alb_name   = "gfs-alb"
  vpc_id     = module.network.vpc_id
  subnet_ids = values(module.network.public_subnet_ids)

  security_group_ids = [module.security_group.alb_sg_id]

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
  security_group_ids   = [module.security_group.app_sg_id]

  user_data_path = var.user_data_path

  enable_monitoring = var.enable_monitoring

  metadata_http_endpoint = var.metadata_http_endpoint
  metadata_http_tokens   = var.metadata_http_tokens
  metadata_hop_limit     = var.metadata_hop_limit
  instance_metadata_tags = var.instance_metadata_tags

  root_device_name = var.root_device_name
  root_volume_size = var.root_volume_size
  root_volume_type = var.root_volume_type
}

module "sqs" {
  source = "../../modules/sqs"

  queue_name                = "gfs-virginia-job-queue"
  visibility_timeout        = 300
  message_retention         = 345600
  receive_wait_time_seconds = 20
  max_message_size          = 1048576
}

module "redis" {
  source = "../../modules/redis"

  project_name             = var.project_name
  replication_group_id     = var.redis_replication_group_id
  node_type                = var.redis_node_type
  vpc_id                   = module.network.vpc_id
  subnet_ids               = values(module.network.private_subnet_ids)
  source_security_group_id = module.security_group.app_sg_id
}
