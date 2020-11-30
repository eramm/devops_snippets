aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query 'Reservations[*].Instances[*].[InstanceId,VpcId]
