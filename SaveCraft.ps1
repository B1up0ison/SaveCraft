function StartMenu{
Write-Host " ---------------------------------------------------------------"
Write-Host " | Welcome to my Minecraft2USB Script!                         |"
Write-Host " | ***********************************                         |"
Write-Host " |    What would you like to do?          ^     ^              |"
Write-Host " |      ---------------------            / \___/ \             |"
Write-Host " | 1. Move Saves between PC and USB     |    '  ' |            |"
Write-Host " | 2. Automatic Mode (wip)              |   --^-- |  @BluKatZ  |"
Write-Host " | 3. Help                               \_______/             |"
Write-Host " | 4. Quit                                                     |"
Write-Host " ---------------------------------------------------------------"
}
$UserName = $env:USERNAME                                           #Detects computer user name
$PCPath = "C:\Users\$UserName\AppData\Roaming\.minecraft\saves"     #Creates path to local users minecraft save files
function Start-MCDrive{                                             #Start program
    while($True){                               
        StartMenu                                                   #Menu Option
        $Choice = Read-Host -Prompt "Please enter a valid number: "
        switch($Choice){
            "1" {
                Clear-Host
                $Drivename = Read-Host -Prompt "What is the letter of your External Drive that you are playing from? (F:/D:/E:/...?)"
                $DrivePath = -join("$Drivename", ":\saves")         #Adds and or creates the \saves folder to path     

                Write-output "$PCPath"
                Write-output "$DrivePath"
                $ChangePath = Read-Host -Prompt "We have detected the following USB and PC Paths would you like to change them? (y/n)?"

                if ($ChangePath -eq 'y'){
                    $PCPath = Read-Host -Prompt "What is the full path of your \saves files on PC"
                    Write-output "Your minecraft PC saves path is: $PCPath"
                    $DrivePath = Read-Host -Prompt "What is the full path of the USB Drive you wish to play from/to"
                    Write-output "Your minecraft USB saves path is: $DrivePath"
                }
                
                $Swap = Read-Host -Prompt "Would you like to move saves from PC to USB (y) or USB to PC (n)?"
                if ($Swap -eq 'y'){                     
                    Write-output "`nWe have found the following worlds in your folder:"
                    Get-ChildItem -Path $PCPath | Select-Object -ExpandProperty Name
                    $WorldNames = Read-Host -Prompt "Please enter the name of the worlds you wish to transfer (Make sure to seperate with commas: World1,World2,etc) or type 'all' for all worlds"
                    
                    if ($WorldNames -eq 'all'){  #we want to fail fast, so simplest special case is handled first
                       & robocopy $PCPath $DrivePath /MIR
                    }else{
                        $Worlds = $WorldNames.Split(",")
                        foreach ($world in $Worlds){
                        $NewPCPath = -join("$PCPath", "\$World")
                        Write-output "$NewPCPath"
                        & robocopy $NewPCPath $DrivePath /MIR
                        }
                    }
                }elseif ($Swap -eq 'n') {
                    Write-output "`nWe have found the following worlds in your folder:"
                    Get-ChildItem -Path $DrivePath | Select-Object -ExpandProperty Name
                    $WorldNames = Read-Host -Prompt "Please enter the name of the worlds you wish to transfer (Make sure to seperate with commas: World1,World2,etc) or type 'all' for all worlds"
                    if ($WorldNames -eq 'all'){
                        & robocopy $DrivePath $PCPath /MIR
                    }else{
                        $Worlds = $WorldNames.Split(",")
                        foreach ($world in $Worlds){
                        $NewUSBPath = -join("$DrivePath", "\$World")
                        Write-output "$NewUSBPath"
                        #we also need the code for the usb saves worlds then
                        & robocopy $NewUSBPath $PCPath /MIR 
                        }

                    }   
                Write-output "Transferring worlds:"
                $Worlds
                #Performance Mode: & robocopy $PCPath $DrivePath /MIR /MT:  and then launch minecraft
                } 
            }
            "2"{ 
                Clear-Host
                Write-output "You have chosen automatic mode"
            }
            "3"{
                Clear-Host
                Write-host "You have chosen option: 4"
                Write-Host " ---------------------------------------------------- "
                Write-Host " | Which command would you like more information on? |"
                Write-Host " ---------------------------------------------------- "
                Write-Host " | 1. Move Saves between PC and USB                  |"
                Write-Host " | 2. Automatic Mode (wip)                           |"
                Write-Host " | 3. Quit                                           |"
                Write-Host " ---------------------------------------------------- "
                $HelpChoice = Read-Host -Prompt "Help Choice:"

                switch($HelpChoice){
                    "1" {
                        Write-Host "This options moves the '/saves` files from PC onto your .minecraft folder on your USB or vice versa"
                    }
                    "2" {
                        Write-Host "This is an experimental mode which runs command 1, then executes minecraft on your PC, `nthen runs in background and waits for you to terminate minecraft before running command 2, and then command 6 (Quit)"
                    }
                    "3"{
                        exit
                    }
                }
            }
            "4"{
                Clear-Host
                Write-host "You have chosen option: 3"
                exit 
            }
        }
    }
}
Start-MCDrive