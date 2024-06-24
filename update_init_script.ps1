# Define variables
$scriptsFolder = (Get-Location).Path
$bucketnameFilePath = Join-Path -Path $scriptsFolder -ChildPath "bucketname.txt"
$scriptFile = "init.sh"
$awsProfile = "primary"

# Check if bucketname.txt exists, and exit if it doesn't
if (-not (Test-Path $bucketnameFilePath)) {
    Write-Output "bucketname.txt not found. Exiting script."
    Exit
}

# Read bucket name from bucketname.txt
$bucketName = Get-Content -Path $bucketnameFilePath

# Upload the init.sh file to the S3 bucket
aws s3api put-object --bucket $bucketName --key $scriptFile --body "$scriptsFolder\$scriptFile" --profile $awsProfile

Write-Output "Script $scriptFile uploaded to S3 bucket $bucketName successfully."
