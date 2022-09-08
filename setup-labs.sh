#!/bin/bash
cd ~/environment
echo "c9_project=\"$C9_PROJECT\"" > terraform.tfvars       
REPOS="terraform-iam terraform-vpc terraform-eks terraform-data-integration-student terraform-data-integration terraform-rds-mysql terraform-ghost ubuntu-on-kubernetes"
for REPO in $REPOS; do
  git clone git@github.com:Elva-Classroom/$REPO.git
  cp terraform.tfvars ../$REPO
done
