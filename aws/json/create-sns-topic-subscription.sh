aws sns subscribe \
    --topic-arn arn:aws:sns:us-east-1:$AWS_ACCOUNT_ID:AWS-Bootcamp-Billing-Alarm-Topic \
    --protocol email \
    --notification-endpoint $AWS_ACCOUNT_EMAIL