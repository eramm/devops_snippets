#!/bin/bash - 
#===============================================================================
#
#          FILE: list_eips.sh
# 
#         USAGE: ./list_eips.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 12/04/21 19:43
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
aws ec2 describe-addresses --query 'Addresses[*].[PublicIp,AssociationId,[Tags[?Key==`Name`].Value]]'


