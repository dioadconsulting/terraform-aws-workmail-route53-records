resource "aws_route53_record" "txt_amazonses" {
  zone_id = var.zone_id

  name    = "_amazonses"
  type    = "TXT"
  ttl     = "300"
  records = ["${var.domain_verification}"]
}

resource "aws_route53_record" "mx" {
  zone_id = var.zone_id

  name    = ""
  type    = "MX"
  ttl     = "86400"
  records = ["10 inbound-smtp.${var.region}.amazonaws.com."]
}

resource "aws_route53_record" "cname_autodiscover" {
  zone_id = var.zone_id

  name    = "autodiscover"
  type    = "CNAME"
  ttl     = "300"
  records = ["autodiscover.mail.${var.region}.awsapps.com."]
}

resource "aws_route53_record" "cname_dkim" {
  zone_id = var.zone_id

  name    = "${element(var.domain_keys, count.index)}._domainkey"
  type    = "CNAME"
  ttl     = "300"
  records = ["${var.domain_keys[count.index]}.dkim.amazonses.com."]

  count = length(var.domain_keys)
}
