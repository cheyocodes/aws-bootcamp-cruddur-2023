# Week 0 — Billing and Architecture

## Overview
This week, we have been preparing for the bootcamp by completing various tasks. These include configuring initial settings, managing costs, designing different types of architectural diagrams, learning about cloud security, and gaining a general understanding of the Cruddur application and its components.

---

### Required Homework
The following required homework tasks have been completed:  
- [X] Install and verify the AWS CLI on gitpod workspaces
- [X] Create Billing and Budget Alarms using CLI 
- [X] Re-create Cruddur's Conceputual Diagram 
- [X] Re-create Cruddur's Logical Diagram 


## Install and verify AWS CLI 
To install the AWS CLI on our gitpod workspace we added a gitpod **task** using by adding the following configuration into our `.gitpod.yml` file: 

```yml
tasks:
  - name: aws-cli
    env:
      AWS_CLI_AUTO_PROMPT: on-partial
    init: |
      cd /workspace
      curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
      unzip awscliv2.zip
      sudo ./aws/install
      cd $THEIA_WORKSPACE_ROOT
...
```

Gitpod [tasks](https://www.gitpod.io/docs/configure/workspaces/tasks) are shell scripts that runs on top of the Docker image Gitpod configures to run your workspace. When this docker image is run, Gitpod initialize the script defined in the `init` section of the `tasks` configuration block. This includes installing the AWS CLI and changing to the root directory of our project stored in the `THEIA_WORKSPACE_ROOT`. 

The next step is to give the AWS CLI the account information it needs so that it has access to our AWS account. We do this by setting environment variables and storing them in a special location where Gitpod stores secrets using the `gp env` command followed by the environment variable name.

```sh
gp env AWS_ACCOUNT_ID="123456789101"
gp env AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
gp env AWS_SECRET_ACCESS_KEY="wJalrXUtnMEIF/K7MDENG/bPxRfiCYEXAMPLEKEY"
gp env AWS_DEFAULT_REGION="your-region" # e.g. us-east-1
gp env AWS_ACCOUNT_EMAIL="your-user-email@gmail.com" 
```

We can view these variables in your gitpod account under * User Settings / Variables / Environment Variables*.

Here's a screenshot of my gitpod account with the environment variables used to configure the AWS CLI. 
![Gitpod Account Variables](./assets//week-0/gitpod-env-vars.png)

Next time we log into our account Gitpod will have access to the values injected into the environment variables we defined previously. 

Here's a snapshot that shows the result of executing the `aws sts get-caller-identity` command.
![AWS CLI Setup](./assets/week-0/aws-cli-gitpod-config.png)

## Create a Billing Alarm using the AWS CLI
We create billing alarms to monitor the estimated charges against our AWS accounts using **Amazon CloudWatch** and the **Simple Notification Service (SNS)**. Here's a high level illustration depicting the relationship between CloudWatch alarms and the Simple Notificatio Service.
![CloudWatch and SNS](./assets/week-0/billing-alarm-architecture.png)


Created an SNS topic for a billing alarm using the AWS CLI.

The bash script to create the topics can be found [here](/aws/json/create-billing-alarm-topic.sh).
```sh
aws sns create-topic --name "AWS-Bootcamp-Billing-Alarm-Topic"
```

![Billing Alarm Topic](./assets/week-0/billing-alarm-topic.png)


Once we create a topic we establish a subscription, which is the email where we want to receive billin notifications.

The script can be found [here](/aws/json/create-sns-topic-subscription.sh).
```sh
aws sns subscribe \
    --topic-arn arn:aws:sns:us-east-1:$AWS_ACCOUNT_ID:AWS-Bootcamp-Billing-Alarm-Topic \
    --protocol email \
    --notification-endpoint $AWS_ACCOUNT_EMAIL
```


Created cloudwatch alarm to get trigger when the account exceed $50. 

Finally, we create a cloudwatch metric using the `alarm-config.json` file found down below and associate the topic we previously created by referencing it's *Amazon Resource Name (ARN)*, e.g. `"arn:aws:sns:us-east-1:152720000000:AWS-Bootcamp-Billing-Alarm-Topic"`. 

![Alarm Config](./assets/week-0/cloudwatch-alarm.png)
```sh
aws cloudwatch put-metric-alarm --cli-input-json file://alarm-config.json
```
The script can be found [here](/aws/json/create-put-metric-alarm.sh).

```sh
{
    "AlarmName": "DailyEstimatedCharges",
    "AlarmDescription": "This alarm would be triggered if the daily estimated charges exceeds 50$",
    "ActionsEnabled": true,
    "AlarmActions": [
        "arn:aws:sns:us-east-1:152720000000:AWS-Bootcamp-Billing-Alarm-Topic"
    ],
    "EvaluationPeriods": 1,
    "DatapointsToAlarm": 1,
    "Threshold": 50,
    "ComparisonOperator": "GreaterThanOrEqualToThreshold",
    "TreatMissingData": "breaching",
    "Metrics": [{
        "Id": "m1",
        "MetricStat": {
            "Metric": {
                "Namespace": "AWS/Billing",
                "MetricName": "EstimatedCharges",
                "Dimensions": [{
                    "Name": "Currency",
                    "Value": "USD"
                }]
            },
            "Period": 86400,
            "Stat": "Maximum"
        },
        "ReturnData": false
    },
    {
        "Id": "e1",
        "Expression": "IF(RATE(m1)>0,RATE(m1)*86400,0)",
        "Label": "DailyEstimatedCharges",
        "ReturnData": true
    }]
}
```

![SNS Topic Subscription](./assets/week-0/sns-topic-subscription.png)


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
