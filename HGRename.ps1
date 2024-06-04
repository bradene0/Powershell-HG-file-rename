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
        $beforeNumber = $matches[1]
        $firstNumber = $matches[2]
        $afterNumber = $matches[3]

        # Replace underscores only before and after the first number
        $beforeNumber = $beforeNumber -replace '_(?=.*?_)', $replaceBefore
        $afterNumber = $afterNumber -replace '_(?=.*?_)', $replaceAfter

        # Join the parts back together to form the new filename
        $newName = $beforeNumber + "_" + $firstNumber + "_" + $afterNumber
        $newPath = Join-Path -Path $file.DirectoryName -ChildPath $newName
        
        # Rename the file
        Rename-Item -Path $file.FullName -NewName $newName
    }
}

Write-Host "Files renamed successfully."