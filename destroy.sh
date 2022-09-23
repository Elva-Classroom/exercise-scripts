#!/bin/bash
helm uninstall ghost

cd ~/environment/terraform-guestbook/terraform
terraform destroy -auto-approve
