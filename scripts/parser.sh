#!/bin/bash - 
set -o nounset                              # Treat unset variables as an error
filename="$1"
# sggroup="$2"
while read -r line; do
  
  #userfile=$( echo $line | grep -i -E -o  "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" | awk -F"@" '{print $1}')
  #echo "$userfile"
  rmail=$(echo $line | grep -i -E -o  "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b")
  usename=$(echo $rmail | awk -F"@" '{print $1}')

  [ -n "$rmail" ] && echo "$line" > $usename.txt
  
 
done < "$filename"

