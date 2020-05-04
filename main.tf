variable "region" {}

variable "env" {}

variable "owner" {}

provider "aws" {
  version = ">= 2.28.1"
}

