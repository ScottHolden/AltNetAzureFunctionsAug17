param (
    [string] $Suffix,
    [string] $ResourceGroup,
    [string] $PackageUrl,
    [string] $Location = "australiasoutheast"
)

$Name = "sample2"

if  ((Get-AzureRmResourceGroup).ResourceGroupName -contains $ResourceGroup)
{
    Write-Host "Using existing resource group $ResourceGroup"
}
else
{
    Write-Host "Creating new resource group $ResourceGroup in $Location"
    New-AzureRmResourceGroup -Name $ResourceGroup -Location $Location
}

New-AzureRmResourceGroupDeployment -ResourceGroupName $ResourceGroup `
                                    -Name "$Name-$(Get-Date -Format yyyyMMddHHmmss)" `
                                    -TemplateFile ".\deploy\azuredeploy.json" `
                                    -TemplateParameterObject @{
                                        AppName = "$Name$Suffix";
                                        PackageUrl = $PackageUrl;
                                    }