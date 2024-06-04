$folderPath = "C:\Path\To\Your\Files"
$replaceBefore = "-"
$replaceAfter = "-"
$files = Get-ChildItem -Path $folderPath -File
$pattern = "^(.*)_(\d+?)_(\d+?)_(.*)$"

foreach ($file in $files) {
    if ($file.Name -match $pattern) {
        $prefix = $matches[1]
        $firstNumber = $matches[2]
        $secondNumber = $matches[3]
        $suffix = $matches[4]
        $newName = "$prefix$replaceBefore$firstNumber$replaceAfter$secondNumber$replaceAfter$suffix"
        $newPath = Join-Path -Path $file.DirectoryName -ChildPath $newName
        Rename-Item -Path $file.FullName -NewName $newName
    }
}

Write-Host "Files renamed successfully."
