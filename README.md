# Deploy AWS lambda from zip local file

```tf
module "lambda" {
  source = "git::https://github.com/raphaeljoie/terraform-aws-zip-lambda.git?ref=v0.1.3"
  
  lambda_name = "my_lambda"
  # watch for async and sync JS examples in example directory
  source_path = "./examples/javascript-lambda"
  entrypoint_file = "async-handler" 
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
| <a name="input_description"></a> [description](#input\_description) | Description of what your Lambda Function does. | `string` | `null` | no |
| <a name="input_edge_permissions"></a> [edge\_permissions](#input\_edge\_permissions) | Enable extended log permissions for Lambda@Edge function to register log in any region. https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/edge-functions-logs.html | `bool` | `false` | no |
| <a name="input_entrypoint_file"></a> [entrypoint\_file](#input\_entrypoint\_file) | Name of the file, without extension, in the source\_path directory to execute as entrypoint. Default value `handler` stands for handler.js | `string` | `"handler"` | no |
| <a name="input_entrypoint_function"></a> [entrypoint\_function](#input\_entrypoint\_function) | name of the handler function in the `entrypoint_file`. | `string` | `"handler"` | no |
| <a name="input_lambda_name"></a> [lambda\_name](#input\_lambda\_name) | Name of the lambda function. Must be unique in the region | `string` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Identifier of the function's runtime. See [Runtimes](https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime) for valid values. | `string` | `"nodejs18.x"` | no |
| <a name="input_source_path"></a> [source\_path](#input\_source\_path) | Path to the directory to zip. Archive must be less than XX | `string` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Lambda timeout, in seconds | `number` | `3` | no |
| <a name="input_zip_name"></a> [zip\_name](#input\_zip\_name) | Name of the zip archive, including extension. Default is `${var.lambda_name}.zip` | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | Amazon Resource Name (ARN) identifying your Lambda Function |
| <a name="output_lambda_qualified_arn"></a> [lambda\_qualified\_arn](#output\_lambda\_qualified\_arn) | ARN identifying your Lambda Function Version |
| <a name="output_lambda_version"></a> [lambda\_version](#output\_lambda\_version) | Latest published version of your Lambda Function |
<!-- END_TF_DOCS -->

## TODO
- [ ] Check accepted chars for main file name (accept "-" ?)
- [ ] support for S3 upload
