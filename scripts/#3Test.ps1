$textarea = $page.DocumentNode.SelectSingleNode("//textarea[@class='export-deck-list-list']")

if ($textarea -ne $null) {
    Write-Output "Found <textarea> element"
} else {
    Write-Output "No <textarea> element with class 'export-deck-list-list' found"
}
