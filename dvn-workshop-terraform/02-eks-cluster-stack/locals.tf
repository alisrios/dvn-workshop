locals {
  eks_oidc_url = replace(aws_iam_openid_connect_provider.kubernetes.url, "https://", "")
}