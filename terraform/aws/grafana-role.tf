data "aws_iam_policy_document" "grafana_assume_role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type = "Federated"

      identifiers = [
        aws_iam_openid_connect_provider.aks.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(local.aks_oidc_issuer, "https://", "")}:sub"

      values = [
        "system:serviceaccount:observability:sre-monitoring-grafana"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(local.aks_oidc_issuer, "https://", "")}:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "grafana_cloudwatch" {
  name               = "sre-grafana-cloudwatch-reader"
  assume_role_policy = data.aws_iam_policy_document.grafana_assume_role.json
}

resource "aws_iam_role_policy_attachment" "cloudwatch_read_only" {
  role       = aws_iam_role.grafana_cloudwatch.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}
