resource "aws_route53_zone" "boooo0_shop" {
  name = "boooo0.shop"
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "*.boooo0.shop"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_record" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.boooo0_shop.zone_id
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [ for record in aws_route53_record.cert_record : record.fqdn ]
}

resource "aws_route53_record" "entry_point" {
  zone_id = aws_route53_zone.boooo0_shop.zone_id
  name = "www"
  type = "A"

  alias {
    name = aws_lb.my_lb_1.dns_name
    zone_id = aws_lb.my_lb_1.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "request_domain"{
  zone_id = aws_route53_zone.boooo0_shop.zone_id
  name = "request"
  type = "A"

  alias {
    name = aws_lb.my_lb_2.dns_name
    zone_id = aws_lb.my_lb_2.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "db_domain" {
  zone_id = aws_route53_zone.boooo0_shop.zone_id
  name = "db"
  type = "CNAME"
  ttl = 300
  records = [ aws_db_instance.my_db.address ]
}