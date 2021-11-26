# infra-athena
Example Terraform Module for deploying Athena against an open data registry

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.63 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_athena_database.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/athena_database) | resource |
| [aws_athena_named_query.table_init](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/athena_named_query) | resource |
| [aws_s3_bucket.query_results](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.query_results](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [null_resource.table_init](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl"></a> [acl](#input\_acl) | The canned ACL to apply. Defaults to 'private' | `string` | `"private"` | no |
| <a name="input_athena_catalog"></a> [athena\_catalog](#input\_athena\_catalog) | Name of the Data Catalog to use | `string` | `"AwsDataCatalog"` | no |
| <a name="input_athena_db_name"></a> [athena\_db\_name](#input\_athena\_db\_name) | Name of the Athena DB you want to create | `string` | `"my_athena_db"` | no |
| <a name="input_athena_workgroup"></a> [athena\_workgroup](#input\_athena\_workgroup) | The workgroup to run the query in | `string` | `"primary"` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | local AWS profile to use when table\_init is set to true | `any` | n/a | yes |
| <a name="input_init_by_query"></a> [init\_by\_query](#input\_init\_by\_query) | Optional Athena query to initialize a table. Query will be executed locally via AWS cli | `bool` | `false` | no |
| <a name="input_named_query_name"></a> [named\_query\_name](#input\_named\_query\_name) | The plain language name for the query. Maximum length of 128 | `string` | `"MyAthenaQuery"` | no |
| <a name="input_query_results_bucket_prefix"></a> [query\_results\_bucket\_prefix](#input\_query\_results\_bucket\_prefix) | Prefix of bucket created to store Athena query results | `string` | `"my-athena-query-results"` | no |
| <a name="input_query_results_bucket_public_access"></a> [query\_results\_bucket\_public\_access](#input\_query\_results\_bucket\_public\_access) | Configuration for the public access block on the Athena query results S3 bucket | <pre>object({<br>    block_public_acls       = bool<br>    block_public_policy     = bool<br>    ignore_public_acls      = bool<br>    restrict_public_buckets = bool<br>  })</pre> | <pre>{<br>  "block_public_acls": true,<br>  "block_public_policy": true,<br>  "ignore_public_acls": true,<br>  "restrict_public_buckets": true<br>}</pre> | no |
| <a name="input_table_init_query"></a> [table\_init\_query](#input\_table\_init\_query) | If table\_init is set to true, this query will be run first to initialize a table | `string` | `""` | no |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | Boolean toggle for enabling versioning on Athena query results S3 bucket | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->