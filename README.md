# Sandbox Portal Infrastructure

Contains infrastructure as terraform for the sandbox portal. Used by terragrunt.

## Structure
+ **live** - Contains terragrunt files for managing different environments. Divided by environment.
+ **modules** - Contains modules for infra written in terraform

## Current modules
+ **magiclink** - Contains cognito, some lambdas for creating the magic link and lambda and API for signIn for frontend to connect
+ **cognitolambda** - Submodule for magiclink, creates and deploys the lambda and appropriate resources they need

These are currently temporarily deployed in https://github.com/GovStackWorkingGroup/sandbox-infra
