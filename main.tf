resource "aws_s3_bucket" "query_results" {
  bucket_prefix = var.query_results_bucket_prefix
  acl           = var.acl

  versioning {
    enabled = var.versioning_enabled
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "query_results" {
  bucket = aws_s3_bucket.query_results.id

  block_public_acls       = var.query_results_bucket_public_access.block_public_acls
  block_public_policy     = var.query_results_bucket_public_access.block_public_policy
  ignore_public_acls      = var.query_results_bucket_public_access.ignore_public_acls
  restrict_public_buckets = var.query_results_bucket_public_access.restrict_public_buckets
}


resource "aws_athena_database" "db" {
  name   = var.athena_db_name
  bucket = aws_s3_bucket.query_results.id
}

# Init by Query
resource "aws_athena_named_query" "table_init" {
  count     = var.init_by_query ? 1 : 0
  name      = "table_init"
  workgroup = var.athena_workgroup
  database  = aws_athena_database.db.name
  query     = var.table_init_query
}

resource "null_resource" "table_init" {
  count = var.init_by_query ? 1 : 0
  provisioner "local-exec" {
    command = "aws athena start-query-execution --query-string \"${aws_athena_named_query.table_init[0].query}\" --work-group '${var.athena_workgroup}' --query-execution-context Database=${aws_athena_database.db.name},Catalog=${var.athena_catalog} --result-configuration 'OutputLocation=s3://${aws_s3_bucket.query_results.id}' --profile ${var.aws_profile}"
  }
}

# Init by crawler
