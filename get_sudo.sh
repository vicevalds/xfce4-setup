#!/usr/bin/bash

############################################################
# Help                                                     #
############################################################
Help()
{
   echo -e "\tUSAGE: ./get_sudo.sh -u <user>"
   echo "Syntax: [-hu]"
   echo "Options:"
   echo -e "\th\tPrint help"
   echo -e "\tu\tUser to add to the sudoers file"
}

############################################################
# Process the input options. Add options as needed.        #
############################################################
while getopts ":h:u:" option; do
   case $option in
      h) # Print this help
         Help
         exit 0 ;;
      u) # User name
         USER_NAME=$OPTARG ;;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit 1 ;;
   esac
done

if [[ -z "$USER_NAME" ]]; then
   echo "User option is needed"
   Help
   exit 1
fi

# Add to sudoers file
sudo chmod u+w /etc/sudoers
sudo echo -e "${USER_NAME}\tALL=(ALL:ALL) ALL" >> /etc/sudoers
sudo chmod u-w /etc/sudoers
echo "[!] User ${USER_NAME} added to sudo group"
