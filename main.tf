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
        "Action": [
          "logs:CreateLogStream",
          "logs:CreateLogGroup"
        ],
        "Resource": var.edge_permissions ? "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:*" : "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
      },
      {
        "Effect": "Allow",
        "Action": "logs:PutLogEvents",
        "Resource": var.edge_permissions ? "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:*:log-stream:*" : "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${aws_lambda_function.this.function_name}:*"
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
  handler           = "${var.entrypoint_file}.${var.entrypoint_function}"
  timeout           = var.timeout
}
