$headers = @{
    'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
    'Referer' = 'https://www.pinterest.com/'
}

$response = Invoke-WebRequest -Uri 'https://www.pinterest.com/pin/771593348701911234/' -Headers $headers -UseBasicParsing

# Search for video URLs
$videoMatches = [regex]::Matches($response.Content, '(https://v1\.pinimg\.com[^"'']+\.mp4)')
Write-Output "=== VIDEO URLs ==="
foreach ($m in $videoMatches) { Write-Output $m.Value }

# Search for GIF URLs
$gifMatches = [regex]::Matches($response.Content, '(https://i\.pinimg\.com[^"'']+\.gif)')
Write-Output "`n=== GIF URLs ==="
foreach ($m in $gifMatches) { Write-Output $m.Value }

# Search for high-res image URLs
$imgMatches = [regex]::Matches($response.Content, '(https://i\.pinimg\.com/originals/[^"'']+)')
Write-Output "`n=== ORIGINALS URLs ==="
foreach ($m in $imgMatches) { Write-Output $m.Value }
