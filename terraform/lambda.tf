# S3 bucket for lambda functions
resource "aws_s3_bucket" "lamdbabucket" {
  bucket = "govstack-dev-portal-functions-bucket"
}

# Deployment of createAuthChallenge

data "archive_file" "createAuthChallengeArchive" {
    type = "zip"
    source_file = "${path.module}/functions/createAuthChallenge.ts" 
    output_path = "${path.module}/functions/createAuthChallenge.zip"
}

resource "aws_s3_object" "createAuthChallengeObject" {
    bucket = aws_s3_bucket.lamdbabucket.id
    key = "createAuthChallenge.zip"
    source = data.archive_file.createAuthChallengeArchive.output_path

    depends_on = [
      data.archive_file.createAuthChallengeArchive,
    ]
}

variable "createAuthChallengeName" {
    default = "createAuthChallengeLambda"
}

 resource "aws_lambda_function" "createAuthChallengeLambda" {
    s3_bucket = aws_s3_bucket.lamdbabucket.id
    s3_key = aws_s3_object.createAuthChallengeObject.id
    role = aws_iam_role.lambda_iam_role.arn
    runtime = "nodejs16.x"

    handler = "index.handler"

    function_name = var.createAuthChallengeName
 }

resource "aws_cloudwatch_log_group" "createAuthChallengeLogGroup" {
    name              = "/aws/lambda/${var.createAuthChallengeName}"
    retention_in_days = 14
}

# Deployment of defineAuthChallenge

data "archive_file" "defineAuthChallengeArchive" {
    type = "zip"
    source_file = "${path.module}/functions/defineAuthChallenge.ts" 
    output_path = "${path.module}/functions/defineAuthChallenge.zip"
}

resource "aws_s3_object" "defineAuthChallengeObject" {
    bucket = aws_s3_bucket.lamdbabucket.id
    key = "defineAuthChallenge.zip"
    source = data.archive_file.defineAuthChallengeArchive.output_path

    depends_on = [
      data.archive_file.defineAuthChallengeArchive,
    ]
}

 resource "aws_lambda_function" "defineAuthChallengeLambda" {
    s3_bucket = aws_s3_bucket.lamdbabucket.id
    s3_key = aws_s3_object.defineAuthChallengeObject.id
    role = aws_iam_role.lambda_iam_role.arn
    runtime = "nodejs16.x"

    handler = "index.handler"

    function_name = "defineAuthChallengeLambda"
 }


# Deployment of postAuthentication

data "archive_file" "postAuthenticationArchive" {
    type = "zip"
    source_file = "${path.module}/functions/postAuthentication.ts" 
    output_path = "${path.module}/functions/postAuthentication.zip"
}

resource "aws_s3_object" "postAuthenticationObject" {
    bucket = aws_s3_bucket.lamdbabucket.id
    key = "postAuthentication.zip"
    source = data.archive_file.postAuthenticationArchive.output_path

    depends_on = [
      data.archive_file.postAuthenticationArchive,
    ]
}

 resource "aws_lambda_function" "postAuthenticationLambda" {
    s3_bucket = aws_s3_bucket.lamdbabucket.id
    s3_key = aws_s3_object.postAuthenticationObject.id
    role = aws_iam_role.lambda_iam_role.arn
    runtime = "nodejs16.x"

    handler = "index.handler"

    function_name = "postAuthenticationLambda"
 }


# Deployment of preSignup

data "archive_file" "preSignupArchive" {
    type = "zip"
    source_file = "${path.module}/functions/preSignup.ts" 
    output_path = "${path.module}/functions/preSignup.zip"
}

resource "aws_s3_object" "preSignupObject" {
    bucket = aws_s3_bucket.lamdbabucket.id
    key = "preSignup.zip"
    source = data.archive_file.preSignupArchive.output_path

    depends_on = [
      data.archive_file.preSignupArchive,
    ]
}

 resource "aws_lambda_function" "preSignupLambda" {
    s3_bucket = aws_s3_bucket.lamdbabucket.id
    s3_key = aws_s3_object.preSignupObject.id
    role = aws_iam_role.lambda_iam_role.arn
    runtime = "nodejs16.x"

    handler = "index.handler"

    function_name = "preSignupLambda"
 }
 


# Deployment of signIn

data "archive_file" "signInArchive" {
    type = "zip"
    source_file = "${path.module}/functions/signIn.ts" 
    output_path = "${path.module}/functions/signIn.zip"
}

resource "aws_s3_object" "signInObject" {
    bucket = aws_s3_bucket.lamdbabucket.id
    key = "signIn.zip"
    source = data.archive_file.signInArchive.output_path

    depends_on = [
      data.archive_file.signInArchive,
    ]
}

 resource "aws_lambda_function" "signInLambda" {
    s3_bucket = aws_s3_bucket.lamdbabucket.id
    s3_key = aws_s3_object.signInObject.id
    role = aws_iam_role.lambda_iam_role.arn
    runtime = "nodejs16.x"

    handler = "index.handler"

    function_name = "signInLambda"

    environment {
      variables = {
        "SES_FROM_ADDRESS" = var.ses_from_adress
        "USER_POOL_ID" = aws_cognito_user_pool.sandbox_userpool.id
      }
    }
 }


# Deployment of verifyAuthChallenge

data "archive_file" "verifyAuthChallengeArchive" {
    type = "zip"
    source_file = "${path.module}/functions/verifyAuthChallenge.ts" 
    output_path = "${path.module}/functions/verifyAuthChallenge.zip"
}

resource "aws_s3_object" "verifyAuthChallengeObject" {
    bucket = aws_s3_bucket.lamdbabucket.id
    key = "verifyAuthChallenge.zip"
    source = data.archive_file.verifyAuthChallengeArchive.output_path

    depends_on = [
      data.archive_file.verifyAuthChallengeArchive,
    ]
}

 resource "aws_lambda_function" "verifyAuthChallengeLambda" {
    s3_bucket = aws_s3_bucket.lamdbabucket.id
    s3_key = aws_s3_object.verifyAuthChallengeObject.id
    role = aws_iam_role.lambda_iam_role.arn
    runtime = "nodejs16.x"

    handler = "index.handler"

    function_name = "verifyAuthChallengeLambda"
 }
 