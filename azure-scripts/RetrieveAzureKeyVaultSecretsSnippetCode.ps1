$keyvaultName = 'asw026kcu-terra-kv'
$secrets = Get-AzKeyVaultSecret -VaultName $keyvaultName

$keys =@{}
foreach ($secret in $secrets)
    {
        $secretName = $secret.name
        
        $key = Get-AzKeyVaultSecret -VaultName $keyvaultName -name $secretName -AsPlainText
        $keys.Add("$secretName", "$key")
    }