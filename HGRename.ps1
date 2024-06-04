$folderPath = "C:\Path\To\Your\Files"
$replaceBefore = "-"
$replaceAfter = "-"
$files = Get-ChildItem -Path $folderPath -File
$pattern = "^(.*)_(\d+?)_(.*)$"

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
        $prefix = $matches[1]
        $firstNumber = $matches[2]
        $suffix = $matches[3]
        $newName = "$prefix$replaceBefore$firstNumber$replaceAfter$suffix"
        $newPath = Join-Path -Path $file.DirectoryName -ChildPath $newName
        Rename-Item -Path $file.FullName -NewName $newName
    }
}

Write-Host "Files renamed successfully."