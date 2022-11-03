#!/bin/bash
cd ~/environment
if [ -z "$C9_PROJECT" ]; then
  echo "Something is wrong with your Cloud9, please let your instructor know."
  exit 1
fi
echo "variable \"c9_project\" {
  default = \"$C9_PROJECT\"
}" > c9_project.tf
REPOS="terraform-iam terraform-vpc terraform-eks terraform-data-integration-student terraform-cdp-student terraform-rds-mysql terraform-ghost terraform-argocd ubuntu-on-kubernetes terraform-prometheus terraform-grafana terraform-kubernetes-dashboard terraform-guestbook terraform-tutorial"
for REPO in $REPOS; do
  git clone git@github.com:Elva-Classroom/$REPO.git
  if [ -d $REPO/terraform ]; then
    cp c9_project.tf $REPO/terraform/c9_project.tf
  fi
done
rm c9_project.tf
for REPO in $REPOS; do
  cd ~/environment/$REPO
  git pull
done
