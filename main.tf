provider "aws" {
  region = "eu-central-1"
}

#define usernames
variable "username" {
  type = list
  default = ["Eugene", "Milo", "Abigail", "Aidan", "Santiago", "Felix", "Morgan"]
}
#create users
resource "aws_iam_user" "user" {
  count = length(var.username)
  name = element(var.username,count.index )
}

#create roles
resource "aws_iam_role" "ops_role" {
  name = "ops_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
resource "aws_iam_role" "developer_role" {
  name = "developer_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

#define groupnames
variable "groupname" {
  type = list
  default = ["Developers","Ops"]
}
#create group
resource "aws_iam_group" "group" {
  count = length(var.groupname)
  name = element(var.groupname,count.index)
}

#assign users to group
resource "aws_iam_group_membership" "developer_team" {
  name = "developer-membership"

  users = [
    "Eugene", "Milo", "Abigail", "Aidan"
  ]

  group = "Developers"
}
resource "aws_iam_group_membership" "ops_team" {
  name = "ops-membership"

  users = [
    "Santiago", "Felix", "Morgan"
  ]

  group = "Ops"
}

#assign role policy to group
resource "aws_iam_group_policy" "developer_team_policy" {
  name  = "developer_team_policy"
  group = element(var.groupname,0)

  policy = aws_iam_role.developer_role.assume_role_policy
}
resource "aws_iam_group_policy" "ops_team_policy" {
  name  = "ops_team_policy"
  group = element(var.groupname,1)

  policy = aws_iam_role.ops_role.assume_role_policy
}
