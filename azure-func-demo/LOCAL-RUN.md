1. Prerequisites
    • Azure Functions Core Tools (CLI):
      npm install -g azure-functions-core-tools@4 --unsafe-perm true
    • Node.js (v18 LTS recommended).
    • Storage Emulator (choose one):
        ◦ Azurite (cross-platform, recommended):
          npm install -g azurite
          Run with: azurite --silent --location ./azurite --debug ./azurite/debug.log
    • Cosmos DB Emulator (Windows only) or connect to a real Cosmos DB account.

2. Unpack & Init
unzip azure-func-demo.zip
cd azure-func-demo
npm install
Confirm structure:
tree -L 2
Should show HttpStarter, QueueWorker, BlobProcessor, CosmosWatcher.

3. Start Azurite (local storage)
Run in a separate terminal:
azurite --silent --location ./azurite --debug ./azurite/debug.log

4. Start Functions Host
From project root:
func start
The CLI will print routes — expect something like:
HttpStarter: [POST] http://localhost:7071/api/HttpStarter

5. Send Test Payload
Open another terminal and POST JSON:
curl -X POST http://localhost:7071/api/HttpStarter \
  -H "Content-Type: application/json" \
  -d '{"task":"analyze-report","priority":"high"}'
Expected response:
{ "message": "Task queued", "task": { "task": "analyze-report", "priority": "high" } }

6. Observe the Pipeline
    1. HttpStarter puts JSON onto the queue.
    2. QueueWorker consumes the queue → writes a blob (processed/*.json).
Check in Azurite blob explorer or logs.
    3. BlobProcessor reacts to new blob → inserts into Cosmos DB (MyDB/Items).
    4. CosmosWatcher logs new docs as soon as they’re written.
Logs in your func start terminal will show each step firing.

7. Cosmos DB Emulator Setup (if local)
    • Download: Cosmos Emulator.
    • Connection string (paste into local.settings.json):
      "CosmosDBConnection": "AccountEndpoint=https://localhost:8081/;AccountKey=C2y6yDjf5...==;"

8. Clean Up
Stop functions with Ctrl+C.
Storage data is persisted in the ./azurite folder.
