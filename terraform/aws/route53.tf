resource "aws_route53_zone" "boooo0_shop" {
  name = "boooo0.shop"
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "*.boooo0.shop"
  validation_method = "DNS"
}