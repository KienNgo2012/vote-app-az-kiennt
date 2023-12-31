# Change the ACR name in the commands below.
# Assuming the acdnd-c4-project resource group is still available with you
# ACR name should not have upper case letter
az acr create --resource-group acdnd-c4-project-kien --name myacr202311 --sku Basic
# Log in to the ACR
az acr login --name myacr202311
# Get the ACR login server name
# To use the azure-vote-front container image with ACR, the image needs to be tagged with the login server address of your registry. 
# Find the login server address of your registry
az acr show --name myacr202311 --query loginServer --output table
# Associate a tag to the local image. You can use a different tag (say v2, v3, v4, ....) everytime you edit the underlying image. 
docker tag azure-vote-front:v1 myacr202311.azurecr.io/azure-vote-front:v1
# Now you will see myacr202106.azurecr.io/azure-vote-front:v1 if you run "docker images"
# Push the local registry to remote ACR
docker push myacr202311.azurecr.io/azure-vote-front:v1
# Verify if your image is up in the cloud.
az acr repository list --name myacr202311 --output table
# Associate the AKS cluster with the ACR
az aks update -n udacity-cluster -g acdnd-c4-project-kien --attach-acr myacr202311