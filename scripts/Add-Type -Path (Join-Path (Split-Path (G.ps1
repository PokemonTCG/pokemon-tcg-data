Add-Type -Path (Join-Path (Split-Path (Get-Package -Name HtmlAgilityPack).Source) "lib/net45/HtmlAgilityPack.dll")



# Add the path to the HtmlAgilityPack DLL
Add-Type -Path "Path\To\HtmlAgilityPack.dll"

# Define the URL to scrape
$url = "https://pokemoncard.io/deck/dragon-s-ascent-sglc-semi-gym-leader-challenge-35788"

# Load the web page
$web = New-Object HtmlAgilityPack.HtmlWeb
$page = $web.Load($url)

# Select the specific <textarea> element
$textarea = $page.DocumentNode.SelectSingleNode("//textarea[@class='export-deck-list-list']")

if ($textarea -ne $null) {
    # Extract and output the content
    $content = $textarea.InnerText.Trim()
    Write-Output "Content of <textarea>:"
    Write-Output $content
} else {
    Write-Output "No <textarea> element with class 'export-deck-list-list' found on the page."
}
