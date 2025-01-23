resource "aws_iam_user" "lb" {
  for_each = toset (["jenny","jisoo","lisa","rose","jenny","lisaa"])
name = each.value
  
} resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  users = [
    for i in aws_iam_user.lb : i.name
  ]

  group = aws_iam_group.group.name
}

resource "aws_iam_group" "group" {
  name = "blackpink"
}