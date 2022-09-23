#!/bin/bash

ec2-metadata | grep "placement: us-west-2"
if [ $? -ne 0 ]; then
  echo "Your Cloud9 instance does not appear to be in the right region."
  echo "Please re-create your instance in the us-west-2 (Oregon) region."
  exit 1
fi

project=$C9_PROJECT
name_len=${#project}
if [ $name_len -gt 12 ]; then
  echo "Your Cloud9 instance name is longer than 12 characters."
  echo "Please re-recreate your instance with a shorter name, all lowercase and no punctuation."
  exit 1
fi

if [[ "$project" =~ [A-Z] ]]; then
  echo "Do not use uppercase letters in your Cloud9 instance name."
  echo "Please re-recreate your instance with a shorter name, all lowercase and no punctuation."
  exit 1
fi


aws configure set region us-west-2

#sh ./increase-disk.sh

sudo yum install -y jq gettext bash-completion moreutils amazon-efs-utils

git clone https://github.com/hashivim/vim-terraform.git ~/.vim/pack/plugins/start/vim-terraform
aws --region us-west-2 secretsmanager get-secret-value --secret-id asu-github-ssh-key | jq -r .SecretString > ~/.ssh/id_rsa
chmod 0600 ~/.ssh/id_rsa
ssh-keyscan github.com >> ~/.ssh/known_hosts

mkdir -p ~/.terraform.d/plugin-cache
echo "plugin_cache_dir = \"$HOME/.terraform.d/plugin-cache\"" > ~/.terraformrc

rm ~/.bash_completion

sudo curl --silent --location -o /usr/local/bin/kubectl \
	https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.6/2022-03-09/bin/linux/amd64/kubectl
sudo chmod +x /usr/local/bin/kubectl
kubectl completion bash >>  ~/.bash_completion

curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -qo awscliv2.zip
sudo ./aws/install --update
rm awscliv2.zip
rm -r aws

echo 'export LBC_VERSION="v2.4.1"' >>  ~/.bash_profile
echo 'export LBC_CHART_VERSION="1.4.1"' >>  ~/.bash_profile

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
sudo chmod +x /usr/local/bin/eksctl
eksctl completion bash >> ~/.bash_completion

curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
helm repo add stable https://charts.helm.sh/stable
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm completion bash >> ~/.bash_completion

pip3 install boto3 --upgrade

echo
ssh -T git@github.com
