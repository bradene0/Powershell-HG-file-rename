$folderPath = "C:\Path\To\Your\Files"
$replaceBefore = "-"
$replaceAfter = "-"
$files = Get-ChildItem -Path $folderPath -File
$pattern = "^(.*?)_(\d+)_([\w\s]+)$"

foreach ($file in $files) {
    if ($file.Name -match $pattern) {
        $prefix = $matches[1]
        $firstNumber = $matches[2]
        $suffix = $matches[3]

        # Construct the new filename preserving all underscores
        $newName = "$prefix$replaceBefore$firstNumber$replaceAfter$suffix"
        $newPath = Join-Path -Path $file.DirectoryName -ChildPath $newName
        
        # Rename the file
        Rename-Item -Path $file.FullName -NewName $newName
    }
}

Write-Host "Files renamed successfully."