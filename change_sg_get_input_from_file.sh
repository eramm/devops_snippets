#!/usr/bin/bash
filename="$1"
sggroup="$2"
while read -r line; do
    
    echo "Instance read from file - $line"
    echo "aws ec2 modify-instance-attribute --instance-id $line --groups $sggroup"
    aws ec2 modify-instance-attribute --instance-id $line --groups $sggroup 
    # aws ec2 modify-instance-attribute --instance-id i-abcdef --groups sg-xxx sg-yyy
done < "$filename"