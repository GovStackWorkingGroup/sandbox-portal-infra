locals {
  account_name   = "portalDev"
  aws_account_id = "610958474035" # replace me with your AWS account ID!
  aws_profile    = "non-prod" 
  environment = "dev" 

  aws_region = "eu-central-1"
  product = "portal"

  #magic links
  ses_from_adress = "akseli.karvinen@gofore.com" #please change this to some proper one
}
