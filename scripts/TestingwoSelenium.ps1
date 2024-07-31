$url = "https://pokemoncard.io/deck/dragon-s-ascent-sglc-semi-gym-leader-challenge-35788"
$web = New-Object HtmlAgilityPack.HtmlWeb

try {
    $page = $web.LoadFromWebAsync($url).Result
    Write-Output "Page loaded successfully"

    if ($page -ne $null) {
        # Verify the type of $page
        Write-Output ("Type of `$page: {0}" -f $page.GetType().FullName)

        # Check if DocumentNode is available
        if ($page.DocumentNode -ne $null) {
            Write-Output "DocumentNode is available"

            # Print a snippet of the HTML content for debugging
            $htmlSnippet = $page.DocumentNode.OuterHtml.Substring(0, [Math]::Min(1000, $page.DocumentNode.OuterHtml.Length))
            Write-Output "HTML content snippet:"
            Write-Output $htmlSnippet

            # Extract the content using the full XPath
            $textarea = $page.DocumentNode.SelectSingleNode("/html/body/main/div/div[2]/form/textarea")

            if ($textarea -ne $null) {
                $content = $textarea.InnerText.Trim()
                Write-Output "Content of the <textarea>:"
                Write-Output $content
            } else {
                Write-Output "No <textarea> element found with the specified XPath."
            }
        } else {
            Write-Output "DocumentNode is null."
        }
    } else {
        Write-Output "Failed to load HTML content."
    }
} catch {
    Write-Output "Error loading page: $_"
}
