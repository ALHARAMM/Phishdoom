##Phishdoom Tool

##Overview

Phishdoom is a phishing tool designed for targeting social media accounts, including Facebook, Instagram, and Gmail. It enables black hat hackers to harvest credentials and access sensitive information from unsuspecting users.

##Features

Multi-platform Support: Target popular social media platforms.
Customizable Login Pages: Create traditional and themed login pages for different platforms.
Real-time Credential Harvesting: Monitor and capture login information as users attempt to log in.
Automatic File Management: Automatically manage captured data files for easy access.

##Requirements:

PHP
Curl
OpenSSH
Unzip

You can install these dependencies using the following command:

`sudo apt update && sudo apt install php curl openssh unzip -y`

##Installation

Clone the repository or download the Phishdoom script.

Navigate to the directory containing the script.

Make the script executable:

`chmod +x Phishdoom.sh`

##Run the script:

`./Phishdoom.sh`

##Usage

Upon execution, the script will check for required dependencies.
Select the desired social media platform (Facebook, Instagram, or Gmail).
Choose the type of phishing page you want to use.
The tool will start a local server and generate a link that you can share with the victim.
Monitor the logs for captured IP addresses and login credentials.

##Acknowledgements

Phishdoom is inspired by the need for education in cybersecurity and ethical hacking. Always strive to use your skills responsibly.

Copyright: © @ALHARAM
Version: v2.3
