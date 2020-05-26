$Conn = Get-AutomationConnection -Name 'AzureRunAsConnection'
Connect-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationId -CertificateThumbprint "CertificateThumbprintfromAzureRunAsAccount"

Select-AzSubscription -SubscriptionName 'SubscriptionName'

# Create variables 
$secret = Get-AzKeyVaultSecret -VaultName 'keyvaultname' -Name 'secretname'
$timestamp = Get-Date -Format MM-dd-yyyy
$Context = New-AzureStorageContext -StorageAccountName 'storageaccountname' -StorageAccountKey $secret.SecretValueText


$AfterDate = (Get-Date).AddDays(0)
$BeforeDate = (Get-Date).AddDays(1) 
$PipelineName = "pipelinename"
$DataFactory = "Datafactoryname"
$RG = 'ResourceGroupName'
$Status1 = (Get-AzureRmDataFactoryV2PipelineRun -ResourceGroupName $RG -DataFactoryName $DataFactory -PipelineName $PipelineName -LastUpdatedAfter $AfterDate -LastUpdatedBefore $BeforeDate).Status



#Script
 $Status1

    if ($Status1 -eq "Succeeded"){ 
    Write-Output "Pipeline succeeded to run, proceeding with deletion" 

    # Store
    Get-AzureStorageFile -Context $Context -Sharename stores -path "store1\$timestamp" | get-azurestoragefile | Remove-AzureStorageFile -confirm:$false
    Remove-AzureStorageDirectory -Sharename stores -path "store1\$timestamp" -context $Context -confirm:$false

}
else {
    Write-Output "Pipeline failed, cancelling deletion"
}
