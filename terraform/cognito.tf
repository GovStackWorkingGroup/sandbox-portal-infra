resource "aws_cognito_user_pool" "sandbox_userpool" {
  name = "sandbox-${var.product}-${var.environment}-userpool-userpool"

  password_policy {
    require_numbers = false
    require_symbols = false
    require_uppercase = false
    minimum_length = 6
  }

  alias_attributes = ["email" ]

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  #schema for email attribute
  schema {
    name = "email"
    attribute_data_type = "String"
    developer_only_attribute = false
    required = true
    mutable = true
    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  #Custom attribute authChallenge
  schema {
    name = "authChallenge"
    attribute_data_type = "String"
    developer_only_attribute = false
    required = false
    mutable = true
    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  lambda_config {
    pre_sign_up = aws_lambda_function.preSignupLambda.arn
    create_auth_challenge = aws_lambda_function.createAuthChallengeLambda.arn
    define_auth_challenge = aws_lambda_function.defineAuthChallengeLambda.arn
    verify_auth_challenge_response = aws_lambda_function.verifyAuthChallengeLambda.arn
    post_authentication = aws_lambda_function.postAuthenticationLambda.arn
  }
}


resource "aws_cognito_user_pool_client" "sandbox_userpool_client" {
  name = "sandbox-${var.product}-${var.environment}-userpool-client"

  user_pool_id = aws_cognito_user_pool.sandbox_userpool.id
  generate_secret  = true

  refresh_token_validity = 30
  access_token_validity = 1
  id_token_validity = 1

  explicit_auth_flows = [
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]

  prevent_user_existence_errors = "ENABLED"
}
