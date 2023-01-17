resource "aws_iam_role" "lambda_iam_role" {
  name = "LambdaIamRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}


# Policy for SES email sending
data "aws_iam_policy_document" "lambda_ses_policy_document" {
  statement {
    sid = "LambdaSendEmailSES"
    actions = [
      "ses:sendEmail"
    ]
    resources = [
      "*"
      ]
  }
}

resource "aws_iam_policy" "lambda_ses_policy" {
  name   = "LambdaSendEmailSESPolicy"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_ses_policy_document.json
}

resource "aws_iam_role_policy_attachment" "ses_policy_attachment" {
  role = aws_iam_role.lambda_iam_role.name
  policy_arn = aws_iam_policy.lambda_ses_policy.arn
  depends_on = [
    aws_iam_policy.lambda_ses_policy
  ]
}


#Policy for cognito update
data "aws_iam_policy_document" "lamda_update_cognito_documment" {
  statement {
    sid = "LambdaUpdateCognito"
    actions = [
      "cognito-idp:AdminUpdateUserAttributes"
    ]
    resources = [
      aws_cognito_user_pool.sandbox_userpool.arn
    ]
  }
}

resource "aws_iam_policy" "lamda_update_cognito_policy" {
  name   = "LambdaUpdateCognitoPolicy"
  path   = "/"
  policy = data.aws_iam_policy_document.lamda_update_cognito_documment.json
}



resource "aws_iam_role_policy_attachment" "cognito_policy_attachment" {
  role = aws_iam_role.lambda_iam_role.name
  policy_arn = aws_iam_policy.lamda_update_cognito_policy.arn
  depends_on = [
    aws_iam_policy.lamda_update_cognito_policy
  ]
  
}


# Lambda Logging policy 

data "aws_iam_policy_document" "lambda_logging_policy_document" {
  statement {
    sid = "LambdaLogroup"
    actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
    ]
    resources = [
        "arn:aws:logs:*:*:*"
      ]
  }
}

resource "aws_iam_policy" "lamda_logging_policy" {
  name   = "LambdaAllowLoggingPolicy"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_logging_policy_document
}

resource "aws_iam_role_policy_attachment" "lambda_logging_policy_attachment" {
  role = aws_iam_role.lambda_iam_role.name
  policy_arn = aws_iam_policy.lamda_logging_policy.arn
  depends_on = [
    aws_iam_policy.lamda_logging_policy
  ]
  
}
