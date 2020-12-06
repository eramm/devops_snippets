aws ec2 describe-network-interfaces --filters Name=group-id,Values=sg-33b16441 --query 'NetworkInterfaces[*].Attachment.InstanceId'
