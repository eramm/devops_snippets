aws ec2 describe-network-interfaces --filters Name=group-id,Values=sg-123456 --output json -- query 'NetworkInterfaces[*].{ InstanceId: Attachment.InstanceId, GroupNames: Groups[*].GroupName }'
