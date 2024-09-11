data "aws_iam_policy_document" "iamAccess" {
  statement {
    actions = [
      "*",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}


data "cloudinit_config" "user_data" {

  part {
    content_type = "text/cloud-config"
    content      = templatefile("${path.module}/cloud-init/cloud-init-ssh.yaml", {})
  }

  part {
    content_type = "text/cloud-config"
    content      = templatefile("${path.module}/cloud-init/cloud-init-pkgs.yaml", {})
  }
  part {
    content_type = "text/cloud-config"
    content      = templatefile("${path.module}/cloud-init/cloud-init-users.yaml", {})
  }

}
