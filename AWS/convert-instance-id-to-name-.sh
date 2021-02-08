aws ec2 describe-instances --filters --instance-ids i-00e11a05a49517ab2 --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`]| [0].Value]' --output text
