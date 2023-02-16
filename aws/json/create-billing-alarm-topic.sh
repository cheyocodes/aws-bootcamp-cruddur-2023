# We need an SNS topic before we can create an alarm 
# The SNS topic is what will delivery an alert when the threshold is surpassed
aws sns create-topic --name "AWS-Bootcamp-Billing-Alarm-Topic"