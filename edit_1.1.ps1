param(
    [string]$file
)
If( -not (Test-Path(".\$file"))) {
    Write-Output("File not found.")
    Write-Output("Exiting edit.")
    exit
}
Write-Output("[edit]: Welcome to edit. type `"help`"")
while(1) {
    $prompt = read-host -prompt [edit]
    if($prompt -eq "exit") {
        Write-Output("Exiting edit.")
        exit
    }
    if($prompt.StartsWith("add")) {
        if($file -ne "") {
            $lineadd = $prompt
            [regex]$pattern = "add "
            $lineadd = $pattern.Replace($lineadd, "", 1)
            Add-Content -Path ".\$file" -Value "$lineadd"
            Get-Content ".\$file"
        }
        if($file -eq "") {
            Write-Output("[edit]: No file selected")
        }
    }
    if($prompt -eq "help") {
        Write-Output("[edit]: Commands (case-sensitive)
[edit]: help: Shows this menu
[edit]: add <string>: Adds text to the selected file
[edit]: exit: Exits edit
[edit]: sel <string>: Selects a file
[edit]: read: Reads the contents of the selected file
[edit]: clear: Clears the selected file"
        )
    }
    if($prompt.StartsWith("sel")) {
        $file = $prompt
        [regex]$pattern = "sel "
        $file =  $pattern.Replace($file,"",1)
        Write-Output("Selected file $file")
    }
    if($prompt -eq "read") {
        if($file -eq "") {
            Write-Output("[edit]: No file selected")
        }
        if($file -ne "") {
            Get-Content(".\$file")
        }
    }
    if($prompt -eq "clear") {
        if($file -ne "") {
            Clear-Content -LiteralPath ".\$file"
            Write-Output("[edit]: Cleared file `"$file`"")
        }
        if($file -eq "") {
            Write-Output("[edit]: No file selected")
        }
    }
    if($prompt -eq "list") {
        Get-ChildItem
    }
    if($prompt.StartsWith("new")) {
        $filename = $prompt
        [regex]$pattern = "new "
        $filename = $pattern.Replace($filename,"",1)
        New-Item -Name "$filename"
    }
    if($prompt.StartsWith("fold")) {
        $filename = $prompt
        [regex]$pattern = "fold "
        $filename = $pattern.Replace($filename,"",1)
        New-Item -ItemType Directory -name "$filename"
    }
    if($prompt.StartsWith("cd")) {
        $filename = $prompt
        [regex]$pattern = "cd "
        $filename = $pattern.Replace($filename,"",1)
        cd $filename
    }
         
}