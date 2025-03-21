#!/bin/bash

# Array berisi 20 link (contoh dummy)
LINKS=(
"https://authentic-indonesia.com/wp-content/uploads/2019/07/borobudur-temple.jpg"
"https://authentic-indonesia.com/wp-content/uploads/2019/07/komodo-national-park-area.jpg"
"https://authentic-indonesia.com/wp-content/uploads/2019/07/kelimutu-lakes.jpg"
"https://authentic-indonesia.com/wp-content/uploads/2019/07/carstezn-pyramid-jayawijaya-1024x444.jpg"
"https://authentic-indonesia.com/wp-content/uploads/2019/07/prambanan-temple-natural-wonder-of-indonesia-1024x683.jpg"
"https://authentic-indonesia.com/wp-content/uploads/2019/07/bali-island.jpg"
"https://authentic-indonesia.com/wp-content/uploads/2019/07/bromo-mountain-1024x683.jpg"
"https://authentic-indonesia.com/wp-content/uploads/2019/07/krakatau-islands-nature-reserve-1024x527.jpg"
"https://authentic-indonesia.com/wp-content/uploads/2019/07/lake-toba-natural-wonder-of-indonesia-1024x575.jpg"
"https://lp-cms-production.imgix.net/2022-03/GettyRF_531114869.jpg?auto=format,compress&q=72&w=1024&h=810&fit=crop"
"https://lp-cms-production.imgix.net/2022-03/shutterstockRF_776098807.jpg?auto=format,compress&q=72&fit=crop&w=1024"
"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgKrKsrUhsf8lwJGNz3Snaw4MTVCMjubCZ6A&s"
"https://theworldtravelguy.com/wp-content/uploads/2021/05/DJI_0165.jpg"
"https://theworldtravelguy.com/wp-content/uploads/2024/10/DJI_0410_1200-6.jpg"
"https://theworldtravelguy.com/wp-content/uploads/2021/06/DSCF4546.jpg"
"https://theworldtravelguy.com/wp-content/uploads/2023/09/DSCF7704-4.jpg"
"https://theworldtravelguy.com/wp-content/uploads/2023/07/DJI_0592-2.jpg"
"https://theworldtravelguy.com/wp-content/uploads/2021/05/DSCF7155.jpg"
"https://theworldtravelguy.com/wp-content/uploads/2021/04/DJI_0126.jpg"
"https://theworldtravelguy.com/wp-content/uploads/2021/03/DSCF1402.jpg"
)

# Random index 0–19
RANDOM_NUM=$(shuf -i 0-19 -n 1)
SELECTED_LINK=${LINKS[$RANDOM_NUM]}

# Debug output
echo "Jumlah link (NUM_LINKS): ${#LINKS[@]}"
echo "Index terpilih (RANDOM_NUM): $RANDOM_NUM"
echo "Link terpilih (SELECTED_LINK): $SELECTED_LINK"

# Jalankan download
echo "Mendownload..."
wget "$SELECTED_LINK"


echo "DOWNLOADED"
