aws budgets create-budget \
    --account-id $AWS_ACCOUNT_ID \
    --budget file://budget.json \
    --notifications-with-subscribers file://budget-notifications-with-subscribers.json