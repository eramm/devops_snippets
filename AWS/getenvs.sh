#!/bin/bash - 
#===============================================================================
#
#          FILE: getenvs.sh
# 
#         USAGE: ./getenvs.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 18/05/21 15:43
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
grep profile ~/.aws/config | sed -ne 's/^\[profile\s\(.*\)\]/export AWS_PROFILE=\1/p'"

