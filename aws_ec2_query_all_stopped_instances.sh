aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query 'Reservations[*].Instances[*].[InstanceId, InstanceType,KeyName, LaunchTime,PrivateIpAddress, PrivateDnsName, PublicDnsName, PublicIpAddress,SecurityGroups,[Tags[?Key==`Name`].Value] [0][0] ]

