#!/usr/bin/env bash

printf "\nMaking shell changes...\n\n"
printf "To make the same changes for root, run with sudo\n"

#Check for fortune
#When testing on old VM's I couldn't apt install fortune
#This works on newer images. Will look into this later
if ! command -v fortune &> /dev/null
then
    printf "Fortune is not installed. Installing now (you may need to enter root password)...\n"
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


#Add cows!
sudo mv /usr/share/cowsay/cows/ /usr/share/cowsay/cows_backup/
printf "\nBackuped original .cows to /usr/share/cowsay/cows_backup\n"

#After installing oh-my-sh, you get dropped back in ~/. 
cp -r cows/ /tmp/cows/
cp Modified_Funky_Theme.txt /tmp/Modified_Funky_Theme.txt
sudo mv /tmp/cows/ /usr/share/cowsay/cows/
printf "New .cows moved to /usr/share/cowsay\n"

#Check for oh-my-zsh
if [ -e ~/.oh-my-zsh/README.md ]
then
   printf "\noh-my-zsh is already installed... moving on...\n"
else
   printf "\nInstalling oh-my-zsh for user $USER \n"
   cd ~
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended &> /dev/null
fi

#backing-up/adding theme
mv ~/.oh-my-zsh/themes/funky.zsh-theme ~/.oh-my-zsh/themes/funky.zsh-theme.bak
printf "Backed up original funky theme to ~/.oh-my-zsh/themes/funky.zsh-theme.bak\n"

#Moving custom theme
mv /tmp/Modified_Funky_Theme.txt ~/.oh-my-zsh/themes/funky.zsh-theme
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

printf "\nSetup Complete! Restart the terminal to see changes\n\n"
