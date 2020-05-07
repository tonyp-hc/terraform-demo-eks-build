variable "region" {}

variable "env" {}

variable "owner" {}

variable "ttl" {}

provider "aws" {
  version = ">= 2.28.1"
}

