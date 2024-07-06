$res = Invoke-WebRequest 'https://azure.microsoft.com/en-us/blog/content-type/announcements/'
$parsedLinks = $res.Links.href | Get-Unique
$blogLinks = 'blog/.*'
$links = ($parsedLinks | Select-String $blogLinks -AllMatches).Matches
$urls = foreach($url in $links){
    $url.Value -replace 'blog/author/.*', '' -replace 'blog/content-type/announcements/', '' -replace 'blog/', '' | Where-Object {$_.Trim() -ne ""}
}

$finalUrls = foreach ($url in $urls ) {
    "https://azure.microsoft.com/en-us/blog/$url"
} 

$finalUrls