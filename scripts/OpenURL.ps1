# Specify the URL you want to open
#$URL = "https://pokemoncard.io/deck/muddy-waters-sglc-semi-gym-leader-challenge-35660"
#curl $URL
#Add-Type -AssemblyName System.Windows.Forms
#Add-Type -AssemblyName System.Drawing

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Select a URL"
$form.Size = New-Object System.Drawing.Size(400, 250)
$form.StartPosition = "CenterScreen"

# Create radio buttons
$radioButton1 = New-Object System.Windows.Forms.RadioButton
$radioButton1.Location = New-Object System.Drawing.Point(20, 30)
$radioButton1.Size = New-Object System.Drawing.Size(350, 20)
$radioButton1.Text = "Muddy Waters - SGLC Semi Gym Leader Challenge"
$radioButton1.Tag = "https://pokemoncard.io/deck/muddy-waters-sglc-semi-gym-leader-challenge-35660"
$form.Controls.Add($radioButton1)

$radioButton2 = New-Object System.Windows.Forms.RadioButton
$radioButton2.Location = New-Object System.Drawing.Point(20, 60)
$radioButton2.Size = New-Object System.Drawing.Size(350, 20)
$radioButton2.Text = "Dark Cycle - SGLC Semi Gym Leader Challenge"
$radioButton2.Tag = "https://pokemoncard.io/deck/dark-cycle-sglc-semi-gym-leader-challenge-35671"
$form.Controls.Add($radioButton2)

$radioButton3 = New-Object System.Windows.Forms.RadioButton
$radioButton3.Location = New-Object System.Drawing.Point(20, 90)
$radioButton3.Size = New-Object System.Drawing.Size(350, 20)
$radioButton3.Text = "Rainbow Deck - SGLC Semi Gym Leader Challenge"
$radioButton3.Tag = "https://pokemoncard.io/deck/rainbow-deck-sglc-semi-gym-leader-challenge-35669"
$form.Controls.Add($radioButton3)

# Create a button
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(150, 150)
$button.Size = New-Object System.Drawing.Size(100, 30)
$button.Text = "Go"
$form.Controls.Add($button)

# Button click event
$button.Add_Click({
    $selectedRadioButton = $form.Controls | Where-Object { $_.Checked -eq $true }
    if ($selectedRadioButton) {
        Start-Process $selectedRadioButton.Tag
    } else {
        [System.Windows.Forms.MessageBox]::Show("Please select a URL.", "Warning")
    }
})

# Show the form
[void] $form.ShowDialog()
