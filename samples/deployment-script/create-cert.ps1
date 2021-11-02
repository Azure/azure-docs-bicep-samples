param(
[string] [Parameter(Mandatory=$false)] $vaultName,
[string] [Parameter(Mandatory=$false)] $certificateName,
[string] [Parameter(Mandatory=$false)] $subjectName
)

$ErrorActionPreference = 'Stop'

$policy = New-AzKeyVaultCertificatePolicy -SubjectName $subjectName -IssuerName Self -ValidityInMonths 12 -Verbose

# private key is added as a secret that can be retrieved in the ARM template
Add-AzKeyVaultCertificate -VaultName $vaultName -Name $certificateName -CertificatePolicy $policy -Verbose

$cert = Get-AzKeyVaultCertificate -VaultName $vaultName -Name $certificateName

# it take a few seconds for KeyVault to finish
while($cert.Thumbprint -eq $null){
    Write-Output 'Sleeping...'
    Start-Sleep 5
    $cert = Get-AzKeyVaultCertificate -VaultName $vaultName -Name $certificateName
}

$DeploymentScriptOutputs = New-Object -TypeName hashtable
$DeploymentScriptOutputs['certThumbprint'] = $cert.Thumbprint
$cert | Out-String
