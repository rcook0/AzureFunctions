# CONNECTIONS

This document explains connection strings used in local.settings.json.

## AzureWebJobsStorage
Required for all Function Apps.
- Local: UseDevelopmentStorage=true (Azurite emulator).
- Azure: Replace with real Storage Account connection string.

## CosmosDBConnection
- Local: AccountEndpoint=https://localhost:8081/;AccountKey=your-key; (Cosmos DB Emulator)
- Azure: Connection string from Cosmos DB Keys.

## ServiceBusConnection
- No local emulator. Connect to Azure Service Bus.
- Azure: Copy connection string from Service Bus namespace.

## EventHubConnection
- No local emulator. Connect to Azure Event Hub.
- Azure: Copy from Event Hubs namespace.

## AzureSignalRConnectionString
- No local emulator. Connect to Azure SignalR Service.
- Azure: Copy connection string from SignalR Service Keys.

## APPINSIGHTS_INSTRUMENTATIONKEY
- Local: optional dummy GUID is fine.
- Azure: Instrumentation Key from Application Insights resource.

---

### Notes
- Unused keys are safe. Functions host ignores them until a binding references them.
- `local.settings.json` is never deployed to Azure.
