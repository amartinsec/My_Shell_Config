#!/usr/bin/env bash

printf "\nMaking shell changes... This will make changes to the user's shell who ran this.\n\n"
printf "To make the same changes for root, run with sudo\n"

#Check for fortune
if ! command -v fortune &> /dev/null
then
    printf "Fortune is not installed. Installing now (you may need to enter in sudo password)...\n"
    sudo apt-get install fortune -y &> /dev/null
else
    printf "Fortune already installed. Moving on...\n"
fi


#Check for cowsay
if ! command -v cowsay &> /dev/null
then
    printf "Cowsay is not installed. Installing now...\n"
    sudo apt-get install cowsay -y &> /dev/null
else
    printf "Cowsay already installed. Moving on...\n"
fi

#Check for oh-my-zsh

if [ -e ~/.oh-my-zsh/README.md ]
then
   printf "oh-my-zsh is already installed... moving on...\n"
else
   printf "Installing oh-my-zsh for user $USER \n"
   cd ~
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
   printf "oh-my-zsh installed!\n"
fi

#Add cows!
#Backups original cows to /usr/share/cowsay/cows_backup
sudo mv /usr/share/cowsay/cows/ /usr/share/cowsay/cows_backup/
printf "\nBackuped origional .cows to /usr/share/cowsay/cows_backup\n"

#Move custom cows to cowsay dir
sudo cp -r cows/ /usr/share/cowsay/cows/
printf "New .cows moved to /usr/share/cowsay\n"

#backing-up/adding theme
mv ~/.oh-my-zsh/themes/funky.zsh-theme ~/.oh-my-zsh/themes/funky.zsh-theme.bak
printf "Backed up origional funky theme to ~/.oh-my-zsh/themes/funky.zsh-theme.bak\n"

#Moving custom theme
cp Modified_Funky_Theme.txt ~/.oh-my-zsh/themes/funky.zsh-theme
printf "\nAdded modified funky theme...\n"

#Add hidden directory for alias scripts
mkdir ~/.shellscripts
echo "#!/bin/bash" > ~/.shellscripts/moo.sh
echo "fortune | cowsay -f \$(ls /usr/share/cowsay/cows | shuf -n1)" >> ~/.shellscripts/moo.sh
printf "\nMade ~./shellscripts directory for aliases\n"
printf "Made ~./shellscripts/moo.sh. Will add alias \"moo\" for moo.sh\n"
printf "moo.sh prints a random .cow with a fortune quote\n"


#Making changes to .zshrc
printf "\nMaking changes to the .zshrc file...\n"
sed -i '/ZSH_THEME=/c\ZSH_THEME="funky"' ~/.zshrc
sed -i '/plugins=(/c\plugins=(git colorize catimg)' ~/.zshrc
echo "alias moo=\"bash ~/.shellscripts/moo.sh\"" >> ~/.zshrc
echo "moo" >> ~/.zshrc

printf "\nSetup Complete!\n\n"
