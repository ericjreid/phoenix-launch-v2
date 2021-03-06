<#
----------v1 reminders--------
    The PhoenixLaunch script (which could be renamed something like Start-PhoenixLaunch or something?)
    is currently designed to accept input from the user for a line-separated list of files/folders to reopen.
    
    So for current field use, we have
    STEP 1 -> User creates a file with a line-separated list of files to reboot. Known as the REBOOT LIST.
    STEP 2 -> User Reboots or calls a "Restart Computer" script (not yet developed)
    STEP 3 -> After Reboot: User gets the full file path handy (such as C:\ejrReboot\20170106.txt or C:\ejrReboot\RebootListTemplate.txt)
    STEP 4 -> Start button --> Type "PowerShell" --> Choose "Windows PowerShell ISE" 
    STEP 5 --> File --> Open --> [Path] C:\Users\ereid\Dropbox\ejrDev\ejrPowershell\PhoenixLaunch.ps1
    STEP 6 --> Select all code in this "PhoenixLaunch" file --> Hit F8 to run selection --> set the focus in the pop-up window's textbox, then paste the file path for the reboot list and complete.
    
    []Desired feature - ability to include a commenting system that is ignored (like "hey this is the browser - restart the tabs that were saved" or "this folder should be used to open as website in vs"
#>

<# 
---OLD INNARDS OF PHOENIXLAUNCHv1 with TextBox input for varying rebootlist location---------
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form 
$form.Text = "Data Entry Form"
$form.Size = New-Object System.Drawing.Size(300,200) 
$form.StartPosition = "CenterScreen"

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20) 
$label.Size = New-Object System.Drawing.Size(280,20) 
$label.Text = "Please enter the file path to the REBOOT LIST below:"
$form.Controls.Add($label) 

$textBox = New-Object System.Windows.Forms.TextBox 
$textBox.Location = New-Object System.Drawing.Point(10,40) 
$textBox.Size = New-Object System.Drawing.Size(260,20) 
$form.Controls.Add($textBox) 

$form.Topmost = $True

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $rebootListFilePath = $textBox.Text
    $rebootListFilePath
    
    $rebootList = (Get-Content $rebootListFilePath) 
    
    $rebootList.Length #number of reboot objects gets printed to console for verification 
    
    #invoke (launch) each object in the REBOOT LIST
    foreach ($obj in $rebootList) 
    {
        ii $obj
    }    
}
#>

function PhoenixLaunch {
    $rebootListFilePath = "C:\ejrReboot\RebootList.txt"
    
    Write-Host ""#add line break
    Write-Host "----------------" -BackgroundColor "Black" -ForegroundColor "White"#add visual separator
    
    Write-Host -NoNewLine "RebootList (FilePath) ==> " $rebootListFilePath #writehost -nonewline displays string literal + variable's value (all on same line)
    Write-Host ""#add line break
    Write-Host ""#add line break
    
    $rebootList = (Get-Content $rebootListFilePath) #Get-Content (text) on that variable and store it in rebootList    
    
    Write-Host -NoNewLine "Reboot List Length (# of entries)" $rebootList.Length #number of reboot objects gets printed to console for verification (number of lines?)
    Write-Host ""#add line break
    Write-Host "----------------"  -BackgroundColor "Black" -ForegroundColor "White"#add visual separator
    $rebootList #now print to console the whole list
    Write-Host ""#add line break
    Write-Host "----------------"  -BackgroundColor "Black" -ForegroundColor "White"#add visual separator
    
    #invoke (launch) each object in the REBOOT LIST
    foreach ($obj in $rebootList) 
    {
        ii $obj
    }  

}#end PhoenixLaunch function (should use powershell naming conventions?)


PhoenixLaunch

