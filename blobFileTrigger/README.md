# Azure Function App - blobFileTrigger

This folder contains the **blobFileTrigger** Azure Function App project.

## Running Locally

1. Install [Azure Functions Core Tools](https://learn.microsoft.com/azure/azure-functions/functions-run-local).
2. Start storage emulator (e.g. Azurite):
   ```bash
   azurite --silent --location ./azurite --debug ./azurite/debug.log
   ```
3. Run the function app locally:
   ```bash
   func start
   ```

The `local.settings.json` file contains default configuration values for local development.

## Deploying via GitHub Actions

This app is deployed automatically when changes are pushed to the `main` branch, using the workflow defined in `.github/workflows/`.  

- Make sure the folder name matches the Azure Function App name.  
- Add a repository secret with the publish profile from Azure Portal, named `BLOBFILETRIGGER_PUBLISH_PROFILE`.  

Then on every push to `main`, GitHub Actions will build and deploy this app.
