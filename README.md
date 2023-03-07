# Deploy AWS lambda from zip local file

```tf
module "lambda" {
  source = "./"
  
  lambda_name = "my_lambda"
  # watch for async and sync JS examples in example directory
  source_path = "./examples/javascript-lambda"
  source_main_file = "async-handler" 
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | >= 2.3.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [archive_file.this](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_lambda_name"></a> [lambda\_name](#input\_lambda\_name) | Name of the lambda function. Must be unique in the region | `string` | n/a | yes |
| <a name="input_source_handler_function"></a> [source\_handler\_function](#input\_source\_handler\_function) | name of the handler function in the source\_main\_file. | `string` | `"handler"` | no |
| <a name="input_source_main_file"></a> [source\_main\_file](#input\_source\_main\_file) | Name of the file, without extension, in the source\_path directory to execute as entrypoint. Default is handler for handler.js | `string` | `"handler"` | no |
| <a name="input_source_path"></a> [source\_path](#input\_source\_path) | Path to the directory to zip. Archive must be less than XX | `string` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Lambda timeout, in seconds | `number` | `3` | no |
| <a name="input_zip_name"></a> [zip\_name](#input\_zip\_name) | Name of the zip archive, including extension. Default is `{var.lambda_name}.zip` | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | Amazon Resource Name (ARN) identifying your Lambda Function |
| <a name="output_lambda_qualified_arn"></a> [lambda\_qualified\_arn](#output\_lambda\_qualified\_arn) | ARN identifying your Lambda Function Version |
| <a name="output_lambda_version"></a> [lambda\_version](#output\_lambda\_version) | Latest published version of your Lambda Function |
<!-- END_TF_DOCS -->

## TODO
- [ ] Check accepted chars for main file name (accept "-" ?)
- [ ] source_main_file to `entrypoint_file`
