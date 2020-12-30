aws ec2 describe-volumes --region us-east-1 --query "Volumes[?Attachments[?AttachTime<='2016-11-01']].{ID:VolumeId}" --output text

The following command issues a query for volumes that were most recently attached before the cutoff date
