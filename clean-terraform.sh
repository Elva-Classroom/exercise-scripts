echo "Cleaning Terraform working directories..."
rm -rf ~/environment/*/terraform/.terraform
rm -rf ~/.terraform.d/plugin-cache
mkdir -p ~/.terraform.d/plugin-cache
