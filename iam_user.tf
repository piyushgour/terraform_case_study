
# IAM User with Limited Permissions (needs separate policy definition)
resource "aws_iam_user" "web_server_user" {
  name = "web-server-user"
}

# IAM Policy for Web Server User (define specific permissions here)
resource "aws_iam_policy" "web_server_restart" {
  name = "web-server-restart-policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances",
        "ec2:SendCommand"
      ],
      "Resource": [
        "arn:aws:ec2:*:*:instance/reboot"
      ]
    }
  ]
}
EOF
}

# IAM Policy Attachment
# resource "aws_iam_user_policy_attachment" "web_server_restart" {
#   user_arn = aws_iam_user.web_server_user.arn
#   policy_arn = aws_iam_policy.web_server_restart.arn
# }