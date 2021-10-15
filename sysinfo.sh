#!/bin/bash

# Set colors
CYAN='\033[1;36m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
ORANGE='\033[38;5;215m'
NC='\033[0m'

# Get the kernel from uname
kernel=$(uname -r)

# Get the hostname from uname
hostname=$(uname -n)

# Set the distro here
distro=$(cat /etc/*-release | sed -n '/^NAME/p' | sed 's/^.*=//;s/"//g')

# Get the uptime from /proc/uptime
IFS=. read -r s _ < /proc/uptime
# convert to day hour minute
d=$((s / 60 / 60 / 24))
h=$((s / 60 / 60 % 24))
m=$((s / 60 % 60))
s=$((s % 60))

# Distro Specific: Package Count & Ascii Art

#Arch Linux
[ "$distro" == "Arch Linux" ] && packages=$(pacman -Qq | wc -l) &&
l1="${CYAN}       /\\       ${NC}" &&
l2="${CYAN}      /  \\      ${NC}" &&
l3="${CYAN}     /\\   \\     ${NC}" &&
l4="${CYAN}    /      \\    ${NC}" &&
l5="${CYAN}   /   ,,   \\   ${NC}" &&
l6="${CYAN}  /   |  |   \\  ${NC}" &&
l7="${CYAN} /_-''    ''-_\\ ${NC}"
l8=""

[ "$distro" == "Fedora" ] && packages=$(rpm -qa | wc -l) &&
l1="${BLUE}    %%%%%%%%%%%%%     ${NC}" &&
l2="${BLUE}  %%%%%%%${NC}dffffffb${BLUE}%%   ${NC}" &&
l3="${BLUE} %%%%%%%%${NC}lfl${BLUE}%%%${NC}bfb${BLUE}%%% ${NC}" &&
l4="${BLUE}%%%%%%%%%${NC}lfl${BLUE}%%%%%%%%%%${NC}" &&
l5="${BLUE}%%%%${NC}dfffflfffl${BLUE}%%%%%%%%${NC}" &&
l6="${BLUE}%%%${NC}dfP${BLUE}%%%${NC}lfl${BLUE}%%%%%%%%%%${NC}" &&
l7="${BLUE} %%${NC}qfb${BLUE}%%%${NC}lfl${BLUE}%%%%%%%%% ${NC}" &&
l8="${BLUE}  %%${NC}qffffffP${BLUE}%%%%%%%   ${NC}" &&
l9="${BLUE}    %%%%%%%%%%%%%      ${NC}"

[ "$distro" == "Ubuntu" ] && packages=$(dpkg-query -l | wc -l) &&
l1="${ORANGE}           _   ${NC}" &&
l2="${ORANGE}      ----(_)  ${NC}" &&
l3="${ORANGE}   _/  ---  \\  ${NC}" &&
l4="${ORANGE}  (_) |   | |  ${NC}" &&
l5="${ORANGE}    \\  --- _/  ${NC}" &&
l6="${ORANGE}     -----(_)  ${NC}" &&
l7="" &&
l8=""

# Get the window manager
wm=$(xprop -root | sed -n '/^_NET_WM_NAME/p' | sed 's/^.*= //;s/"//g')
[ -e $wm ] && wm=$XDG_CURRENT_DESKTOP

echo -e "$l1"
echo -e "$l2 User: ${YELLOW}$USER@$hostname${NC}"
echo -e "$l3 OS: ${YELLOW}$distro${NC} on ${YELLOW}Linux-$kernel${NC}"
echo -e "$l4 Uptime: ${YELLOW}${d}d${h}h${m}m${s}s${NC}"
echo -e "$l5 Packages: ${YELLOW}$packages${NC}"
echo -e "$l6 Window Manager: ${YELLOW}$wm${NC}"
echo -e "$l7"
echo -e "$l8"
[ -n "$l9" ] && echo -e "$l9"

exit 0
