sudo yum install jq -y
git clone https://github.com/hashivim/vim-terraform.git ~/.vim/pack/plugins/start/vim-terraform
aws --region us-west-2 secretsmanager get-secret-value --secret-id asu-github-ssh-key | jq -r .SecretString > ~/.ssh/id_rsa
chmod 0600 ~/.ssh/id_rsa
ssh-keyscan github.com >> ~/.ssh/known_hosts
mkdir -p ~/.terraform.d/plugin-cache
echo "plugin_cache_dir = \"$HOME/.terraform.d/plugin-cache\"" > ~/.terraformrc
echo
ssh -T git@github.com
