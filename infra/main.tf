provider "aws" {
  region = "ap-northeast-1" # 東京リージョン（適宜変更可）
}

# Cognito User Pool
resource "aws_cognito_user_pool" "main" {
  name = "login-form-test-pool"

  auto_verified_attributes = ["email"]

  schema {
    name     = "email"
    required = true
    attribute_data_type = "String"
    mutable  = true
  }

  password_policy {
    minimum_length    = 8
    require_uppercase = true
    require_lowercase = true
    require_numbers   = true
    require_symbols   = false
  }

  mfa_configuration = "OFF"
}

# User Pool Client（アプリケーションクライアント）
resource "aws_cognito_user_pool_client" "main" {
  name         = "login-form-test-client"
  user_pool_id = aws_cognito_user_pool.main.id

  generate_secret = false

  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                = ["email", "openid", "profile"]
  allowed_oauth_flows_user_pool_client = true

  callback_urls = ["https://example.com/callback"] # 適宜変更
  logout_urls   = ["https://example.com/logout"]   # 適宜変更

  supported_identity_providers = ["COGNITO"]
}

# User Pool ドメイン（Amazon 提供ドメイン）
resource "aws_cognito_user_pool_domain" "main" {
  domain       = "login-form-test-domain-123" # 一意の値にする必要あり
  user_pool_id = aws_cognito_user_pool.main.id
}
