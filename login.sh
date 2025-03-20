!/bin/bash

Users_File="cloud_storage/users.txt"
Log_File="cloud_storage/cloud_log.txt"
output_dir="cloud_storage/"

# Ensure output directory and files exist
mkdir -p "$output_dir" && touch "${output_dir}users.txt" "${output_dir}cloud_log.txt"

# Function to log activity
log_activity() {
    echo "$(date '+%Y/%m/%d %H:%M:%S') $1" >> "$Log_File"
}

# Check for active session from log
active_user=$(grep "LOGIN: INFO" "$Log_File" | awk '{print $7}' | tail -1)
last_login_line=$(grep -n "LOGIN: INFO" "$Log_File" | grep "$active_user" | tail -1 | cut -d: -f1)
last_logout_line=$(grep -n "LOGOUT: INFO" "$Log_File" | grep "$active_user" | tail -1 | cut -d: -f1)

if [ -n "$active_user" ] && { [ -z "$last_logout_line" ] || [ "$last_login_line" -gt "$last_logout_line" ]; }; then
    echo "Error: User $active_user is currently logged in. Please wait until they log out."
    exit 1
fi

# User login
read -p "Enter username: " username
read -s -p "Enter password: " password
echo

if grep -q "^$username;$password" "$Users_File"; then
    log_activity "LOGIN: INFO User $username logged in"
    echo "Login successful."
else
    log_activity "LOGIN: ERROR Failed login attempt on user $username"
    echo "Error: Invalid username or password."
    exit 1
fi

# Logout function
logout() {
    log_activity "LOGOUT: INFO User $username logged out"
    echo "Logout successful."
    exit 0
}

while true; do
    read -p "Logout? " option

    case $option in
        [Yy] )
            logout
            ;;
  esac
done

