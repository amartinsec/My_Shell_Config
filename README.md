# My Shell Config
For my new VM's 

- Installs Oh-My-ZSH with a [modified funky theme](https://github.com/amartinsec/My_Shell_Config/blob/main/Modified_Funky_Theme.txt)
  - Theme will show `:)` when a process has an exit code of 0, and `:(` for any other exit codes. 
  - [Original theme](https://tsdh.wordpress.com/2007/12/06/my-funky-zsh-prompt/)
- Enables the git, colorize, and catimg plugins
- Installs cowsay with handselected .cow's
- Adds a fortune quote in a random .cow when opening a new shell:
![demo img](https://raw.githubusercontent.com/amartinsec/My_Shell_Config/main/img/demopic.png)

<br>
This will make the changes for the account that executes make_changes.sh.
To make changes for the root account, run with sudo. 

### Use
`chmod +x make_changes.sh` <br>
`./make_changes.sh`
<br>
You can use any .cows you want by adding them to `/usr/share/cowsay/cows`

<br>

Additional .cow's came from https://github.com/paulkaefer/cowsay-files/. I had to trim some of the full-color .cow's to fit nicely in my terminal. 
