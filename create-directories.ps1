
$Conn = Get-AutomationConnection -Name 'AzureRunAsConnection'
Connect-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationId -CertificateThumbprint "CertificateThumbprintfromAzureRunAsAccount"

Select-AzSubscription -SubscriptionName 'SubscriptionName'

# Create variables 
$secret = Get-AzKeyVaultSecret -VaultName 'keyvaultname' -Name 'secretname'
$timestamp = Get-Date -Format MM-dd-yyyy
$Context = New-AzureStorageContext -StorageAccountName 'storageaccountname' -StorageAccountKey $secret.SecretValueText

# Create Directory with today's date

New-AzureStorageDirectory -Context $Context -ShareName stores -path "store1\$timestamp"