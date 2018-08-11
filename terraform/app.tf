/* 
Provider
*/
provider "aws" {
  region  = "${var.region}"
  version = "~> 1.1"
}

/*
Configuration Settings
*/
data "aws_caller_identity" "current" {}
variable "region" {
  default = "${var.region}"
}

/*
Lambda API Gateway Module
*/
module "lambda_api_gateway" {
  source               = "github.com/techjacker/terraform-aws-lambda-api-gateway"

  # Tags
  project              = "twitter-knock-knock-joke"
  service              = "webhook-client"
  owner                = "Jordan Chalupka"
  costcenter           = "webhook-client"

  # VPC
  vpc_cidr             = "10.0.0.0/16"
  public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
  nat_cidr             = ["10.0.5.0/24", "10.0.6.0/24"]
  igw_cidr             = "10.0.8.0/24"
  azs                  = ["us-east-1a"]

  # Lambda
  lambda_zip_path      = "dist/client.zip"
  lambda_handler       = "src/client/main"
  lambda_runtime       = "go1.x"
  lambda_function_name = "JokeClient"

  # API Gateway
  region               = "${var.region}"
  account_id           = "${data.aws_caller_identity.current.account_id}"
}