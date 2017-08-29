param (
    $ArtifactStorageAccountName,
    $ArtifactStorageAccountKey,
    $MsBuildPath = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\msbuild.exe"
)

Write-Host "Building solution"

Start-Process -FilePath $MsBuildPath `
                -ArgumentList ".\Sample2.sln","/p:Optimize=true /p:Configuration=Release /p:DebugSymbols=false /p:DebugType=None" `
                -NoNewWindow `
                -Wait

Write-Host "Packaging build output artifact"

$ArtifactFolder = ".\artifacts"
$ArtifactPath = "$ArtifactFolder\Sample2-$(Get-Date -Format yyyyMMddHHmmss).zip"

if (!(Test-Path $ArtifactFolder))
{
    New-Item -ItemType Directory -Force -Path $ArtifactFolder
}

Remove-Item -Path "Sample2.Functions\bin\Release\net461\bin\runtimes" -Recurse -Force -Confirm:$false

Compress-Archive -DestinationPath $ArtifactPath -Path ".\Sample2.Functions\bin\Release\net461\*" -CompressionLevel NoCompression

if ($ArtifactStorageAccountName -and $ArtifactStorageAccountKey)
{
    Write-Host "Uploading artifact to storage"

    $storageContext = New-AzureStorageContext -StorageAccountName $ArtifactStorageAccountName `
                                                -StorageAccountKey $ArtifactStorageAccountKey

    $blob = Set-AzureStorageBlobContent -File $ArtifactPath -Container "sample2" -Context $storageContext

    $token = $blob | New-AzureStorageBlobSASToken -Permission "r" -ExpiryTime (Get-Date).AddHours(1)

    $artifactUrl = "$($blob.ICloudBlob.uri.AbsoluteUri)$token"

    return $artifactUrl
}