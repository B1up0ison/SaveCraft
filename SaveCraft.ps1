function StartMenu{
Write-Host " ---------------------------------------------------------------"
Write-Host " | Welcome to my Minecraft2USB Script!                         |"
Write-Host " | ***********************************                         |"
Write-Host " |    What would you like to do?          ^     ^              |"
Write-Host " |      ---------------------            / \___/ \             |"
Write-Host " | 1. Move Saves from PC to USB         |    '  ' |            |"
Write-Host " | 2. Move Saves from USB to PC         |   --^-- |  @BluKatZ  |"
Write-Host " | 3. Change paths for saves             \_______/             |"
Write-Host " | 4. Automatic Mode  (wip)                                    |"
Write-Host " | 5. Quick Transfer Mode (wip)                                |"
Write-Host " | 6. Help                                                     |"
Write-Host " | 7. Quit                                                     |"
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
                $Drivename = Read-Host -Prompt "What is the letter of your External Drive that you are playing from? (F:/D:/E:/...?)"
                $DrivePath = -join("$Drivename", ":\saves")         #Adds and or creates the \saves folder to path     
                Write-Output "Your External Drive path to save file is: $DrivePath"
                Write-Output "Your PC path to saves file is: $PCPath"
                & robocopy $PCPath $DrivePath /MIR
            }
            "2" {
                $Drivename = Read-Host -Prompt "What is the letter of your USB Drive? (F:/D:/E:/...?)"
                $DrivePath = -join("$Drivename", ":\saves")          
                Write-Output "Your External Drive path to save file is: $DrivePath"
                Write-Output "Your PC path to saves file is: $PCPath"
                & robocopy $DrivePath $PCPath /MIR
            }
            "3" {
                $DriveName = Read-Host -Prompt "What is the path of the USB Drive you wish to play from/to (Remember to enter it " " included)"
                Write-output "Your minecraft PC saves path is: $DriveName"
                $PCPath = Read-Host -Prompt "What is the full path of your \saves files on PC (Remember to enter it " " included)"
                Write-output "Your minecraft USB saves path is: $DriveName"
            }
            "4" {
                Write-output "you chose choice 4"
            }
            "5" {
                Write-output "you chose choice 5"
            }
            "6" {
                Write-host "You have chosen 5"
                Write-Host " ---------------------------------------------------- "
                Write-Host " | Which command would you like more information on? |"
                Write-Host " ---------------------------------------------------- "
                Write-Host " | 1. Move Saves from PC to USB                      |"
                Write-Host " | 2. Move Saves from USB to PC                      |"
                Write-Host " | 3. Change paths for saves                         |"
                Write-Host " | 4. Automatic Mode                                 |"
                Write-Host " | 5. Go back                                        |"
                Write-Host " ---------------------------------------------------- "
                $HelpChoice = Read-Host -Prompt "Help Choice:"

                switch($HelpChoice){
                    "1" {
                        Write-Host "This options moves the "/saves" files from your PC onto your .minecraft folder on your USB"
                    }
                    "2" {
                        Write-Host "This options moves the "/saves" files from your USB onto your PC"
                    }
                    "3" {
                        Write-Host "This options allows you to changes your "path" to the save folder on your PC and USB"
                    }
                    "4" {
                        Write-Host "This is an experimental mode which runs command 1, then executes minecraft on your PC, `nthen runs in background and waits for you to terminate minecraft before running command 2, and then command 6 (Quit)"
                    }
                }
            }
            "7" {
                Write-host "You have chosen option: 7"
                exit 
            }
        }
    }
}

Start-MCDrive