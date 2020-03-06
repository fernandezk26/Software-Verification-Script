#Create installation functions to be used later in the script
Function Adobe {Write-Host "Installing Adobe" -ForegroundColor Yellow
    Start-Job -Name Adobe -ScriptBlock { Start-Process -FilePath "%Installation Path%\adobe.exe" -Verb runAs  -ArgumentList "/sAll","/rs","/msi"}
    Wait-Job -Name Adobe
    start-sleep -Seconds 45
    }
Function Java {Write-Host "Installing Java" -ForegroundColor Yellow
    Start-Job -Name Java -ScriptBlock { Start-Process -FilePath "%Installation Path%\java.exe" -ArgumentList '/s'}
    Wait-Job -Name Java
    start-sleep -Seconds 5
    }
Function *Office* {Write-Host "Installing Manage Engine" -ForegroundColor Yellow
    Start-Job -Name Office -ScriptBlock { msiexec.exe /i "%Installation Path%\office.exe" -ArgumentList '/s'}
    Wait-Job -Name Office
    Write-Host "Done"
    start-sleep -Seconds 5
    }

#Software to be checked. You can check for exact matches if its one word folders, or use the *. For example, *Office* would find Microsoft Office 2016 and would run the *Office* function. 
$softwareList = "Adobe" , "Java", "*Office*"

#loops through each $software in the $softwareList and checks if it exists in one of the specified paths. Prints that it is installed if it is, installs if it is not. I just have it Read-Host at the end
#to verify the results, but you could also do Out-File to a log.txt if you wanted to.
Foreach ($software in $softwareList) 
{
    $path = "C:\Program Files (X86)\" + $software
    $path2 = "C:\Program Files\" + $software

    #stores true or false boolean into $result variable
    $result = Test-Path -Path $path, $path2

    #Checks the 2 paths for the specified folder from the string array $softwares
    if($result -eq $true) {Write-Host "$software is installed!" -ForegroundColor Green}
    
    #Runs specified function as defined above if the software is not installed
    else{&"$software"}
}

Read-Host -Prompt "Press Enter to exit"
