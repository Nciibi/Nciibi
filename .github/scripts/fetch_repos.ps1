$repos = Invoke-RestMethod 'https://api.github.com/users/Nciibi/repos?per_page=100&type=owner'
foreach ($r in $repos) {
    if ($r.name -eq 'Nciibi') { continue }
    $desc = if ($r.description) { $r.description } else { 'No description provided' }
    $lang = if ($r.language) { $r.language } else { 'N/A' }
    Write-Output ("- [**{0}**]({1}) - {2} ``{3}``" -f $r.name, $r.html_url, $desc, $lang)
}
