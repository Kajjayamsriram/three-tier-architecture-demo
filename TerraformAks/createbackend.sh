RESOURCE_GROUP="robot-rg"
STORAGE_ACCOUNT_NAME="azurebackendblob2025" # Makesure it's unique!
CONTAINER_NAME="tfstate"
SSH_KEY_PATH="$HOME/.ssh/aks-ssh-key.pub"

if [ ! -f "$SSH_KEY_PATH" ]; then
  echo "SSH public key not found $SSH_KEY_PATH"
  echo "Run:- ssh-keygen -t rsa -b 4096 -f ~/.ssh/aks-ssh-key"
  exit 1
fi

export TF_VAR_ssh_public_key_path="$SSH_KEY_PATH"
echo "Exported TF_VAR_ssh_public_key_path=$TF_VAR_ssh_public_key_path"

az storage account create \
  --name $STORAGE_ACCOUNT_NAME \
  --resource-group $RESOURCE_GROUP \
  --sku Standard_LRS \
  --encryption-services blob

ACCOUNT_KEY=$(az storage account keys list \
  --resource-group $RESOURCE_GROUP \
  --account-name $STORAGE_ACCOUNT_NAME \
  --query '[0].value' -o tsv)

az storage container create \
  --name $CONTAINER_NAME \
  --account-name $STORAGE_ACCOUNT_NAME \
  --account-key $ACCOUNT_KEY
