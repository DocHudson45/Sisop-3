#!/bin/bash

Users_File="cloud_storage/users.txt"
log_file="cloud_storage/cloud_log.txt"

echo "*******************************************************************"
echo "Welcome to Sign Up page."
echo "Fill your username and password"
echo -e  "Note :\t Minimal 8 Karakter, mengandung 1 huruf kapital,"
echo -e  " \t satu karakter spesial, password tidak sama dengan username"
echo -e  " \t tidak mengandung kata 'cloud' dan 'storage'."
echo "*******************************************************************"
echo
echo
echo "Please enter your username"
read name
log_activity() {
	echo "$(date '+%Y/%m/%d %H:%M:%S') $1" >> "$log_file"
}

# buka file .log, kalau ada, kasih warning
if grep -q "^$name;" "$Users_File"; then
    	log_activity "REGISTER: ERROR User already exists"
    	echo "Username sudah terdaftar! Silakan gunakan nama lain."
    	exit 1
                                                                                                                                                            	>
	fi

echo "Please enter your password"    
read -s password

while true; do
	if [[ ${#password} -lt 8 ]]; then
    	log_activity "REGISTER: ERROR Password minimal 8 characters"
    	echo "Password harus minimal 8 karakter!"
    	exit 1
	elif [[ ! $password =~ [A-Z] ]]; then
    	log_activity "REGISTER: ERROR Password minimal one capital letter"
    	echo "Password harus mengandung setidaknya satu huruf kapital!"
    	exit 1
	elif [[ ! $password =~ [0-9] ]]; then
    	echo "Password harus mengandung setidaknya satu angka!"
    	log_activity "REGISTER: ERROR Password must contain atleat one digit"
    	exit 1
	elif [[ ! $password =~ [@#\$%^\&*] ]]; then
    	log_activity "REGISTER: ERROR Password minimun 1 special character"
    	echo "Password harus mengandung setidaknya satu karakter spesial (@, #, $, dll.)!"
    	exit 1
	elif [[ $password == $name ]]; then
    	log_activity "REGISTER: ERROR Password cannot be the same as the username"
    	echo "Password tidak boleh sama dengan username!"
    	exit 1
	elif [[ $password =~ cloud || $password =~ storage ]]; then
    	log_activity "REGISTER: ERROR Password must not contain the word 'cloud' or 'storage'"
    	echo "Password tidak boleh mengandung kata 'cloud' atau 'storage'!"
    	exit 1
	else
    	break
	fi
done
log_activity "REGISTER: INFO User registered successfully"
echo "$name;$password" >> "$Users_File"

echo "Your sign up was successful"
echo "Username : $name"
echo "Password : $password"
