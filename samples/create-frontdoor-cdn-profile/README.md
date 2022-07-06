# Azure FrontDoor CDN Profile

A sample module to create Azure FrontDoor CDN profile.

## Module Directory Structure

```bash
.
├── README.md
├── base
│   ├── dignosticSettings.bicep
│   ├── main.bicep
│   ├── routes.bicep
│   ├── rulesets.bicep
│   └── waf.bicep
├── profile
│   └── main.bicep
└── static.stg.bicep
```

1. Directory `base` contains base bicep files:
   1. `diagnosticSettings.bicep`: Create diagnostic settings to send Azure CDN Access Logs to Event Hub. This can further be consumed to Azure Data Explorer.
   2. `routes.bicep`: Create routes for CDN Profile
   3. `rulesets.bicep`: Create Rule Set that are required by CDN Profile.
   4. `waf.bicep`: Query `existing` WAF that needs to be attached to CDN Profile as Security Policy.
   5. `main.bicep`: Orchestrate around other files in base bicep module and create CDN profile
2. `profile/main.bicep` provide an abstracted view to a user for creating CDN profile.
3. `static.stg.bicep` calls `profile/main.bicep` to create a stage environment profile.

## Deployment

### Setting environment variable

```bash
export CDN_SUBS_ID="9aaxxxx0b-xxx-4ca4-xxxx-d81axxxx1921"
export CDN_RESOURCE_GROUP_NAME="wus-afd-cdn-rg"
export BICEP_FILE_NAME="static.stg.bicep"

```

### Login and set subscription context

```bash
az login
az account set --subscription $CDN_SUBS_ID
```

### Building and linting Bicep code

```bash
az bicep build --file $BICEP_FILE_NAME --stdout
```

### Validate Deployment

```bash
az deployment group validate --resource-group $CDN_RESOURCE_GROUP_NAME --template-file $BICEP_FILE_NAME
```

### Incremental Deployment

```bash
az deployment group create --resource-group $CDN_RESOURCE_GROUP_NAME --name $BICEP_FILE_NAME-`date +%s` --mode Incremental --template-file $BICEP_FILE_NAME --confirm-with-what-if
```


## Test

### Get AFD Endpoint HostName

```bash
az afd endpoint list --profile-name afd-cdn-stg-static-profile --resource-group $CDN_RESOURCE_GROUP_NAME | jq --raw-output '.[].hostName'
```

Output: `afd-cdn-stg-static-anb6a0dzb3gdahan.z01.azurefd.net`

# Test

```bash
$ curl -I -s https://afd-cdn-stg-static-anb6a0dzb3gdahan.z01.azurefd.net/sc/h/br/efl9dyrmgx6xxxxxb5axxu1shclr | grep -iE "HTTP|x-cache|x-cdn"

HTTP/2 200 
x-cache: TCP_HIT
x-cdn: AZUR
x-cdn-version: Azure-FrontDoor
```

