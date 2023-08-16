$Username = 'Contoso\JohnDoe'
$Password = 'P@ssw0rd'

$SecureString = ConvertTo-SecureString $Password -AsPlainText -Force

#$Password = ConvertTo-SecureString $Password -AsPlainText -Force


$Credential = New-Object System.Management.Automation.PSCredential $Username, $SecureString

$Credential

#$Credential = New-Object System.Management.Automation.PSCredential $Username, $Password

#$NetCred = $Credential.GetNetworkCredential()

#$NetCred

