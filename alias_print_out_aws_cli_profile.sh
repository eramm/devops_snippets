grep profile ~/.aws/config | sed -ne 's/^\[profile\s\(.*\)\]/export AWS_PROFILE=\1/p'
