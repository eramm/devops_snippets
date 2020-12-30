aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query 'Reservations[*].Instances[*].[InstanceId, InstanceType,KeyName, LaunchTime,PrivateIpAddress, PrivateDnsName, PublicDnsName, PublicIpAddress,SecurityGroups[*].GroupName,[Tags[?Key==`Name`].Value] [0][0] ]' --output text > my.tsv


## use sed to get everything on one line sed -i '$!N;s/\n/\t/' my.tsv
