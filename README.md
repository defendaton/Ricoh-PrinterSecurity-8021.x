

## 802.1x on printers

			Authors: Christina Alfast Espensen & Benjamin Henriksen

Enables 802.1x eap peap mschapv2 on RICOH printers.
By default the script uses the same username and password for all printers, which is not really recommended. 
Once 802.1x is set printer will drop connection and reestablish connection again. 
The script will await this and is single threaded. Thus if the connection cannot be reestablished the script does not continue automatically.

Test before usage to ensure 802.1x is supported by your infrastructure.
The script will change the configuration for all printers listed in printers.txt.
If the printer fails to reconnect, test if the port supports 802.1x. If the port reconnects, please ensure you remember to disable any existing port based whitelisting. 

The script has been tested on a Windows system with Cygwin and the Expect Cygwin package.
 
## Usage
Populate the text file printers.txt with the printers in scope. One on each line.
Edit the credentials in printer_config_802.1x.exp as described in the Credentials section.


## Examples
To enable 802.1x on all printers in printers.txt run:

		printer_config_802.1x.sh
    
## Credentials
By default it will use same username and password for all printers, which is not really recommended.
Credentials are listed in printer_config_802.1x.exp, edit this to fit your setup:

		set PrinterUserName "<Enter username here>";
		set PrinterPassword "<Enter password here>";
		set 8021xUserName "<Enter username here>";
		set 8021xPassword "<Enter password here>";

The first set of credentials is to access the printer, the second is the 802.1x credentials.

## Known "issues"
The script will stop when a printer is not coming back online after enabling 802.1x. This is to limit any potential unwanted effects.
 
## Version & License
Version 1.05
Release date: 21-10-2019
License: BSD 3-Clause
