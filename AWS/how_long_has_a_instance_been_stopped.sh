aws ec2 describe-instances --filter "Name=instance-state-name,Values=stopped" --query 'Reservations[*].Instances[*].[InstanceId, StateTransitionReason]' --output text
