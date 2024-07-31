# Install the Selenium module if you haven't already
#Install-Module -Name Selenium -Force -Scope CurrentUser

# Import the Selenium module
Import-Module Selenium

# Start a new browser instance
$driver = Start-SeChrome

# Navigate to the URL
$driver.Navigate().GoToUrl("https://pokemoncard.io/deck/muddy-waters-sglc-semi-gym-leader-challenge-35660")

# Give the page some time to load
Start-Sleep -Seconds 5

# Find the <textarea> element by XPath
$textarea = $driver.FindElementByXPath("/html/body/main/div/div[2]/form/textarea")

# Extract and print the content
if ($textarea -ne $null) {
    $content = $textarea.Text.Trim()
    Write-Output "Content of the <textarea>:"
    Write-Output $content
} else {
    Write-Output "No <textarea> element found with the specified XPath."
}

# Close the browser
$driver.Quit()

