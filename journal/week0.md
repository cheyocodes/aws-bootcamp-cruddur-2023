# Week 0 — Billing and Architecture

## Required Homework
### Install and verify AWS CLI 
A screenshot of my gitpod account with the environment variables used to configure the AWS CLI. 
![](./assets//week-0/gitpod-env-vars.png)

Sending a request to my AWS account that returns information about the current IAM identity being used. 
![AWS CLI Setup](./assets/week-0/aws-cli-gitpod-config.png)

### Create a Billing Alarm using CLI
Created an SNS topic for a billing alarm using the AWS CLI. The script to create the topics can be found [here](/aws/json/create-billing-alarm-topic.sh).

![Billing Alarm Topic](./assets/week-0/billing-alarm-topic.png)


Subscribed the SNS topic created above to the email where I want the notifications sent using the AWS CLI. The script can be found [here](/aws/json/create-sns-topic-subscription.sh).

![SNS Topic Subscription](./assets/week-0/sns-topic-subscription.png)

