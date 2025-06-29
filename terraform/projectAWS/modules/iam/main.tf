resource "aws_iam_user" "terraform_user" {
	name = "terraform-created-user"
}

resource "aws_iam_access_key" "terraform_key" {
	user = aws_iam_user.terraform_user.name
}

resource "aws_iam_user_policy_attachment" "admin" {
	user = aws_iam_user.terraform.user_name
	policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
