#!/bin/bash
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# This script can enable 802.1x eap peap mschapv2 on remote RICOH printers
# You can modify as you see fit. 
# By default it will use same username and password for all printers, which is not really recommended.
# Once 802.1x is set printer will drop connection and reestablish connection again. 
# The script will await this, and the script is single threaded.
# Test before use to ensure 802.1x is supported by your infrastructure.
#
# The script will change config for all printers in printers.txt 
# Credentials in printer_config_802.1x.expand must be entered.
#
# The script has been tested on a Windows system with Cygwin and Expect installed via Cygwin.
# The bash script loops through printer in printers.txt and runs the expect script for every printer.		
#
#	Version : 1.05
#	Authors : Christina Espensen & Benjamin Henriksen
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 


for ip in $(cat ./printers.txt)
do
	ping -n 1 $ip 2>/dev/null >/dev/null && { 
	        echo "********************************************************"	
		echo $ip is online!
                echo "********************************************************"
		#printer is alive
		./printer_config_802.1x.exp $ip

		echo "********************************************************"

		while :
		do
			ping -n 1 $ip 2>/dev/null >/dev/null || break
			echo "***" $ip was online, waiting for it to loose connection
			sleep 3
		done
		echo $ip has now lost network connection	
		#printer is now offline
		while :
		do
			ping -n 1 $ip 2>/dev/null >/dev/null && break
			echo $ip was offline, waiting for it to come back online
			sleep 3
		done
		#printer is back online
		echo network connection reestablished to $ip
		echo "********************************************************"
	}
done
