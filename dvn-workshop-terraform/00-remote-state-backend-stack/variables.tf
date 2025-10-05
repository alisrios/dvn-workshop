variable "auth" {
  type = object({
    region          = string
    assume_role_arn = string
  })

  default = {
    assume_role_arn = "arn:aws:iam::148761658767:role/Workshop-role"
    region          = "us-east-1"
  }
}

variable "remote_backend" {
  type = object({
    s3_bucket                   = string
    dynamodb_table_name         = string
    dynamodb_table_billing_mode = string
    dynamodb_table_hash_key     = string
    dynamodb_atribute_name      = string
  })

  default = {
    s3_bucket                   = "workshop-s3-remote-backend-bucket"
    dynamodb_table_name         = "workshop-s3-state-locking-table"
    dynamodb_table_billing_mode = "PAY_PER_REQUEST"
    dynamodb_table_hash_key     = "LockID"
    dynamodb_atribute_name      = "S"
  }
}

variable "tags" {
  type = map(string)

  default = {
    Environment = "production"
    Project     = "workshop-devops-na-nuven"
  }

}