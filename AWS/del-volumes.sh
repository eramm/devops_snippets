#!/bin/bash - 
#===============================================================================
#
#          FILE: volumes.sh
# 
#         USAGE: ./volumes.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 08/12/20 20:28
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
filename="$1"
# sggroup="$2"
while read -r line; do

  echo "Volume read from file - $line"

    aws ec2 delete-volume --volume-id $line

done < "$filename"
