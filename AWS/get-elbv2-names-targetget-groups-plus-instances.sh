#!/bin/bash - 
#===============================================================================
#
#          FILE: get-elbv2-names-targetget-groups-plus-instances.sh
# 
#         USAGE: ./get-elbv2-names-targetget-groups-plus-instances.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 08/02/21 20:10
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

## IN HINDSITE I SHOULD HAVE PRINTED TO FILE AND GREPED EVERYTHING OUT INSTAED OF THE REPEATED CALLS :-(
# get LB name
# get LB info from elb
# get LB info from elbv2 (target group)
# get TG info host/port
# translate id to name
# print array

## generate a list - aws elbv2 describe-load-balancers --query LoadBalancers[*].LoadBalancerName --output text | tr '\t' '\n' > list.tsv

########################################

filename="$1"
outfile="$2"

#change delimiter to comma
IFS=,
# sed -i 's/[\t ]//g;/^$/d' "$filename"
while read -r line; do
    unset lbattribs

    #get ELB name
    echo "ELB name is  - $line"
    lbattribs=("$line")

    #Get DNS name
    echo "Get DNS name"
    dnsname=$(aws elbv2 describe-load-balancers --names $line --query LoadBalancers[*].DNSName --output text)
    lbattribs+=($dnsname)

    # Get Scheme type
    echo "Get Scheme type"
    scheme=$(aws elbv2 describe-load-balancers --names $line --query LoadBalancers[*].Scheme --output text)
    lbattribs+=($scheme)

    #get LB arn
    echo "get LB arn"
    echo "$line"
    lbarn=$(aws elbv2 describe-load-balancers --names $line --query LoadBalancers[*].LoadBalancerArn --output text)

   # get all tg names and assoiated arns

   aws elbv2 describe-target-groups --load-balancer-arn $lbarn --query TargetGroups[*].[TargetGroupName,TargetGroupArn]  --output text | tr -s ' ' > alltgnames.txt

        while read -r tgnamesarns; do
             
            tgname=$(echo $tgnamesarns | awk '{print $1 }')
            tgarn=$(echo $tgnamesarns | awk '{print $2}')

            lbattribs+=($tgname)
            # lbattribs+=($tgarn)

         tginst=$(aws elbv2 describe-target-health --target-group-arn $tgarn --query 'TargetHealthDescriptions[*].Target[]' --output text > alltginstances.txt)
    #     echo $tginst

            while read -r tginst; do
                ec2instance=$(echo $tginst | awk '{print $1 }')
                ec2instanceport=$(echo $tginst | awk '{print $2}')

                ## EXPERITMENTAL CODE 

                ec2instance=$(aws ec2 describe-instances --filters --instance-ids $ec2instance --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`]| [0].Value]' --output text )

                lbattribs+=($ec2instance)
                lbattribs+=($ec2instanceport)
            done < ./alltginstances.txt
            rm -f ./alltginstances.txt

        done < ./alltgnames.txt
        
        rm -f ./alltgnames.txt  

    echo "${lbattribs[*]}" >>$outfile
done <"$filename"

