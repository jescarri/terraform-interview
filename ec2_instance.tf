resource "aws_instance" "app-instance" {
  count = 3
  // Amazon Linux 2 ami in us-west-2
  ami                    = "ami-a6cfeede"
  iam_instance_profile   = aws_iam_instance_profile.myapp.name
  instance_type          = "t4g.nano"
  monitoring             = false
  subnet_id              = var.subnet_ids[count.index]
  user_data              = data.cloudinit_config.user_data.rendered
  vpc_security_group_ids = [aws_security_group.sg.id]

  root_block_device {
    volume_size = 100
    volume_type = "gp3"
  }

  tags = tomap(
    {
      "Environment" = var.environment,
      "Name"        = format("myapp-%02d", count.index + 1),
    }
  )

  volume_tags = tomap(
    {
      "Environment" = var.environment,
      "Name"        = format("myapp-%02d", count.index + 1),
    }
  )


}

resource "aws_iam_instance_profile" "myapp" {
  name = "my-app"
  role = aws_iam_role.myapp.name
}

resource "aws_iam_role" "myapp" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  name               = "myapp"
}

resource "aws_iam_role_policy" "myapp" {
  name   = "my-app"
  policy = data.aws_iam_policy_document.iamAccess.json
  role   = aws_iam_role.myapp.id
}
