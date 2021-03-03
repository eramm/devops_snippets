#!/bin/bash

filename="$1"
# sggroup="$2"
while read -r line; do

    for u in $line; do
        umail=$(echo $line | grep -i -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b")
        u=$(echo $umail | awk -F"@" '{print $1}')

        u=$(echo "$u" | tr '[:upper:]' '[:lower:]')
        if getent passwd $u; then
            echo user $u exists
        else
            echo "Adding user $u"

            sudo useradd -m $u -p '*'

            #     sudo rm -f /home/$u/.bash*
            #     sudo cp ./.bash* /home/$u/
            sudo chown $u.$u /home/$u/.bash*

            sudo -u $u ssh-keygen -t rsa -b2048 -N "" -f /home/$u/.ssh/id_rsa
            sudo -u $u chmod 600 /home/$u/.ssh/authorized_keys

        fi
    done

done <"$filename"
