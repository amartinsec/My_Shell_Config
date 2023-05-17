#!/usr/bin/env bash

echo "Making shell changes... This will make changes to the user's shell who ran this."
echo "To make the same changes for root, run with sudo"

#Check for fortune
if ! command -v fortune &> /dev/null
then
    echo "Fortune is not installed. Installing now..."
    sudo apt-get install fortune -y &> /dev/null
else
    echo "Fortune already installed. Moving on..."
fi


#Check for cowsay
if ! command -v cowsay &> /dev/null
then
    echo "Cowsay is not installed. Installing now..."
    sudo apt-get install cowsay -y &> /dev/null
else
    echo "Cowsay already installed. Moving on..."
fi

#Check for oh-my-zsh

if [ -e ~/.zshrc ]
then
   echo "oh-my-zsh is already installed... moving on"
else
   echo "Installing oh-my-zsh for user $USER"
   cd ~
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   echo "oh-my-zsh installed!"
fi

#Add cows!
#Backups original cows to /usr/share/cowsay/cows_backup
sudo mv /usr/share/cowsay/cows/ /usr/share/cowsay/cows_backup/
echo "Backuped origional .cows to /usr/share/cowsay/cows_backup"

#Move custom cows to cowsay dir
sudo cp -r cows/ /usr/share/cowsay/cows/
echo "New .cows moved to /usr/share/cowsay"

#backing-up/adding theme
mv ~/.oh-my-zsh/themes/funky.zsh-theme ~/.oh-my-zsh/themes/funky.zsh-theme.bak
echo "Backed up origional funky theme to ~/.oh-my-zsh/themes/funky.zsh-theme.bak"

#Moving custom theme
mv Modified_Funky_Theme.txt ~/.oh-my-zsh/themes/funky.zsh-theme
echo "Added modified funky theme..."

#Add hidden directory for alias scripts
mkdir ~/.shellscripts
echo "#!/bin/bash" > ~/.shellscripts/moo.sh
echo "fortune | cowsay -f \$(ls /usr/share/cowsay/cows | shuf -n1)" >> ~/.shellscripts/moo.sh
echo "Made ~./shellscripts dir for aliases"
echo "Made ~./shellscripts/moo.sh. Will add alias \"moo\" for moo.sh"
echo "moo.sh just prints a random .cow with a fortune quote"


#Making changes to .zshrc
echo "Making changes to the .zshrc file..."
sed -i '/ZSH_THEME=/c\ZSH_THEME="funky"' ~/.zshrc
sed -i '/plugins=(/c\plugins=(git colorize catimg)' ~/.zshrc
echo "alias moo=\"bash ~/.shellscripts/moo.sh\"" >> ~/.zshrc
echo "moo" >> ~/.zshrc

echo "Setup Complete!"
