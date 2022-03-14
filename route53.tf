# Developed by RIVA Solutions Inc 2022.  Authorized Use Only

data "aws_route53_zone" "vpc" {
  name = var.dns_zone
}

resource "aws_route53_zone" "sub_domain" {
  name = local.full_dns_zone

  tags = {
    stack = var.stack
  }
}

resource "aws_route53_record" "ns" {
  zone_id = data.aws_route53_zone.vpc.zone_id
  name    = local.full_dns_zone
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.sub_domain.name_servers
}