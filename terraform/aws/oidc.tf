locals {
  aks_oidc_issuer = "https://eastus.oic.prod-aks.azure.com/32236432-53a4-43df-85e3-53d26b9c8519/720617e5-1c7e-4417-922c-706be732ee12/"
}

data "tls_certificate" "aks_oidc" {
  url = local.aks_oidc_issuer
}

resource "aws_iam_openid_connect_provider" "aks" {
  url = local.aks_oidc_issuer

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    data.tls_certificate.aks_oidc.certificates[0].sha1_fingerprint
  ]
}
