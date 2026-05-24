module "dev-infra"{
    source = "./infra-app"
    env = "dev"
    bucket_name = "aryen-dev-bucket"
    instance_count = 1
    instance_type = "t3.small"
    ec2_ami_id = "ami-00a9f44477dd83e3d"
    hash_key = "studentID"
}
module "prod-infra"{
    source = "./infra-app"
    env = "prod"
    bucket_name = "aryen-prod-bucket"
    instance_count = 2
    instance_type = "c7i-flex.large"
    ec2_ami_id = "ami-00a9f44477dd83e3d"
    hash_key = "studentID"
}
module "stage-infra"{
    source = "./infra-app"
    env = "stage"
    bucket_name = "aryen-stage-bucket"
    instance_count = 1
    instance_type = "t3.small"
    ec2_ami_id = "ami-00a9f44477dd83e3d"
    hash_key = "studentID"
}