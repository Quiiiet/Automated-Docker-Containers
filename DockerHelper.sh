#!/bin/bash

#functions
createTraditional_container(){
container_name=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 7 | head -n 1)
echo -e "${CYAN}Creating Container...${NC}"
container_id=$(docker create --name "$container_name" "$selected_version" tail -f /dev/null)
echo -e "${GREEN}Container created successfully.${NC}"

echo -e "${CYAN}Starting Container...${NC}"
docker start "$container_id"
echo -e "${GREEN}Container started successfully.${NC}"
echo -e "${GREEN}Your container is ready. You can log in by running the following command:${NC}"
echo -e "${YELLOW}docker exec -it $container_name /bin/bash${NC}"
}

createCusomize_container_UD(){
    local updateCMD=$1
    local installSoftware=$2
    local startSoftware=$3

container_name=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 7 | head -n 1)
echo -e "${CYAN}Creating Container...${NC}"
container_id=$(docker create --name "$container_name" "$selected_version" tail -f /dev/null)
echo -e "${GREEN}Container created successfully.${NC}"

echo -e "${CYAN}Starting Container...${NC}"
docker start "$container_id"
echo -e "${GREEN}Container started successfully.${NC}"
docker exec "$container_id" /bin/bash -c "$updateCMD && $installSoftware && $startSoftware"
echo -e "${GREEN}Your container is ready. You can log in by running the following command:${NC}"
echo -e "${YELLOW}docker exec -it $container_name /bin/bash${NC}"
}

createCusomize_container_CentOS(){
    local updateCMD=$1
    local installSoftware=$2
    local startSoftware=$3

container_name=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 7 | head -n 1)
echo -e "${CYAN}Creating Container...${NC}"
container_id=$(docker create --name "$container_name" "$selected_version" tail -f /dev/null)
echo -e "${GREEN}Container created successfully.${NC}"

echo -e "${CYAN}Starting Container...${NC}"
docker start "$container_id"
echo -e "${GREEN}Container started successfully.${NC}"
docker exec "$container_id" /bin/bash -c "$getConnected && $updateCMD && $installSoftware && $startSoftware"
echo -e "${GREEN}Your container is ready. You can log in by running the following command:${NC}"
echo -e "${YELLOW}docker exec -it $container_name /bin/bash${NC}"
}

createCusomize_container_openSUSE(){
    local updateCMD=$1
    local installSoftware=$2

container_name=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 7 | head -n 1)
echo -e "${CYAN}Creating Container...${NC}"
container_id=$(docker create --name "$container_name" "$selected_version" tail -f /dev/null)
echo -e "${GREEN}Container created successfully.${NC}"

echo -e "${CYAN}Starting Container...${NC}"
docker start "$container_id"
echo -e "${GREEN}Container started successfully.${NC}"
docker exec "$container_id" /bin/bash -c "$updateCMD && $installSoftware"
echo -e "${GREEN}Your container is ready. You can log in by running the following command:${NC}"
echo -e "${YELLOW}docker exec -it $container_name /bin/bash${NC}"
}


GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' 

echo -e "${CYAN}Downloading & Installing Docker...${NC}"
source installDocker.sh | tee dockerInstall_log.txt

echo -e "${CYAN}Q1: Which OS do you want?${NC}"
echo -e "${YELLOW}A: [1]-Ubuntu [2]-openSUSE [3]-CentOS [4]-Custom Image${NC}"
read -p "Enter your choice: " os_choice

case $os_choice in
    1)
        echo -e "${CYAN}Q2: Choose Version for Ubuntu${NC}"
        echo -e "${YELLOW}[1]-Ubuntu 20.04${NC}"
        echo -e "${YELLOW}[2]-Ubuntu 18.04${NC}"
        echo -e "${YELLOW}[3]-Ubuntu 16.04${NC}"
        read -p "Enter your choice: " version_choice

        case $version_choice in
            1)
                selected_version="ubuntu:20.04"
                ;;
            2)
                selected_version="ubuntu:18.04"
                ;;
            3)
                selected_version="ubuntu:16.04"
                ;;
            *)
                echo -e "${RED}Invalid version choice. Exiting...${NC}"
                exit 1
                ;;
        esac
        ;;

    2)
        echo -e "${CYAN}Q2: Choose Version for Debian${NC}"
        echo -e "${YELLOW}[1]-openSUSE Leap${NC}"
        echo -e "${YELLOW}[2]-openSUSE Tumbleweed${NC}"
        read -p "Enter your choice: " version_choice

        case $version_choice in
            1)
                selected_version="opensuse/leap"
                ;;
            2)
                selected_version="opensuse/tumbleweed"
                ;;
            *)
                echo -e "${RED}Invalid version choice. Exiting...${NC}"
                exit 1
                ;;
        esac
        ;;

    3)
        echo -e "${CYAN}Q2: Choose Version for CentOS${NC}"
        echo -e "${YELLOW}[1]-CentOS 8${NC}"
        echo -e "${YELLOW}[2]-CentOS 7${NC}"
        echo -e "${YELLOW}[3]-CentOS 6${NC}"
        read -p "Enter your choice: " version_choice

        case $version_choice in
            1)
                selected_version="centos:8"
                ;;
            2)
                selected_version="centos:7"
                ;;
            3)
                selected_version="centos:6"
                ;;
            *)
                echo -e "${RED}Invalid version choice. Exiting...${NC}"
                exit 1
                ;;
        esac
        ;;

    4)
        read -p "Enter the URL of the custom Docker image: " custom_image_url
        selected_version="$custom_image_url"
        ;;

    *)
        echo -e "${RED}Invalid OS choice. Exiting...${NC}"
        exit 1
        ;;
