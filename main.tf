data "archive_file" "this" {
  type        = "zip"
  source_dir  = var.source_path
  output_path = coalesce(var.zip_name, "${var.lambda_name}.zip")
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "edgelambda.amazonaws.com"
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = "AwsLambda${var.lambda_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "policy" {
  role = aws_iam_role.role.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "logs:CreateLogGroup",
        "Resource": "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": [
          "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${aws_lambda_function.this.function_name}:*"
        ]
      }
    ]
  })
}

resource "aws_lambda_function" "this" {
  filename          = data.archive_file.this.output_path
  function_name     = var.lambda_name
  role              = aws_iam_role.role.arn

  publish           = true

  architectures     = ["x86_64"]
  runtime           = "nodejs18.x"

  source_code_hash  = data.archive_file.this.output_base64sha256
  handler           = "${var.source_main_file}.${var.source_handler_function}"
  timeout           = var.timeout
}
