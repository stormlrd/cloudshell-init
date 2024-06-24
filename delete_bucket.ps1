# Read the bucket name from bucketname.txt
$bucketName = Get-Content -Path "bucketname.txt"
$awsProfile = "primary"

if (-not $bucketName) {
    Write-Host "Bucket name is empty or not found in bucketname.txt"
    exit 1
}

# Delete the file from the bucket using the specified profile
aws s3 rm "s3://$bucketName/$fileToDelete" --profile $awsProfile

# Check if the file deletion was successful
if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to delete the file $fileToDelete from bucket $bucketName"
    exit 1
}

# Delete the bucket using the specified profile
aws s3 rb "s3://$bucketName" --force --profile $awsProfile

# Check if the bucket deletion was successful
if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to delete the bucket $bucketName"
    exit 1
}

Write-Host "Successfully deleted the file $fileToDelete and the bucket $bucketName"

# Delete local files
$localFiles = @("bucketname.txt", "cloudshell_command.txt")
foreach ($file in $localFiles) {
    if (Test-Path $file) {
        Remove-Item $file -Force
        Write-Output "$file has been deleted."
    } else {
        Write-Output "$file does not exist."
    }
}

Write-Output "Finished deleting the txt local files."