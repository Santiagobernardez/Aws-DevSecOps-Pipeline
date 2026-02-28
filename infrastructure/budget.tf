# infrastructure/budgets.tf

# Create a monthly cost budget to monitor AWS spending
resource "aws_budgets_budget" "cost_alert" {
  name              = "devsecops-monthly-budget"
  budget_type       = "COST"
  limit_amount      = "5.0"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"

  # Define the notification trigger (e.g., when 80% of the $5 limit is reached)
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["santiabernardez0@gmail.com"]
  }
}