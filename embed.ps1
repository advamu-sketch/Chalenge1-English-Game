$dir = 'C:\Users\advam\Documents\A.Muller\CloudeCode\Chalenge1-English Game'
$images = @('Marchell.png','Rocky.png','Rubbel.png','Ryder.png','Sky.png')
$html = [System.IO.File]::ReadAllText("$dir\game.html", [System.Text.Encoding]::UTF8)

foreach ($img in $images) {
    $path = Join-Path $dir $img
    $bytes = [System.IO.File]::ReadAllBytes($path)
    $b64 = 'data:image/png;base64,' + [Convert]::ToBase64String($bytes)
    $html = $html.Replace("src=`"$img`"", "src=`"$b64`"")
}

$out = Join-Path $dir 'game-standalone.html'
[System.IO.File]::WriteAllText($out, $html, [System.Text.Encoding]::UTF8)
Write-Host "Done! File size:" ([Math]::Round((Get-Item $out).Length / 1MB, 1)) "MB"
