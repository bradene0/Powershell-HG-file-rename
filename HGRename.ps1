$folderPath = "C:\Path\To\Your\Files"
$replaceBefore = "-"
$replaceAfter = "-"
$files = Get-ChildItem -Path $folderPath -File
$pattern = "^(.*?)_([\d]+?)_(.*?)$"

function Check-EmergencyStop {
    if ([console]::KeyAvailable) {
        $key = [console]::ReadKey($true).Key
        if ($key -eq 'F12') {
            Write-Host "Emergency stop triggered. Exiting script."
            exit
        }
    }
}

foreach ($file in $files) {
    Check-EmergencyStop

    if ($file.Name -match $pattern) {
        $parts = $matches[1..3]

        # Replace only the underscores around the first number
        $parts[1] = $parts[1] -replace '_', $replaceBefore
        $parts[2] = $parts[2] -replace '_', $replaceAfter

        # Join the parts back together to form the new filename
        $newName = $parts -join '_'
        $newPath = Join-Path -Path $file.DirectoryName -ChildPath $newName
        
        # Rename the file
        Rename-Item -Path $file.FullName -NewName $newName
    }
}

Write-Host "Files renamed successfully."