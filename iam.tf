resource "aws_iam_user" "user" {
    for_each = local.users
    name = each.key
}

resource "aws_iam_access_key" "access_key" {
    for_each = local.users
    user = aws_iam_user.user[each.key].name
}

resource "aws_iam_group" "groups" {
    for_each = local.users
    name = "${each.key}_group"
}

resource "aws_iam_group_membership" "group_membership" {
    for_each = local.users
    name = "${each.key} group membership"
    users = [ aws_iam_user.user[each.key].name ]
    group = aws_iam_group.groups[each.key].name
}