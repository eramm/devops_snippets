#!/usr/bin/bash
set -o nounset # Treat unset variables as an error
filename="$1"
srg="Blob-poc-rg"
drg="A_Blob-poc-rg-BACKUP"
while read -r azvm; do

    echo "VM name read from file - $azvm"

    osdisk=$(az vm show -d -g "$srg" -n "$azvm" --query "storageProfile.osDisk.managedDisk.id")
    extdisk=$(az vm show -d -g "$srg" -n "$azvm" --query "storageProfile.osDisk.managedDisk.id")
    echo "OS disk is $osdisk"
    echo "ext Disk is $extdisk"

    # check if answer is blank

    if [[ $osdisk =~ ^\/[a-z].* ]]; then
        az snapshot create -g "$drg" -n "$azvm.OSdisk" --source "$osdisk"
        else
            echo "$azvm" has no OS disk
    fi 



     if [[ $extdisk =~ ^\/[a-z].* ]]; then
        az snapshot create -g "$drg" -n "$azvm.OSdisk" --source "$extdisk"
        else
            echo
    fi
done

done <"$filename"