esac

echo -e "${CYAN}Do you want to install any software?${NC}"
echo -e "${YELLOW}[1]-Yes [2]-No${NC}"
read -p "Enter your choice: " install_choice

if [ "$install_choice" -eq 1 ]
then
    if [ "$os_choice" -eq 1 -o "$os_choice" -eq 2 ]
    then
        echo -e "${CYAN}What software do you want to install?${NC}"
        echo -e "${YELLOW}[1]-Apache2 [2]-Nginx [3]-PostgreSQL [4]-UFW${NC}"
        read -p "Enter your choice: " software_choice

        case $software_choice in
            1)
                software_name="apache2"
                ;;
            2)
                software_name="nginx"
                ;;
            3)
                software_name="postgresql"
                ;;
            4)
                software_name="ufw"
                ;;
            *)
                echo -e "${RED}Invalid software choice. Exiting...${NC}"
                exit 1
                ;;
    esac
    elif [ "$os_choice" -eq 3 ]
    then
                echo -e "${CYAN}What software do you want to install?${NC}"
        echo -e "${YELLOW}[1]-HTTPD [2]-Nginx [3]-PostgreSQL [4]-IPTable${NC}"
        read -p "Enter your choice: " software_choice

        case $software_choice in
            1)
                software_name="httpd"
                ;;
            2)
                software_name="nginx"
                ;;
            3)
                software_name="postgresql"
                ;;
            4)
                software_name="iptables"
                ;;
            *)
                echo -e "${RED}Invalid software choice. Exiting...${NC}"
                exit 1
                ;;
    esac
     else
        echo -e "${RED}Invalid choice. Exiting...${NC}"
        fi

        case $os_choice in
        1)
            updateCMD="apt-get update"
            installSoftware="DEBIAN_FRONTEND=noninteractive apt-get install -y $software_name"
            startSoftware="service $software_name start"
            createCusomize_container_UD "$updateCMD" "$installSoftware" "$startSoftware"
            ;;
        2)
            updateCMD="zypper refresh"
            installSoftware="zypper install -y $software_name"
            createCusomize_container_openSUSE "$updateCMD" "$installSoftware"
            ;;
        3)
       if [[ "$selected_version" == "centos:8" ]]
        then 
            getConnected="cd /etc/yum.repos.d/ && sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*"
            updateCMD="yum update -y"
            installSoftware="yum install -y $software_name"
            startSoftware="service $software_name start"
            createCusomize_container_CentOS "$getConnected" "$updateCMD" "$installSoftware" "$startSoftware"
        elif [[ "$selected_version" == "centos:7" ]]
        then
            getConnected="cd /etc/yum.repos.d/ && sed -i 's/#mirrorlist/mirrorlist/g' /etc/yum.repos.d/CentOS-* && sed -i 's|baseurl=http://vault.centos.org|#baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*"
            updateCMD="yum update -y"
            installSoftware="yum install -y $software_name"
            startSoftware="service $software_name start"
            createCusomize_container_CentOS "$getConnected" "$updateCMD" "$installSoftware" "$startSoftware"
        elif [[ "$selected_version" == "centos:6" ]]
        then
            getConnected="cd /etc/yum.repos.d/ && sed -i 's/#mirrorlist=/mirrorlist=/g' /etc/yum.repos.d/CentOS-* && sed -i 's|baseurl=http://vault.centos.org|#baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*"
            updateCMD="yum update -y"
            installSoftware="yum install -y $software_name"
            startSoftware="service $software_name start"
            createCusomize_container_CentOS "$getConnected" "$updateCMD" "$installSoftware" "$startSoftware"
        else
            echo -e "${RED}Invalid choice. Exiting...${NC}"
        fi
            ;;
    esac
        

elif [ "$install_choice" -eq 2 ]
then
    echo -e "${GREEN}No software will be installed.${NC}"
    echo -e "${CYAN}Pulling Image...${NC}"
docker pull $selected_version
echo -e "${GREEN}Image pulled successfully.${NC}"

characters="Aa0-9"
createTraditional_container
else
    echo -e "${RED}Invalid choice. Exiting...${NC}"
    exit 1
fi