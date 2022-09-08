#!/bin/bash
cd ~/environment
echo "variable \"c9_project\" {
  value=\"$C9_PROJECT\"
}" > c9_project.tf
REPOS="terraform-iam terraform-vpc terraform-eks terraform-data-integration-student terraform-data-integration terraform-rds-mysql terraform-ghost ubuntu-on-kubernetes"
for REPO in $REPOS; do
  git clone git@github.com:Elva-Classroom/$REPO.git
  if [ -d $REPO/terraform ]; then
    cp c9_project.tf $REPO/terraform/c9_project.tf
  fi
done
rm c9_project.tf
