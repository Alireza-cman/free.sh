#!/bin/bash

downTime=0
lastAccessTime=$(date +"%s")
while [ true ]; do

if ! ping -c1 google.com >& /dev/null; then
    downTime=$(( $(date +"%s") - $lastAccessTime ))
else
    downTime=0
    lastAccessTime=$(date +"%s")

fi

sleep 15

if [ $downTime -ge 40 ]; then
   echo "alert"
   username="alireza.keshavarzian"
   password='123123'


   `curl -k -s -o /dev/null \
   	-X POST \
   	-H "Content-Type: application/x-www-form-urlencoded" \
   	-d "erase-cookie=false&password=$password&popup=false&username=$username" \
   	"https://login.aut.ac.ir/login"`
   code_login=`curl -k -s -o /dev/null -w "%{http_code}" -X GET "https://internet.aut.ac.ir/"`

   if [ $code_login == '302' ]; then
   	echo "[AUTLogin] > Login was successful."
   else
   	echo "[AUTLogin] > Login was failed."
   fi

fi
done
