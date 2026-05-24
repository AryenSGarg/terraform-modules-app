variable "env" {
  description = "This is the env for infra"
  type = string
}
variable "bucket_name" {
  description = "This is the bucket name"
  type = string
}
variable "instance_count" {
  description = "This is the no. of instances"
  type = number
}
variable "instance_type" {
    description = "This is the type of instance"
    type = string
}
variable "ec2_ami_id" {
  description = "this is the ami id of instance"
  type = string
}
variable "hash_key" {
  description = "This is the hash key for the DynamoDB table"
  type = string
}