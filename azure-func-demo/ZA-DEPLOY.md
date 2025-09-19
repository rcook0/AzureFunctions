1. Login and Set Subscription
az login
az account set --subscription "<your-subscription-id>"

2. Create a Resource Group
az group create \
  --name FuncDemoRG \
  --location westeurope

3. Create Storage Account
Functions require a backing storage account.
az storage account create \
  --name funcdemostorage$RANDOM \
  --location westeurope \
  --resource-group FuncDemoRG \
  --sku Standard_LRS
Take note of the storage account name.

4. Create a Cosmos DB (SQL API)
az cosmosdb create \
  --name funcdemocosmos$RANDOM \
  --resource-group FuncDemoRG \
  --kind GlobalDocumentDB
Get a key + endpoint:
az cosmosdb keys list \
  --name <cosmos-name> \
  --resource-group FuncDemoRG \
  --type keys

az cosmosdb show \
  --name <cosmos-name> \
  --resource-group FuncDemoRG \
  --query documentEndpoint

5. Create Function App
Pick Node runtime (adjust if Python/C#):
az functionapp create \
  --resource-group FuncDemoRG \
  --consumption-plan-location westeurope \
  --runtime node \
  --functions-version 4 \
  --name func-demo-$RANDOM \
  --storage-account <storage-name>

6. Configure Settings
Inject the Cosmos connection string:
az functionapp config appsettings set \
  --name <function-app-name> \
  --resource-group FuncDemoRG \
  --settings "CosmosDBConnection=AccountEndpoint=<endpoint>;AccountKey=<key>;"

7. Deploy Code
From inside your project folder:
func azure functionapp publish <function-app-name>
This will bundle all functions (HttpStarter, QueueWorker, BlobProcessor, CosmosWatcher) and push them into Azure.

8. Test Live
Check your deployed endpoint:
curl -X POST https://<function-app-name>.azurewebsites.net/api/HttpStarter \
  -H "Content-Type: application/json" \
  -d '{"task":"production-test","priority":"urgent"}'
Then watch in the Azure Portal:
    • Storage → Blob containers → see processed/…json.
    • Cosmos DB → MyDB/Items container → see docs appear.
    • Function App → Monitor → logs show CosmosWatcher firing.

9. Clean Up (optional)
When done testing:
az group delete --name FuncDemoRG --yes --no-wait
