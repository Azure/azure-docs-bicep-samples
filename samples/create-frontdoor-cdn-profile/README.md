# Sample Module to Create Azure FrontDoor CDN Profile

## Directory Structure

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
1. Directory `base` contains base bicep files
   1. `dignosticSettings.bicep` -> Create dignosticSettings to send Azure CDN Access Logs to Event Hub. This can further be consumed to Azure Data Explorer.
   2. `main.bicep` -> Orchestrate around other files in bicep module and create CDN profile
   3. `routes.bicep` -> Create routes for CDN Profile
   4. `rulesets.bicep` -> Create Default Rule Set that are required across all CDN Profile by a user.
   5. `waf.bicep` -> Query `existing` WAF to be attached to CDN Profile as Security Policy.
2. File `profile/main.bicep` provide a abstracted view to user for creating multiple CDN profile.
3. `static.stg.bicep` calls `profile/main.bicep` to create a stage environment profile.