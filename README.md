# Sysinfo.sh

## This script displays system information for Fedora, Arch Linux, and Ubuntu machines. More distributions can be added trivially.  

Distributions are detected from `/etc/*-release`, piped through sed commands to find the exact distro.  
Window manager/Desktop enviornment is checked using `xprop` and `$XDG_CURRENT_DESKTOP`  

Feel free to add more distributions to the script.
