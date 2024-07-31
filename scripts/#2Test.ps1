# Adjust for the correct method if available
$url = "https://pokemoncard.io/deck/dragon-s-ascent-sglc-semi-gym-leader-challenge-35788"
$web = New-Object HtmlAgilityPack.HtmlWeb

try {
    $page = $web.LoadFromWebAsync($url).Result
    Write-Output "Page loaded successfully"
} catch {
    Write-Output "Error loading page: $_"
}
