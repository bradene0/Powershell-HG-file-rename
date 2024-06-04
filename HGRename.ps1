$folderPath = "C:\Path\To\Your\Files"
$files = Get-ChildItem -Path $folderPath -File
$pattern = "^(.*?)_([\w\s]+?)_([\w\s]+?)_([\w\s]+?)_([\w\s]+)$"

foreach ($file in $files) {
    if ($file.Name -match $pattern) {
        $part1 = $matches[1]
        $part2 = $matches[2] -replace "_", "-"
        $part3 = $matches[3]
        $part4 = $matches[4] -replace "_", "-"
        $part5 = $matches[5]

        # Construct the new filename
        $newName = "$part1-$part2-$part3-$part4-$part5"
        $newPath = Join-Path -Path $file.DirectoryName -ChildPath $newName
        
        # Rename the file
        Rename-Item -Path $file.FullName -NewName $newName
    }
}

Write-Host "Files renamed successfully."