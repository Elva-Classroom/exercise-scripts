aws --region us-west-2 secretsmanager get-secret-value --secret-id github-ssh-key | jq -r .SecretString > ~/.ssh/id_rsa
chmod 0600 ~/.ssh/id_rsa
ssh git@github.com
