#!/bin/bash

# ============================================================
# The main goals of this scripts are:
#   - Displays the UID and username of the user executing this
#     this script.
#   - Displays if the user is the root user or not
# ============================================================

# Display the UID
echo "Your UID is ${UID}"

# Display the username
# ' Note that there is an older syntax to assign the command result
# ' to a variable by using the tick marks:
# ' USER_NAME=`id -un`
USER_NAME=$(id -un)
echo "Your username is ${USER_NAME}"

# Display if the user is the root user or not
if [[ "${UID}" -eq 0 ]]; then
  echo 'You are root.'
else
  echo 'You are not root.'
fi
