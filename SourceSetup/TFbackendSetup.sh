#!/bin/bash

RESOURCE_GROUP_NAME=CommonHOSRCMtfBackend-RG
STORAGE_ACCOUNT_NAME=commontfbackend427371
CONTAINER_NAME=tfstate
subscriptionID=$(az account list --query "[].id" --output tsv)
# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

#create servicePrincipal
az ad sp create-for-rbac -n Sourcesp --role="Contributor" --scopes="/subscriptions/$subscriptionID" > sourceContributerSPcred.txt

export ARM_CLIENT_ID=$(cat sourceContributerSPcred.txt| /opt/homebrew/bin/jq -r .appId)
export ARM_CLIENT_SECRET=$(cat sourceContributerSPcred.txt| /opt/homebrew/bin/jq -r .password)
export ARM_SUBSCRIPTION_ID=$subscriptionID
export ARM_TENANT_ID=$(cat sourceContributerSPcred.txt| /opt/homebrew/bin/jq -r .tenant)

#dynamically pass ipto whitelist
export TF_VAR_myip=$(curl -s ifconfig.io)

# az group delete --name CommonHOSRCMtfBackend-RG --yes
# az ad sp delete --id 

# az role assignment create \
#   --assignee appid \
#   --role "User Access Administrator" \
#   --scope /subscriptions/subid


