# Paperless Solution

Description

The purpose of this project is to implement a paperless solution in which companies can reduce the costs in paper materials and archive their documents in a secured way using the power of the Cloud. This solution combines tools like Azure Storage Account, Azure File Share (to Store invoices/documents), Azure Data Factory pipelines, and Automation Account in order to copy invoices from one file share to another share in a daily basis where the next department will be able to process all their docuements accordingly.

1. Azure Data Factory  - will trigger in a daily schedule basis to copy everything stored from point A to point B
2. Azure Storage Account - Hot tiered, will have 2 file shares
3. Automation Account - Will trigger runbooks to create a brand new daily with current date, and delete directories at the end of the day from point A, once it verifies the Data Factory pipeline succeeded and copied all the documents in point B.



This project contains the following:

1. Template to create all needed resources (Automation Account, Data Factory, Storage Accounts and File Share)
2. You will need to create an Azure Keyvault to Store the Storage Account Keys securely so its not revealed in the powershell script in the automation
3. For the Runbooks, you will need to import the Az.Account module and Az.Keyvault from the gallery. You will also need to create a Run As Account and grant access in the KeyVault so it could read the Storage Account Key value.


[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Foortizmcp%2FPaperlessSolution%2Fmaster%2FDF-SA-FS-Autom.json)