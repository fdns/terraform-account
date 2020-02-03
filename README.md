# terraform-account
This repository contains the terraform code to setup my personas AWS respository, limiting the account permissions to prevent errors when deploying or using other services by accident.

## Group Permissions

- terraform_developers: Contains all the roles for my account
  - **terraform_user_general**: Force the use of MFA
  - **terraform_user_developer_ec2**: Allow adding.modifying EC2 resources, disallow tagged with {"protected": "true"}
  - **terraform_user_s3admin**: Allow administration of S3
  - **terraform_user_ecr_push**: Allow access to ECR.
  - **terraform_user_cloud9**: Allow full access to cloud9
  
## S3 Buckets
This profile also create the s3 bucket *fdns-terraform-state*, which is used by terraform to store the tfstate
