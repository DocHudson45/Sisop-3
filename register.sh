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
# buka file .log, kalau ada, kasih warning
if grep -q "^$name;" users.txt; then
        echo "Username sudah terdaftar! Silakan gunakan nama lain."
        continue  # Minta input ulang
    fi


echo "Please enter your password"
read -s password 

while true; do
    if [[ ${#password} -lt 8 ]]; then
        echo "Password harus minimal 8 karakter!"
        exit 1
    elif [[ ! $password =~ [A-Z] ]]; then
        echo "Password harus mengandung setidaknya satu huruf kapital!"
        exit 1
    elif [[ ! $password =~ [0-9] ]]; then
        echo "Password harus mengandung setidaknya satu angka!"
        exit 1
    elif [[ ! $password =~ [@#\$%^\&*] ]]; then
        echo "Password harus mengandung setidaknya satu karakter spesial (@, #, $, dll.)!"
        exit 1
    elif [[ $password == $name ]]; then
        echo "Password tidak boleh sama dengan username!"
        exit 1
    elif [[ $password =~ cloud || $password =~ storage ]]; then
        echo "Password tidak boleh mengandung kata 'cloud' atau 'storage'!"
        exit 1
    else
        break 
    fi
done

echo "$name;$password" >> users.txt

echo "Your sign up was succesful"
echo "Username : $name"
echo "Password : $password"
