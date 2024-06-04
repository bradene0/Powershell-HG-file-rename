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
        $firstNumberIndex = $file.Name.IndexOfAny([char[]]"0123456789")
        $beforeNumber = $file.Name.Substring(0, $firstNumberIndex)
        $afterNumber = $file.Name.Substring($firstNumberIndex)
        $beforeNumber = $beforeNumber -replace '_', $replaceBefore
        $afterNumber = $afterNumber -replace '_', $replaceAfter
        $newName = $beforeNumber + $afterNumber
        $newPath = Join-Path -Path $file.DirectoryName -ChildPath $newName
        Rename-Item -Path $file.FullName -NewName $newName
    }
}

Write-Host "Files renamed successfully."