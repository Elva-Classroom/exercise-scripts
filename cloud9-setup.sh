sh ./increase-disk.sh

sudo yum install jq gettext bash-completion moreutils -y

git clone https://github.com/hashivim/vim-terraform.git ~/.vim/pack/plugins/start/vim-terraform
aws --region us-west-2 secretsmanager get-secret-value --secret-id asu-github-ssh-key | jq -r .SecretString > ~/.ssh/id_rsa
chmod 0600 ~/.ssh/id_rsa
ssh-keyscan github.com >> ~/.ssh/known_hosts

mkdir -p ~/.terraform.d/plugin-cache
echo "plugin_cache_dir = \"$HOME/.terraform.d/plugin-cache\"" > ~/.terraformrc

rm ~/.bash_completion

sudo curl --silent --location -o /usr/local/bin/kubectl \
	   https://s3.us-west-2.amazonaws.com/amazon-eks/1.21.5/2022-01-21/bin/linux/amd64/kubectl
sudo chmod +x /usr/local/bin/kubectl
kubectl completion bash >>  ~/.bash_completion

curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -qo awscliv2.zip
sudo ./aws/install
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

echo
ssh -T git@github.com
