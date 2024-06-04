$folderPath = "C:\Path\To\Your\Files"
$files = Get-ChildItem -Path $folderPath -File
$pattern = "^(.*?)_([\d]+)_([\w\s]+)$"

foreach ($file in $files) {
    if ($file.Name -match $pattern) {
        $prefix = $matches[1]
        $firstNumber = $matches[2]
        $suffix = $matches[3]

        # Replace underscores around the first number with hyphens
        $newSuffix = $suffix -replace "_", "-"

        # Construct the new filename
        $newName = "$prefix-$firstNumber-$newSuffix"
        $newPath = Join-Path -Path $file.DirectoryName -ChildPath $newName
        
        # Rename the file
        Rename-Item -Path $file.FullName -NewName $newName
    }
}

Write-Host "Files renamed successfully."