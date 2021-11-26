variable "acl" {
  description = "The canned ACL to apply. Defaults to 'private'"
  type        = string
  default     = "private"
}

variable "athena_db_name" {
  description = "Name of the Athena DB you want to create"
  type        = string
  default     = "my_athena_db"
}

variable "athena_catalog" {
  description = "Name of the Data Catalog to use"
  type        = string
  default     = "AwsDataCatalog"
}

variable "athena_workgroup" {
  description = "The workgroup to run the query in"
  type        = string
  default     = "primary"
}

variable "aws_profile" {
  description = "local AWS profile to use when table_init is set to true"
}

variable "init_by_query" {
  description = "Optional Athena query to initialize a table. Query will be executed locally via AWS cli"
  type        = bool
  default     = false
}

variable "named_query_name" {
  description = "The plain language name for the query. Maximum length of 128"
  type        = string
  default     = "MyAthenaQuery"
  validation {
    condition     = length(var.named_query_name) <= 128
    error_message = "The query name cannot be longer than 128 characters."
  }
}

variable "query_results_bucket_prefix" {
  description = "Prefix of bucket created to store Athena query results"
  type        = string
  default     = "my-athena-query-results"
}

variable "query_results_bucket_public_access" {
  description = "Configuration for the public access block on the Athena query results S3 bucket"
  type = object({
    block_public_acls       = bool
    block_public_policy     = bool
    ignore_public_acls      = bool
    restrict_public_buckets = bool
  })
  default = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}

variable "table_init_query" {
  description = "If table_init is set to true, this query will be run first to initialize a table"
  type        = string
  default     = ""
}

variable "versioning_enabled" {
  description = "Boolean toggle for enabling versioning on Athena query results S3 bucket"
  type        = bool
  default     = false
}