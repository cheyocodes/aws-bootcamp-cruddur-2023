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

Created cloudwatch alarm to get trigger when the account exceed $50. The script can be found [here](/aws/json/create-put-metric-alarm.sh).
![Alarm Config](./assets/week-0/cloudwatch-alarm.png)

---
### Create a Budget using CLI 
Created a budget for the bootcamp using the AWS CLI. The script can be found [here](/aws/json/create-aws-budget.sh)

![AWS Bootcamp Budget](./assets/week-0/aws-bootcamp-budget.png)

Created another budget *manually* using the AWS Console to track credits spent. 
![Credits Spent Budget](./assets/week-0/manual-credits-tracking-budget.png)

### Recreate Conceptual Diagram
Created conceptual of the Cruddur application. The Conceptual diagram is used to communicate at a high level the architecture to key stakeholders.
You can view the draw.io diagram [here](https://drive.google.com/file/d/15cWSBZz4jM5zQJwyXq8xmXrAvgPgpqkQ/view?usp=sharing).


![Conceptual Diagram](./assets/week-0/cruddur-conceptual-diagram-week-0.png)



### Recreate Logical Diagram 
Created the logical diagram of the Cruddur application. The Logical diagram is used to communicate the broad strokes  of the technical architecture to engineers.
You can view the draw.io diagram [here](https://drive.google.com/file/d/1MhepxEIkr9vtsjyM5FIulpOMj5dMzHPX/view?usp=sharing).

![Logical Diagram](./assets/week-0/cruddur-logical-diagram.png)
