#!/bin/bash

filename="$1"
# sggroup="$2"
sed -i 's/#.*$//;/^$/d' $filename

while read -r line; do

  umail=$(echo $line | grep -i -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b")
  u=$(echo $umail | awk -F"@" '{print $1}')

  if [ -n "$u" ]; then
    u=$(echo "$u" | tr '[:upper:]' '[:lower:]')
    # [ -n "$u" ] && echo "$line" >$u.txt
    if getent passwd $u; then
      echo user $u exists
    else
      echo "Adding user $u"

      useradd -m $u -p '*'

      #     sudo rm -f /home/$u/.bash*
      #     sudo cp ./.bash* /home/$u/
      #            chown $u.$u /home/$u/.bash*

      sudo -u $u ssh-keygen -t rsa -b2048 -N "" -f /home/$u/.ssh/id_rsa
      sudo -u $u cat "$u.txt" >/home/$u/.ssh/authorized_keys
      chown $u.$u /home/$u/.ssh/authorized_keys
      sudo -u $u chmod 600 /home/$u/.ssh/authorized_keys

    fi
  fi

done <"$filename"
