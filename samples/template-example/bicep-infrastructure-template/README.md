# Bicep 💪 Infrastructure Template 


Organizing your cloud infrastructure can be a challenging task, especially when you have multiple components and resources to manage. However, using a template can make the process much easier and ensure a cleaner, more structured directory. The template described in this sentence follows the **Microsoft structure for their Bicep documentation** found [Here](https://learn.microsoft.com/en-us/azure/templates/), which is known for being well organized and efficient. By following this template, you can take advantage of the best practices used by Microsoft and have a more streamlined and manageable cloud infrastructure. Additionally, using a consistent structure can make it easier to maintain and update your resources over time, as well as to share your documentation with others who might need to access it. Overall, adopting this template can be a valuable tool in your cloud infrastructure management toolkit.


# Directory  Structure 

To add other directories for other resources, check the docs [here](https://learn.microsoft.com/en-us/azure/templates/) and see how they structure it and just replicate. 


```
📦templates
 ┣ 📂modules
 ┃ ┣ 📂Microsoft.ContainerRegistry
 ┃ ┃ ┗ 📜registries.bicep
 ┃ ┣ 📂Microsoft.ManagedIdentity
 ┃ ┃ ┗ 📜userassignedIdentity.bicep
 ┃ ┣ 📂Microsoft.Resources
 ┃ ┃ ┗ 📜deploymentScripts.bicep
 ┃ ┣ 📂Microsoft.Storage
 ┃ ┃ ┣ 📂storageAccounts
 ┃ ┃ ┃ ┣ 📂blobServices
 ┃ ┃ ┃ ┃ ┗ 📜blobcontainers.bicep
 ┃ ┃ ┃ ┣ 📂fileservices
 ┃ ┃ ┃ ┃ ┗ 📜shares.bicep
 ┃ ┃ ┃ ┣ 📜blobservices.bicep
 ┃ ┃ ┃ ┗ 📜fileservices.bicep
 ┃ ┃ ┗ 📜storageAccounts.bicep
 ┃ ┗ 📂Microsoft.Web
 ┃ ┃ ┣ 📂sites
 ┃ ┃ ┃ ┗ 📜sites.bicep
 ┃ ┃ ┗ 📜serverfarms.bicep
 ┗ 📂products
 ┃ ┗ 📂product-1
 ┃ ┃ ┣ 📂environment
 ┃ ┃ ┃ ┣ 📂dev
 ┃ ┃ ┃ ┃ ┣ 📜dev.bicep
 ┃ ┃ ┃ ┃ ┗ 📜dev.params.json
 ┃ ┃ ┃ ┗ 📂prod
 ┃ ┃ ┃ ┃ ┣ 📜prod.bicep
 ┃ ┃ ┃ ┃ ┗ 📜prod.params.json
 ┃ ┃ ┗ 📂topology
 ┃ ┃ ┃ ┣ 📂dev
 ┃ ┃ ┃ ┃ ┗ 📜dev.bicep
 ┃ ┃ ┃ ┗ 📂prod
 ┃ ┃ ┃ ┃ ┗ 📜prod.bicep
```

The "products" folder within the "templates" directory is where you will deploy your various services. In our example, the product named "product-1" is stored here, complete with its topology and environment. Within the "environment" folder, you can have multiple environments such as dev, prod, QA, and more, allowing you to easily manage and deploy your services to the appropriate environment.
```
📦products
 ┗ 📂product-1
 ┃ ┣ 📂environment
 ┃ ┃ ┣ 📂dev
 ┃ ┃ ┃ ┣ 📜dev.bicep
 ┃ ┃ ┃ ┗ 📜dev.params.json
 ┃ ┃ ┗ 📂prod
 ┃ ┃ ┃ ┣ 📜prod.bicep
 ┃ ┃ ┃ ┗ 📜prod.params.json
 ┃ ┗ 📂topology
 ┃ ┃ ┣ 📂dev
 ┃ ┃ ┃ ┗ 📜dev.bicep
 ┃ ┃ ┗ 📂prod
 ┃ ┃ ┃ ┗ 📜prod.bicep
```

# Deployment 
**1. Using Azure Pipelines**

An Azure Pipelines-compatible .yaml file has already been created for the pipeline, allowing you to easily deploy your resources to Azure DevOps. Find it within the /pipelines directory and configure the required variables for it to work.

**2. Locally using the terminal**

use the following azCLI command on your terminal 

```bash
az deployment group create \
   --template-file <bicep file in environment folder> \
   --parameters <json parameter file>
```
Example 

```bash
az deployment group create \
   --template-file prod.bicep \
   --parameters prod.params.json
```




