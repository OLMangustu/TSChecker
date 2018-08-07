#FUNCTIONS
function Get-TSSessions {
    param(
        $ComputerName = "localhost"
    )

    qwinsta /server:$ComputerName |
    #Parse output
    ForEach-Object {
        $_.Trim() -replace "\s+",","
    } |
    #Convert in CSV
    ConvertFrom-Csv
}

#DEFINIZIONE VARIABILI
$currentfile = c:\temp\rdpcurrfile.txt
$comparefile = c:\temp\rdpcomparefile.txt




Get-TSSessions -ComputerName "localhost" | ? { $_.State -eq 'Active' } | ft -AutoSize SessionName, UserName, ID | Out-File $comparefile


$currentcont = get-content $currentfile
$comparecont = Get-Content $comparefile

$compareobj = Compare-Object $cont1 $cont2 | format-list

if ($compareobj) { write-host Somebody connected}

Remove-Item -path $currentfile -Force
Rename-Item -path $comparefile rdpcurrfile.txt


