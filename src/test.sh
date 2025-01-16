#!/bin/bash

# Colors for output
RESET="\033[0m"
BOLD="\033[1m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
CYAN="\033[36m"

# Welcome message
echo -e "${CYAN}${BOLD}Hello, welcome to CurlDel!${RESET}"
echo -e "${BLUE}============================================${RESET}"

cat <<'EOF'
            +--------------------+
            |  CurlDel Request   |
            +--------------------+
                   |
                   v
          +-------------------------+
          |    CurlDel response     |
          +-------------------------+
EOF
echo -e "${BLUE}============================================${RESET}"

# Functions for different requests
getRequest(){
    echo -e "${GREEN}You chose GET request.${RESET}"
    echo -e "${YELLOW}Enter endpoint for request:${RESET} "
    read endpoint
    curl -s $endpoint
    echo -e "\n${CYAN}Request complete.${RESET}"
}

postRequest(){
    echo -e "${GREEN}You chose POST request.${RESET}"
    echo -e "${YELLOW}Enter endpoint for request:${RESET} "
    read endpoint
    echo -e "${YELLOW}Enter JSON data for request:${RESET} "
    read jsonData
    curl -s -X POST $endpoint -d "$jsonData" -H "Content-Type: application/json"
    echo -e "\n${CYAN}Request complete.${RESET}"
}

updateRequest(){
    echo -e "${GREEN}You chose PUT request.${RESET}"
    echo -e "${YELLOW}Enter endpoint for request:${RESET} "
    read endpoint
    echo -e "${YELLOW}Enter JSON data for request:${RESET} "
    read jsonData
    curl -s -X PUT $endpoint -d "$jsonData" -H "Content-Type: application/json"
    echo -e "\n${CYAN}Request complete.${RESET}"
}

deleteRequest(){
    echo -e "${GREEN}You chose DELETE request.${RESET}"
    echo -e "${YELLOW}Enter endpoint for request:${RESET} "
    read endpoint
    curl -s -X DELETE $endpoint -H "Content-Type: application/json"
    echo -e "\n${CYAN}Request complete.${RESET}"
}

# Menu
while true; do
    echo -e "${CYAN}Choose an operation:${RESET}"
    echo -e "${BLUE}1.${RESET} GET ${BLUE}2.${RESET} POST ${BLUE}3.${RESET} DELETE ${BLUE}4.${RESET} UPDATE (PUT) ${BLUE}5.${RESET} EXIT"
    echo -e "${CYAN}Enter the operation number (1-5):${RESET}"
    read operation
    
    case $operation in
        1)
            echo -e "${GREEN}You chose GET REQUEST.${RESET}"
            getRequest
        ;;
        2)
            echo -e "${GREEN}You chose POST REQUEST.${RESET}"
            postRequest
        ;;
        3)
            echo -e "${GREEN}You chose DELETE REQUEST.${RESET}"
            deleteRequest
        ;;
        4)
            echo -e "${GREEN}You chose UPDATE (PUT) REQUEST.${RESET}"
            updateRequest
        ;;
        5)
            echo -e "${RED}Exiting...${RESET}"
            exit
        ;;
        *)
            echo -e "${RED}Invalid option! Please choose a number between 1-5.${RESET}"
        ;;
    esac
done
