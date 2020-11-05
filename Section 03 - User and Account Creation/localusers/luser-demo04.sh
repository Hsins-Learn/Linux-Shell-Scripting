#!/bin/bash

# ============================================================
# The main goals of this scripts are:
#   - Create an account on the local system
#   - Prompt user for the account name and password
# ============================================================

# Ask for the user name
read -p 'Enter the username to create: ' USER_NAME

# Ask for the real name
read -p 'Enter the name of the person who this account is for: ' COMMENT

# Ask for the password
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the user
useradd -c "${COMMENT}" -m ${USER_NAME}

# Set the password for the user
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Force password change on first login
passwd -e ${USER_NAME}
