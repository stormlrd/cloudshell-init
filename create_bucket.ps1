# Define variables
$baseBucketName = "setup-cloudshell"
$randomSuffix = -join ((48..57) + (97..122) | Get-Random -Count 8 | % {[char]$_})
$bucketName = "${baseBucketName}-${randomSuffix}"
$region = "us-east-1"  # Adjust the region as needed
$scriptsFolder = (Get-Location).Path
$scriptFiles = @("init.sh")
$awsProfile = "primary"

# Check if bucketname.txt exists, and exit if it does
$bucketnameFilePath = Join-Path -Path $scriptsFolder -ChildPath "bucketname.txt"
if (Test-Path $bucketnameFilePath) {
    Write-Output "bucketname.txt already exists. Exiting script."
    Exit
}

# Create the S3 bucket
aws s3api create-bucket --bucket $bucketName --region $region --profile $awsProfile

# Wait for the bucket to be created (optional)
aws s3api wait bucket-exists --bucket $bucketName --region $region --profile $awsProfile

# Upload the script files to the S3 bucket
foreach ($script in $scriptFiles) {
    aws s3api put-object --bucket $bucketName --key $script --body "$scriptsFolder\$script" --region $region --profile $awsProfile
}

Write-Output "Scripts uploaded to S3 bucket $bucketName successfully."

# Create a file with the command to use to pull the init script down into cloud shell and run it
$finalCommand = "sudo aws s3 cp s3://$bucketName/init.sh ~/init.sh && sudo chmod +x ~/init.sh && sudo ~/init.sh"
$commandFilePath = Join-Path -Path $scriptsFolder -ChildPath "cloudshell_command.txt"
$finalCommand | Out-File -FilePath $commandFilePath -Encoding utf8

Write-Output "Final command file created: $commandFilePath"

# Create a file with the bucket name in it to show we've done the job.
$line = "$bucketName"
$line | Out-File -FilePath $bucketnameFilePath -Encoding utf8

Write-Output "Bucketname file created: $bucketnameFilePath"
