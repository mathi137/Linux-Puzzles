#!/bin/sh

WORKDIR=/usr/local/bin
USER_FILE="users.txt"
GROUP_NAME="levels"

if [ "$(id -u)" -ne 0 ]; then
  echo "Please run as root or use sudo"
  exit 1
fi

# Ensure the group exists
if ! getent group "$GROUP_NAME" >/dev/null 2>&1; then
  addgroup "$GROUP_NAME"
  echo "Group $GROUP_NAME created."
fi

# Loop through the users.txt file and create users
while IFS=: read -r username password; do
  # Add the user without interaction
  adduser -D -G "$GROUP_NAME" -s /bin/ash "$username"
  
  # Set the user's password
  echo "$username:$password" | chpasswd
done < "$USER_FILE"

